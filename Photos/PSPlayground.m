//
//  PSPlayground.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSPlayground.h"
#import "PSPhotosApiManager.h"

@implementation PSPlayground

#pragma mark - Initialization

+ (instancetype)playgroundWithWindow:(UIWindow *)window {
    return [[self alloc] initWithWindow:window];
}

- (instancetype)initWithWindow:(UIWindow *)window {
    if (self = [super init]) {
        self.window = window;
    }
    return self;
}

#pragma mark - Public methods

- (void)play {
    PSPhotosApiManager *photosApiManager = [PSPhotosApiManager sharedManager];
    
    [photosApiManager photosWithWithInfo:@{
                                           @"text" : @"cat"
                                               }
                              completion:^(id result, NSError *error) {
                                  NSLog(@"\nresult:\n%@\nerror=\n%@", result, error);
                              }];
}

@end
