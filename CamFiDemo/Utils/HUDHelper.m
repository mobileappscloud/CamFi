//
//  HUDHelper.m
//  CamFi
//
//  Created by Justin on 16/5/29.
//  Copyright © 2016年 CamFi. All rights reserved.
//

#import "HUDHelper.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation HUDHelper

#pragma mark - Global

+ (void)hudWithView:(UIView*)aView andMessage:(NSString*)aMessage
{
    if (!aView) {

        return;
    }

    [MBProgressHUD hideAllHUDsForView:aView animated:YES];

    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];

    if (aMessage) {

        hud.detailsLabelText = aMessage;
        hud.mode = MBProgressHUDModeText;
        hud.yOffset = aView.bounds.size.height / -4.f;

        [hud hide:YES afterDelay:1];
    }
}

+ (void)hudWithView:(UIView*)aView andError:(NSError*)error
{
    if (!aView) {

        return;
    }

    [MBProgressHUD hideAllHUDsForView:aView animated:YES];

    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = error.localizedDescription;
    hud.labelFont = [UIFont systemFontOfSize:14];
    hud.removeFromSuperViewOnHide = YES;

    [hud hide:YES afterDelay:1.5];
}

+ (void)hudSuccessedAnimationWithView:(UIView*)aView
{
    if (!aView) {
        
        return;
    }
    
    [MBProgressHUD hideAllHUDsForView:aView animated:YES];
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"successful"]];
    
    [hud hide:YES afterDelay:1.5];
}

+ (void)hiddAllHUDForView:(UIView*)aView animated:(BOOL)animated
{
    [MBProgressHUD hideAllHUDsForView:aView animated:animated];
}

+ (void)hiddAllHUDForWindow:(UIWindow *)window animated:(BOOL)animated
{
    [MBProgressHUD hideAllHUDsForView:window animated:animated];
}

@end
