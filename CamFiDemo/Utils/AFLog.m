//
//  AFLog.m
//  CamFi
//
//  Created by Justin on 16/5/29.
//  Copyright © 2016年 CamFi. All rights reserved.
//

#import "AFLog.h"

@implementation AFLog
@synthesize logLevel = _logLevel;

/**
 * Returns the shared singleton
 */
+ (AFLog*)sharedInstance
{
    static dispatch_once_t predicate = 0;
    __strong static id sharedObject = nil;

    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
    });

    return sharedObject;
}

- (id)init
{
    return [self initWithLogLevel:AF_LOG_LEVEL];
}

/**
 * Designated initializer. Can be used when not instanciating this class in singleton mode.
 */
- (id)initWithLogLevel:(AFLogLevel)logLevel
{
    self = [super init];
    if (self) {
        _logLevel = logLevel;
    }
    return self;
}

#pragma mark -
#pragma mark Info methods

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ Log level: %@", [super description], [self stringForLogLevel:self.logLevel]];
}

- (NSString*)stringForLogLevel:(AFLogLevel)logLevel
{
    NSString* result = nil;

    switch (logLevel) {
    case AFLogLevelOff:
        result = @"OFF";
        break;
    case AFLogLevelError:
        result = @"ERROR";
        break;
    case AFLogLevelWarning:
        result = @"WARN";
        break;
    case AFLogLevelInfo:
        result = @"INFO";
        break;
    case AFLogLevelDebug:
        result = @"DEBUG";
        break;
    case AFLogLevelTrace:
        result = @"TRACE";
        break;
    default:
        result = @"UNKNOWN";
    }

    return result;
}

#pragma mark -
#pragma mark Logging methods
- (void)logErrorFromError:(NSError*)error
{
    if (self.logLevel != AFLogLevelOff) {
        NSString* message = [NSString stringWithFormat:@"[%ld] %@", (long)error.code, error.localizedDescription];
        [self logMessage:message forLogLevel:AFLogLevelError];
    }
}

- (void)logError:(NSString*)format, ...
{
    if (self.logLevel != AFLogLevelOff) {
        // Build log message string from variable args list
        va_list args;
        va_start(args, format);
        NSString* message = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);

        [self logMessage:message forLogLevel:AFLogLevelError];
    }
}

- (void)logWarning:(NSString*)format, ...
{
    if (self.logLevel >= AFLogLevelWarning) {
        // Build log message string from variable args list
        va_list args;
        va_start(args, format);
        NSString* message = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);

        [self logMessage:message forLogLevel:AFLogLevelWarning];
    }
}

- (void)logInfo:(NSString*)format, ...
{
    if (self.logLevel >= AFLogLevelInfo) {
        // Build log message string from variable args list
        va_list args;
        va_start(args, format);
        NSString* message = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);

        [self logMessage:message forLogLevel:AFLogLevelInfo];
    }
}

- (void)logDebug:(NSString*)format, ...
{
    if (self.logLevel >= AFLogLevelDebug) {
        // Build log message string from variable args list
        va_list args;
        va_start(args, format);
        NSString* message = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);

        [self logMessage:message forLogLevel:AFLogLevelDebug];
    }
}

- (void)logTrace:(NSString*)format, ...
{
    if (self.logLevel == AFLogLevelTrace) {
        // Build log message string from variable args list
        va_list args;
        va_start(args, format);
        NSString* message = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);

        [self logMessage:message forLogLevel:AFLogLevelTrace];
    }
}

#pragma mark -
#pragma mark Helper methods

- (void)logMessage:(NSString*)message forLogLevel:(AFLogLevel)logLevel
{
    NSString* callingMethod = [self methodNameFromCallStack:[[NSThread callStackSymbols] objectAtIndex:2]];
    NSLog(@"%@ %@ %@", [self stringForLogLevel:logLevel], callingMethod, message);
}

- (NSString*)methodNameFromCallStack:(NSString*)topOfStack
{
    NSString* methodName = nil;

    if (topOfStack != nil) {
        NSRange startBracketRange = [topOfStack rangeOfString:@"[" options:NSBackwardsSearch];
        if (NSNotFound != startBracketRange.location) {
            NSString* start = [topOfStack substringFromIndex:startBracketRange.location];
            NSRange endBracketRange = [start rangeOfString:@"]" options:NSBackwardsSearch];
            if (NSNotFound != endBracketRange.location) {
                methodName = [start substringToIndex:endBracketRange.location + 1];
            }
        }
    }

    return methodName;
}

@end
