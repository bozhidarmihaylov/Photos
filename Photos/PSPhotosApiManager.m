//
//  PSUserApiManager.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSPhotosApiManager.h"

@implementation PSPhotosApiManager

#pragma mark - Initialization

+ (instancetype)sharedManager {
    static id _sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [self new];
    });
    
    return _sharedManager;
}

#pragma mark - Public methods

- (void)photosWithWithInfo:(NSDictionary *)info
                completion:(ActionCompletionBlock)completion
{
    info = [self paramsByAddingMethod:@"flickr.photos.search"
                             toParams:info];
    [self.apiClient GET:@""
             parameters:info
              completion:completion];
}

#pragma mark - Utilities



@end
