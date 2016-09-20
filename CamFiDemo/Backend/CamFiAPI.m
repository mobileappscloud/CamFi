//
//  CamFiAPI.m
//  CamFi
//
//  Created by Justin on 16/5/29.
//  Copyright © 2016年 CamFi. All rights reserved.
//

#import "CamFiAPI.h"
#import "CamFiServerInfo.h"
#import "AFHTTPRequestOperationManager.h"
#import "Constants.h"

#define TIMEOUTINTERVAL 5.f

@implementation CamFiAPI

/*
 * CamFi Live
 */
+ (void) camFiLive:(void (^)(NSError *error)) completionBlock {
    AFHTTPRequestOperationManager *manager = [CamFiAPI requestClient];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"GET" URLString:[[CamFiServerInfo sharedInstance] camFiLiveURLStr] parameters:nil error:nil];
    [request setTimeoutInterval:TIMEOUTINTERVAL];
    
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completionBlock) {
            if (operation.response.statusCode == Success_Response_Code) {
                completionBlock(nil);
            }else {
                completionBlock(operation.error);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completionBlock) {
            
            completionBlock(error);
        }
    }];
    [manager.operationQueue addOperation:operation];
}

/*
 * CamFi Take Picture
 */
+ (void) camFiTakePicture:(void (^)(NSError *error, id responseObject)) completionBlock {
    AFHTTPRequestOperationManager *manager = [CamFiAPI requestClientWithRawData];
    [manager GET:[[CamFiServerInfo sharedInstance] camFiTakePictureUrlString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completionBlock) {
            if (operation.response.statusCode == Success_Response_Code) {
                completionBlock(nil, [NSJSONSerialization
                                      JSONObjectWithData:responseObject
                                      options:NSJSONReadingMutableLeaves
                                      error:nil]);
            }else {
                completionBlock(operation.error, nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completionBlock) {
            
            completionBlock(error, nil);
        }
    }];
}

/*
 * CamFi Get Config
 */
+ (void) camFiGetConfig:(void (^)(NSError *error, id responseObject)) completionBlock {\
    AFHTTPRequestOperationManager *manager = [CamFiAPI requestClient];
    
    [manager GET:[[CamFiServerInfo sharedInstance] camFiGetConfigUrlString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completionBlock) {
            if (operation.response.statusCode == Success_Response_Code) {
                completionBlock(nil, responseObject);
            }else {
                completionBlock(operation.error, nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completionBlock) {
            
            completionBlock(error, nil);
        }
    }];
}

/*
 * CamFi Set Config
 */
+ (void) camFiSetConfig:(NSDictionary*)parameter
              completionBlock:(void (^)(NSError *error, id responseObject)) completionBlock {
    AFHTTPRequestOperationManager *manager = [CamFiAPI requestJsonClient];
    
    [manager PUT:[[CamFiServerInfo sharedInstance] camFiSetConfigUrlString] parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completionBlock) {
            if (operation.response.statusCode == Success_Response_Code) {
                completionBlock(nil, responseObject);
            }else {
                NSLog(@"camFiSetConfig%@", responseObject);
                completionBlock(operation.error, nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completionBlock) {
            
            completionBlock(error, nil);
        }
    }];
}

/*
 * CamFi Get Images
 */
+ (void) camFiGetImagesWithOffset:(NSUInteger)offset count:(NSUInteger)count completionBlock:(void (^)(NSError *error, id responseObject)) completionBlock {
    
    AFHTTPRequestOperationManager *manager = [CamFiAPI requestClient];
    
    NSString* urlString = [NSString stringWithFormat:@"%@/%@/%@", [[CamFiServerInfo sharedInstance] camFiGetImagesUrlString], @(offset), @(count)];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completionBlock) {
            if (operation.response.statusCode == Success_Response_Code) {
                completionBlock(nil, responseObject);
            }else {
                completionBlock(operation.error, nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completionBlock) {
            
            completionBlock(error, nil);
        }
    }];
}


/*
 * CamFi Start Receive Photos
 */
+ (void) camFiStartReceivePhotos:(void (^)(NSError *error)) completionBlock {
    AFHTTPRequestOperationManager *manager = [CamFiAPI requestClient];
    
    [manager POST:[[CamFiServerInfo sharedInstance] camFiStartTetherUrlString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completionBlock) {
            if (operation.response.statusCode == Success_Response_Code) {
                completionBlock(nil);
            }else {
                completionBlock(operation.error);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completionBlock) {
            
            completionBlock(error);
        }
    }];
}

/*
 * CamFi Stop Receive Photos
 */
+ (void) camFiStopReceivePhotos:(void (^)(NSError *error)) completionBlock {
    AFHTTPRequestOperationManager *manager = [CamFiAPI requestClient];
    
    [manager POST:[[CamFiServerInfo sharedInstance] camFiStopTetherUrlString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completionBlock) {
            if (operation.response.statusCode == Success_Response_Code) {
                completionBlock(nil);
            }else {
                completionBlock(operation.error);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completionBlock) {
            
            completionBlock(error);
        }
    }];
}


/*
 * CamFi Start Live Show
 */
+ (void) camFiStartLiveShow:(void (^)(NSError *error)) completionBlock {
    AFHTTPRequestOperationManager *manager = [CamFiAPI requestClient];
    
    [manager GET:[[CamFiServerInfo sharedInstance] camFiStartLiveShowUrlString:nil] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completionBlock) {
            if (operation.response.statusCode == Success_Response_Code) {
                completionBlock(nil);
            }else {
                completionBlock(operation.error);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completionBlock) {
            
            completionBlock(error);
        }
    }];
}

