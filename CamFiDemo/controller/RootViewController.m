//
//  ViewController.m
//  CamFiDemo
//
//  Created by Justin on 16/5/29.
//  Copyright © 2016年 CamFi. All rights reserved.
//

#import "AFHTTPRequestOperation.h"
#import "CamFiAPI.h"
#import "CameraMedia.h"
#import "LiveViewViewController.h"
#import "MWPhotoBrowser.h"
#import "RootViewController.h"
#import "ShootViewController.h"
#import "Utils.h"
#import "AutoViewViewController.h"

#define FEATURE_SHOOT @"Shoot"
#define FEATURE_AUTO_VIEW @"Auto-View"
#define FEATURE_BROWSER_DOWNLOAD @"Browser & Download"
#define FEATURE_LIVE_VIEW @"Live View"
#define FEATURE_CONFIG @"Config"
#define FEATURE_INFO @"Info"

#define FEATURE_ARRAY @[ FEATURE_SHOOT, FEATURE_LIVE_VIEW, FEATURE_BROWSER_DOWNLOAD, FEATURE_AUTO_VIEW ]

@interface RootViewController () <MWPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray* featureArray;

// for browser
@property (nonatomic, strong) NSMutableArray* cameraMediaArray;

@property (nonatomic, strong) NSMutableArray* photos;
@property (nonatomic, strong) NSMutableArray* thumbs;

@property (nonatomic, strong) MWPhotoBrowser* borwser;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellIdentifier"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UIHelper

- (void)showBrowser
{
    [HUDHelper hudWithView:self.view andMessage:nil];
    [CamFiAPI camFiGetImagesWithOffset:0 count:100 completionBlock:^(NSError* error, id responseObject) {

        [HUDHelper hiddAllHUDForView:self.view animated:YES];
        AFLogDebug(@"%@", responseObject);

        self.cameraMediaArray = [NSMutableArray array];
        self.photos = [NSMutableArray array];
        self.thumbs = [NSMutableArray array];

        [responseObject enumerateObjectsUsingBlock:^(NSString* _Nonnull path, NSUInteger idx, BOOL* _Nonnull stop) {

            CameraMedia* media = [CameraMedia cameraMediaWithPath:path];
            if (!media.isVideo) {

                [self.cameraMediaArray addObject:media];
                [self.photos addObject:[MWPhoto photoWithURL:media.mediaURL]];
                [self.thumbs addObject:[MWPhoto photoWithURL:media.mediaThumbURL]];
            }
        }];

        BOOL displayActionButton = YES;
        BOOL displaySelectionButtons = NO;
        BOOL displayNavArrows = NO;
        BOOL enableGrid = YES;
        BOOL startOnGrid = YES;
        BOOL autoPlayOnAppear = NO;

        MWPhotoBrowser* browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        browser.displayActionButton = displayActionButton;
        browser.displayNavArrows = displayNavArrows;
        browser.displaySelectionButtons = displaySelectionButtons;
        browser.alwaysShowControls = displaySelectionButtons;
        browser.zoomPhotosToFill = YES;
        browser.enableGrid = enableGrid;
        browser.startOnGrid = startOnGrid;
        browser.enableSwipeToDismiss = NO;
        browser.autoPlayOnAppear = autoPlayOnAppear;
        [browser setCurrentPhotoIndex:0];
        
        _borwser = browser;

        [self.navigationController pushViewController:browser animated:YES];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.featureArray.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [self.featureArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSString* featureStr = [self.featureArray objectAtIndex:indexPath.row];
    UIViewController* viewController;

    if ([featureStr isEqualToString:FEATURE_BROWSER_DOWNLOAD]) {

        [self showBrowser];
    }
    else {

        if ([featureStr isEqualToString:FEATURE_SHOOT]) {

            viewController = [[ShootViewController alloc] init];
        }
        else if ([featureStr isEqualToString:FEATURE_LIVE_VIEW]) {

            viewController = [[LiveViewViewController alloc] init];
        }
        else if ([featureStr isEqualToString:FEATURE_AUTO_VIEW]) {
            
            viewController = [[AutoViewViewController alloc] init];
        }

        if (viewController) {

            viewController.title = featureStr;
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser*)photoBrowser
{
    return _photos.count;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser*)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser*)photoBrowser thumbPhotoAtIndex:(NSUInteger)index
{
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser*)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index
{
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser*)photoBrowser
{
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoBrowser:(MWPhotoBrowser*)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index
{
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:nil message:@"Download" preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction* originalImageAction = [UIAlertAction actionWithTitle:@"Original Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action) {

        CameraMedia* media = [self.cameraMediaArray objectAtIndex:index];
        [self saveImageWithURL:media.mediaOriginalURL];
    }];

    UIAlertAction* standardImageAction = [UIAlertAction actionWithTitle:@"Standard Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action){

        CameraMedia* media = [self.cameraMediaArray objectAtIndex:index];
        [self saveImageWithURL:media.mediaURL];
    }];
    
    UIAlertAction* thumbImageAction = [UIAlertAction actionWithTitle:@"Thumb Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action){
        
        CameraMedia* media = [self.cameraMediaArray objectAtIndex:index];
        [self saveImageWithURL:media.mediaThumbURL];
    }];

    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* _Nonnull action){

    }];

    [alertController addAction:originalImageAction];
    [alertController addAction:standardImageAction];
    [alertController addAction:thumbImageAction];
    [alertController addAction:cancelAction];

    [photoBrowser presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Download

- (void)saveImageWithURL:(NSURL*)url
{
    [HUDHelper hudWithView:_borwser.view andMessage:nil];
    
    AFHTTPRequestOperation* requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:url]];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation* operation, id responseObject) {

        [self saveImageToAlbumWithImage:responseObject];
    }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {

            AFLogDebug(@"Image error: %@", error);
            [HUDHelper hudWithView:_borwser.view andError:error];
        }];
    [requestOperation start];
}

