//
//  PSUserManager.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSPhotosManager.h"
#import "PSPhotosApiManager.h"
#import "PSPhotosResponseHandler.h"
#import "NSDictionary+StripNil.h"

#import <ObjectiveSugar/ObjectiveSugar.h>

@interface PSPhotosManager ()

@property (strong, nonatomic) PSPhotosApiManager *apiManager;
@property (strong, nonatomic) id<PSApiResponseHandler> photosResponseHandler;

@end

@implementation PSPhotosManager

#pragma mark - Initialization

+ (instancetype)sharedManager {
    static id _sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [self new];
    });
    
    return _sharedManager;
}

- (PSPhotosApiManager *)apiManager {
    return _apiManager ?: (self.apiManager = [PSPhotosApiManager sharedManager]);
}

- (id<PSApiResponseHandler>)photosResponseHandler {
    return _photosResponseHandler ?: (self.photosResponseHandler = [PSPhotosResponseHandler new]);
}


#pragma mark - Public methods

- (void)photosWithSearchText:(NSString *)searchText
                  pageCursor:(PSPageCursor *)pageCursor
                  completion:(ActionCompletionBlock)completion
 {
    [self.apiManager photosWithWithInfo:[@{
                                           @"text" : searchText ?: [NSNull null],
                                           @"page" : pageCursor.page ?: [NSNull null],
                                           @"per_page" : pageCursor.perPage ?: [NSNull null],
                                           }
                                         stripNil]
                             completion:^(NSArray *result, NSError *error) {
                                 [self.photosResponseHandler handleResponseWithResult:result
                                                                                error:error
                                                                           completion:completion];
                             }];
}

#pragma mark - Utilities


@end
