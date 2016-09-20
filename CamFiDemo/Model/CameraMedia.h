//
//  CameraMedia.h
//  CamFiDemo
//
//  Created by Justin on 16/5/29.
//  Copyright © 2016年 CamFi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CameraMedia : NSObject

@property (nonatomic, copy) NSString* mediaPath;
@property (nonatomic, assign) BOOL isVideo;

@property (nonatomic, assign) BOOL selected;

//@property (nonatomic, assign) CGSize        originalImageSize;

- (NSURL*)mediaURL;
- (NSURL*)mediaOriginalURL;
- (NSURL*)mediaThumbURL;

+ (instancetype)cameraMediaWithPath:(NSString*)path;

@end
