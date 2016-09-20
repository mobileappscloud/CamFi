//
//  Utils.m
//  CamFiDemo
//
//  Created by Justin on 16/5/29.
//  Copyright © 2016年 CamFi. All rights reserved.
//

#import "Utils.h"

@implementation Utils

/**
 *  Check the file is video?
 */
+ (BOOL) isVideoFile:(NSString*) filePath {
    NSString *fileSuffix = [[filePath pathExtension] lowercaseString];
    
    if ([fileSuffix isEqualToString:@"mov"]
        || [fileSuffix isEqualToString:@"mp4"]
        || [fileSuffix isEqualToString:@"avi"]) {
        return YES;
    }
    
    return NO;
}

@end
