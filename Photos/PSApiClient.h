//
//  PSApiClient.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "ActionBlock.h"

@protocol PSApiClient <NSObject>

- (void)GET:(NSString *)URLString
 parameters:(id)parameters
 completion:(ActionCompletionBlock)completion;

- (void)POST:(NSString *)URLString
  parameters:(id)parameters
  completion:(ActionCompletionBlock)completion;

- (void)PUT:(NSString *)URLString
 parameters:(id)parameters
 completion:(ActionCompletionBlock)completion;

- (void)DELETE:(NSString *)URLString
    parameters:(id)parameters
    completion:(ActionCompletionBlock)completion;

@end

@interface PSApiClient : NSObject <PSApiClient>

+ (instancetype)sharedClient;

@end
