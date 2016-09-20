//
//  CamFiServerInfo.m
//  CamFi
//
//  Created by Justin on 16/5/29.
//  Copyright © 2016年 CamFi. All rights reserved.
//

#import "CamFiServerInfo.h"
#import "Constants.h"
#import "NSString+Utils.h"

@implementation CamFiServerInfo

/* single instance */
+ (CamFiServerInfo *)sharedInstance {
    static dispatch_once_t predicate = 0;
    __strong static id sharedObject = nil;
    
    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
    });
    
    return sharedObject;
}

/*
 * Initial
 */
- (id) init {
    if (self = [super init]) {
        _serverIP = @"192.168.9.67";
        _serverPort = kDefaultHTTPPort;
        _serverProtocol = kProtocolHTTP;
        _serverListenPort = 8080;
    }
    
    return self;
}

#pragma mark - Server URL & API

/* base server url string */
- (NSString*) serverURLStr {
    return [NSString stringWithFormat:@"%@://%@:%@", _serverProtocol, _serverIP, _serverPort];
}

/* Event url string */
- (NSString*) eventURLString {
    return [NSString stringWithFormat:@"%@://%@:%@", _serverProtocol, _serverIP, @"8080"];
}

/* CamFi live url string */
- (NSString*) camFiLiveURLStr {
    return [NSString stringWithFormat:@"%@%@", [self serverURLStr], @"/live"];
}

/* CamFi live show data url */
- (NSString*) camfiLiveShowDataUrlString {
    return [NSString stringWithFormat:@"%@://%@:%d", _serverProtocol, _serverIP, 890];
}

/* CamFi take picture url string */
- (NSString*) camFiTakePictureUrlString {
    return [NSString stringWithFormat:@"%@%@/%@", [self serverURLStr], @"/takepic", @"true"];
}

/* CamFi set config value url string */
- (NSString*) camFiSetConfigUrlString {
    return [NSString stringWithFormat:@"%@%@", [self serverURLStr], @"/setconfigvalue"];
}

/* CamFi get config url string */
- (NSString*) camFiGetConfigUrlString {
    return [NSString stringWithFormat:@"%@%@", [self serverURLStr], @"/config"];
}

/* CamFi get thumbnail by id url string */
- (NSString*) camFiGetThumbnailByIdUrlString:(NSString*) thumbId {
    return [NSString stringWithFormat:@"%@%@/%@", [self serverURLStr], @"/thumbnail", [NSString UrlValueEncode:thumbId]];
}

/* CamFi get image by id url string */
- (NSString*) camFiGetImageByIdUrlString:(NSString*) imgId{
    return [NSString stringWithFormat:@"%@%@/%@", [self serverURLStr], @"/image", [NSString UrlValueEncode:imgId]];
}

/* CamFi get media raw data by id url string */
- (NSString*) camFiGetRawDataByIdUrlString:(NSString*) imgId {
    return [NSString stringWithFormat:@"%@%@/%@", [self serverURLStr], @"/raw", [NSString UrlValueEncode:imgId]];
}

/* CamFi start tether url string */
- (NSString*) camFiStartTetherUrlString {
    return [NSString stringWithFormat:@"%@%@", [self serverURLStr], @"/tether/start"];
}

/* CamFi stop tether stop url string */
- (NSString*) camFiStopTetherUrlString {
    return [NSString stringWithFormat:@"%@%@", [self serverURLStr], @"/tether/stop"];
}

/* CamFi live show url string */
- (NSString*) camFiStartLiveShowUrlString:(NSString*) record {
    return [NSString stringWithFormat:@"%@%@", [self serverURLStr], @"/capturemovie"];
    //return [NSString stringWithFormat:@"%@%@/%@", [self serverURLStr], @"/capturemovie", record];
}

/* CamFi stop live show url string */
- (NSString*) camFiStopLiveShowUrlString {
    return [NSString stringWithFormat:@"%@%@", [self serverURLStr], @"/stopcapturemovie"];
}

/* Camfi get version */
- (NSString*) camFiGetVersionUrlString{
    return [NSString stringWithFormat:@"%@%@", [self serverURLStr], @"/info"];
}

/* CamFi get images */
- (NSString*) camFiGetImagesUrlString {
    return [NSString stringWithFormat:@"%@%@", [self serverURLStr], @"/files"];
}

@end
