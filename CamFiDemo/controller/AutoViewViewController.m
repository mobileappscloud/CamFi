//
//  AutoViewViewController.m
//  CamFiDemo
//
//  Created by Justin on 16/5/30.
//  Copyright © 2016年 CamFi. All rights reserved.
//

#import "AutoViewViewController.h"
#import "CamFiAPI.h"
#import "CamFiServerInfo.h"
#import "SIOSocket.h"
#import "Utils.h"
#import "UIImageView+WebCache.h"
#import "CameraMedia.h"

@interface AutoViewViewController ()

@property (nonatomic, strong) SIOSocket* socketIO;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation AutoViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self startSocketIO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [CamFiAPI camFiStartReceivePhotos:^(NSError* error) {

        AFLogDebug(@"%@", error);
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [CamFiAPI camFiStopReceivePhotos:^(NSError* error) {

        AFLogDebug(@"%@", error);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SocketIO Delegate
- (void)startSocketIO
{
    if (_socketIO == nil) {
        [SIOSocket socketWithHost:[[CamFiServerInfo sharedInstance] eventURLString] response:^(SIOSocket* socket) {
            NSLog(@"socketIODidConnect:socket connect to server");
            _socketIO = socket;

            [socket on:@"file_added" callback:^(SIOParameterArray* args) {

                AFLogDebug(@"file_added:%@", args);
                CameraMedia* media = [CameraMedia cameraMediaWithPath:args.firstObject];
                [self.imageView sd_setImageWithURL:media.mediaURL placeholderImage:nil];
            }];

            socket.onDisconnect = ^{
                AFLogDebug(@"socket.io disconnected.");
            };
        }];
    }
}

@end
