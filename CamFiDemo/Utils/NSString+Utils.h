//
//  NSString+Utils.h
//  CamFi
//
//  Created by Justin on 16/5/29.
//  Copyright © 2016年 CamFi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Utils)
+ (NSString*)UrlValueEncode:(NSString*)str;
+ (BOOL)isValidateIP:(NSString *)ipAddress;

- (NSString *)trimWhiteSpace;
- (BOOL)isEqualToCaseInsensitiveString:(NSString *)aString;

- (BOOL)isNotEmpty;

- (BOOL)isPureInt;

- (BOOL)isNoStr;

@end
