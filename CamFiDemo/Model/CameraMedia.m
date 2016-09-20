//
//  CameraMedia.m
//  CamFiDemo
//
//  Created by Justin on 16/5/29.
//  Copyright © 2016年 CamFi. All rights reserved.
//

#import "CamFiServerInfo.h"
#import "CameraMedia.h"
#import "Utils.h"

@implementation CameraMedia

- (id)init
{
    if (self = [super init]) {
        _selected = NO;
        _isVideo = NO;
    }
    return self;
}

- (NSURL*)mediaURL
{
    return [NSURL URLWithString:[[CamFiServerInfo sharedInstance] camFiGetImageByIdUrlString:_mediaPath]];
}

- (NSURL*)mediaOriginalURL
{
    return [NSURL URLWithString:[[CamFiServerInfo sharedInstance] camFiGetRawDataByIdUrlString:_mediaPath]];
}

- (NSURL*)mediaThumbURL
{
    return [NSURL URLWithString:[[CamFiServerInfo sharedInstance] camFiGetThumbnailByIdUrlString:_mediaPath]];
}

+ (instancetype)cameraMediaWithPath:(NSString*)path
{
    CameraMedia* newMedia = [[self alloc] init];
    [newMedia setMediaPath:path];
    [newMedia setIsVideo:[Utils isVideoFile:path]];

    return newMedia;
}

@end
