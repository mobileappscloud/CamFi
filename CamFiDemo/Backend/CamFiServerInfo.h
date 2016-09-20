//
//  CamFiServerInfo.h
//  CamFi
//
//  Created by Justin on 16/5/29.
//  Copyright © 2016年 CamFi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CamFiServerInfo : NSObject

@property (nonatomic, copy) NSString    *serverIP;
@property (nonatomic, copy) NSString    *serverPort;
@property (nonatomic, copy) NSString    *serverProtocol;
@property (nonatomic, assign) NSInteger serverListenPort;

/**
 * Returns the shared singleton
 */
+ (CamFiServerInfo *)sharedInstance;

/* base server url string */
- (NSString*) serverURLStr;

/* Event url string */
- (NSString*) eventURLString;

/* CamFi live url string */
- (NSString*) camFiLiveURLStr;

/* CamFi live show data url */
- (NSString*) camfiLiveShowDataUrlString;

/* CamFi take picture url string */
- (NSString*) camFiTakePictureUrlString;

/* CamFi set config value url string */
- (NSString*) camFiSetConfigUrlString;

/* CamFi get config url string */
- (NSString*) camFiGetConfigUrlString;

/* CamFi get thumbnail by id url string */
- (NSString*) camFiGetThumbnailByIdUrlString:(NSString*) thumbId;

/* CamFi get image by id url string */
- (NSString*) camFiGetImageByIdUrlString:(NSString*) imgId;

/* CamFi get media raw data by id url string */
- (NSString*) camFiGetRawDataByIdUrlString:(NSString*) imgId;

/* CamFi start tether url string */
- (NSString*) camFiStartTetherUrlString;

/* CamFi stop tether stop url string */
- (NSString*) camFiStopTetherUrlString;

/* CamFi live show url string */
- (NSString*) camFiStartLiveShowUrlString:(NSString*) record;

/* CamFi stop live show url string */
- (NSString*) camFiStopLiveShowUrlString;

/* Camfi get version */
- (NSString*) camFiGetVersionUrlString;

/* CamFi get images */
- (NSString*) camFiGetImagesUrlString;
    
@end
