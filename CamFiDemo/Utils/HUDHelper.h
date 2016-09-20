//
//  HUDHelper.h
//  CamFi
//
//  Created by Justin on 16/5/29.
//  Copyright © 2016年 CamFi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AFHTTPRequestOperation;

@interface HUDHelper : NSObject

+ (void)hudWithView:(UIView*)aView andMessage:(NSString*)aMessage;

+ (void)hudWithView:(UIView*)aView andError:(NSError*)error;

+ (void)hudSuccessedAnimationWithView:(UIView*)aView;

+ (void)hiddAllHUDForView:(UIView*)aView animated:(BOOL)animated;

+ (void)hiddAllHUDForWindow:(UIWindow*)window animated:(BOOL)animated;

@end