/*
 * CamFi Stop Live Show
 */
+ (void) camFiStopLiveShow:(void (^)(NSError *error)) completionBlock {
    AFHTTPRequestOperationManager *manager = [CamFiAPI requestClient];
    
    [manager GET:[[CamFiServerInfo sharedInstance] camFiStopLiveShowUrlString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completionBlock) {
            if (operation.response.statusCode == Success_Response_Code) {
                completionBlock(nil);
            }else {
                completionBlock(operation.error);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completionBlock) {
            
            completionBlock(error);
        }
    }];
}


/*
 * CamFi Version
 */
+ (void) camFiGetVersion:(void (^)(NSError *error, id responseObject)) completionBlock {
    AFHTTPRequestOperationManager *manager = [CamFiAPI requestJsonClient];
    
    [manager GET:[[CamFiServerInfo sharedInstance] camFiGetVersionUrlString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completionBlock) {
            if (operation.response.statusCode == Success_Response_Code) {
                NSDictionary *jsonObject = [NSJSONSerialization
                                            JSONObjectWithData:responseObject
                                            options:NSJSONReadingMutableLeaves
                                            error:nil];
                completionBlock(nil, jsonObject);
            }else {
                completionBlock(operation.error, nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (operation.response && [operation.response statusCode] == 404) {
            completionBlock(nil, @{@"version":@"1.0.0.0"});
        } else {
            if (completionBlock) {
                
                completionBlock(error, nil);
            }
        }
    }];
}

#pragma mark - AFHTTPRequestOperationManager
/**
 * AFNetwork Manager
 */
+ (AFHTTPRequestOperationManager*) requestClient {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = TIMEOUTINTERVAL;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    /* Allow invalid certificates */
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    return manager;
}

+ (AFHTTPRequestOperationManager*) requestJsonClient {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = TIMEOUTINTERVAL;
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    /* Allow invalid certificates */
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    return manager;
}

+ (AFHTTPRequestOperationManager*) requestClientWithRawData {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = TIMEOUTINTERVAL;
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    /* Allow invalid certificates */
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    return manager;
}

@end
