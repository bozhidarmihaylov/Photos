//
//  PSApiManager.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSApiManager.h"

@implementation PSApiManager

#pragma mark - Initialization

- (instancetype)init {
    if (self = [super init]) {
        self.apiClient = [PSApiClient sharedClient];
    }
    return self;
}

#pragma mark - Public methods

- (NSDictionary *)paramsByAddingMethod:(NSString *)method
                              toParams:(NSDictionary *)params
{
    NSMutableDictionary *newInfo = [params mutableCopy] ?: [NSMutableDictionary new];
    
    newInfo[@"method"] = method;

    return [newInfo copy];
}

@end
