//
//  CamFiAPI.h
//  CamFi
//
//  Created by Justin on 16/5/29.
//  Copyright © 2016年 CamFi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Success_Response_Code   200
@class AFHTTPRequestOperation;
@class RouteModel;

@interface CamFiAPI : NSObject

/*
 * CamFi Live
 */
+ (void) camFiLive:(void (^)(NSError *error)) completionBlock;

/*
 * CamFi Take Picture
 */
+ (void) camFiTakePicture:(void (^)(NSError *error, id responseObject)) completionBlock;


/*
 * CamFi Get Config
 */
+ (void) camFiGetConfig:(void (^)(NSError *error, id responseObject)) completionBlock;

/*
 * CamFi Set Config
 */
+ (void) camFiSetConfig:(NSDictionary*)parameter completionBlock:(void (^)(NSError *error, id responseObject)) completionBlock;

/*
 * CamFi Get Images
 */
+ (void) camFiGetImagesWithOffset:(NSUInteger)offset count:(NSUInteger)count completionBlock:(void (^)(NSError *error, id responseObject)) completionBlock;

/*
 * CamFi Start Receive Photos
 */
+ (void) camFiStartReceivePhotos:(void (^)(NSError *error)) completionBlock;


/*
 * CamFi Stop Receive Photos
 */
+ (void) camFiStopReceivePhotos:(void (^)(NSError *error)) completionBlock;


/*
 * CamFi Start Live Show
 */
+ (void) camFiStartLiveShow:(void (^)(NSError *error)) completionBlock;

/*
 * CamFi Stop Live Show
 */
+ (void) camFiStopLiveShow:(void (^)(NSError *error)) completionBlock;


/*
 * CamFi Version
 */
+ (void) camFiGetVersion:(void (^)(NSError *error, id responseObject)) completionBlock;

@end
