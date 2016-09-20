//
//  AFLog.h
//  CamFi
//
//  Created by Justin on 16/5/29.
//  Copyright © 2016年 CamFi. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Convenience macros
 */
#define AFLogError(...) [[AFLog sharedInstance] logError:__VA_ARGS__]
#define AFLogWarning(...) [[AFLog sharedInstance] logWarning:__VA_ARGS__]
#define AFLogInfo(...) [[AFLog sharedInstance] logInfo:__VA_ARGS__]
#define AFLogDebug(...) [[AFLog sharedInstance] logDebug:__VA_ARGS__]
#define AFLogTrace(...) [[AFLog sharedInstance] logTrace:__VA_ARGS__]

#if !defined(AF_LOG_LEVEL)
#if DEBUG
#define AF_LOG_LEVEL AFLogLevelDebug
#else
#define AF_LOG_LEVEL AFLogLevelInfo
#endif
#endif

@interface AFLog : NSObject
typedef NS_ENUM(NSUInteger, AFLogLevel) {
    AFLogLevelOff = 0,
    AFLogLevelError,
    AFLogLevelWarning,
    AFLogLevelInfo,
    AFLogLevelDebug,
    AFLogLevelTrace
};

@property (nonatomic, assign) AFLogLevel logLevel;

/**
 * Returns the shared singleton
 */
+ (AFLog*)sharedInstance;

/**
 * Designated initializer. Can be used when not instanciating this class in singleton mode.
 */
- (id)initWithLogLevel:(AFLogLevel)logLevel;

- (NSString*)stringForLogLevel:(AFLogLevel)logLevel;

- (void)logErrorFromError:(NSError*)error;
- (void)logError:(NSString*)format, ...;
- (void)logWarning:(NSString*)format, ...;
- (void)logInfo:(NSString*)format, ...;
- (void)logDebug:(NSString*)format, ...;
- (void)logTrace:(NSString*)format, ...;

@end
