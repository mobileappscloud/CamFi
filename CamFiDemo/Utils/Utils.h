//
//  Utils.h
//  CamFiDemo
//
//  Created by Justin on 16/5/29.
//  Copyright © 2016年 CamFi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Utils.h"
#import "AFLog.h"
#import "HUDHelper.h"
#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]

@interface Utils : NSObject

+ (BOOL) isVideoFile:(NSString*) filePath;

@end