- (void)saveImageToAlbumWithImage:(UIImage*)image
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied) {
        [HUDHelper hiddAllHUDForView:_borwser.view animated:YES];
        AFLogDebug(@"Please enable the permissions in order to use your Photo Library. Check your permissions in Settings > Privacy > Photos");
        return;
    }
    else if (status == PHAuthorizationStatusRestricted) {
        [HUDHelper hiddAllHUDForView:_borwser.view animated:YES];
        AFLogDebug(@"PHAuthorizationStatusRestricted");
        return;
    }
    else {
        __block NSString* assetId = nil;
        __block PHAssetChangeRequest* request = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            request = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            assetId = request.placeholderForCreatedAsset.localIdentifier;
        }
            completionHandler:^(BOOL success, NSError* _Nullable error) {
                if (!success) {
                    AFLogDebug(@"Save failed: %@", error);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [HUDHelper hudWithView:_borwser.view andError:error];
                    });
                    return;
                }

                PHAsset* asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[ assetId ] options:nil].lastObject;

                PHAssetCollection* collection = [self camFiAssetCollection];
                if (collection == nil) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [HUDHelper hiddAllHUDForView:_borwser.view animated:YES];
                    });
                    return;
                }

                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    [[PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection] addAssets:@[ asset ]];
                }
                    completionHandler:^(BOOL success, NSError* _Nullable error) {
                        if (success) {
                            AFLogDebug(@"Save successfully");
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [HUDHelper hudSuccessedAnimationWithView:_borwser.view];
                            });
                        }
                        else {
                            AFLogDebug(@"Save failed: %@", error);
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [HUDHelper hudWithView:_borwser.view andError:error];
                            });
                        }
                    }];
            }];
    }
}

- (PHAssetCollection*)camFiAssetCollection
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {

        return nil;
    }
    else if (status == PHAuthorizationStatusDenied) {
        AFLogDebug(@"Please enable the permissions in order to use your Photo Library. Check your permissions in Settings > Privacy > Photos");
        return nil;
    }
    else if (status == PHAuthorizationStatusRestricted) {
        AFLogDebug(@"PHAuthorizationStatusRestricted");
        return nil;
    }

    PHFetchResult<PHAssetCollection*>* collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection* collection in collectionResult) {

        if ([collection.localizedTitle isEqualToString:@"CamFi"]) {

            return collection;
        }
    }

    __block NSString* collectionId = nil;
    NSError* error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"CamFi"].placeholderForCreatedAssetCollection.localIdentifier;
    }
                                                         error:&error];

    if (error) {
        return nil;
    }

    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[ collectionId ] options:nil].lastObject;
}

#pragma mark - Items

- (NSArray*)featureArray
{
    if (!_featureArray) {

        _featureArray = FEATURE_ARRAY;
    }

    return _featureArray;
}

@end
