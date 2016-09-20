//
//  ShootViewController.m
//  CamFiDemo
//
//  Created by Justin on 16/5/29.
//  Copyright © 2016年 CamFi. All rights reserved.
//

#import "ShootViewController.h"
#import "CamFiAPI.h"
#import "Utils.h"

@interface ShootViewController ()

@end

@implementation ShootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shootButtonPressed:(id)sender {
    
    [CamFiAPI camFiTakePicture:^(NSError *error, id responseObject) {
        
        if (error) {
            
            AFLogDebug(@"error:%@", error);
        }
        else {
            
            AFLogDebug(@"responseObject:%@", responseObject);
        }
    }];
}


@end
