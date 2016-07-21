//
//  PSAppConfig.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSAppConfig.h"

static NSString * const PSAPIBaseURLString = @"https://api.flickr.com/services/rest/";
static NSString * const PSAPIAppKey = @"6e8be10e8aee20ce354dad811266a523";

@implementation PSAppConfig

#pragma mark - Initialization

+ (instancetype)sharedConfig {
    static id _sharedConfig = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedConfig = [self new];
    });
    
    return _sharedConfig;
}

#pragma mark - PSAppConfig

- (NSURL *)APIBaseURL {
    return [NSURL URLWithString:PSAPIBaseURLString];
}

- (NSString *)APIAppKey {
    return PSAPIAppKey;
}

@end
