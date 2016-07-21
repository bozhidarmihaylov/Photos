//
//  PSDataManager.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSDataManager.h"

@implementation PSDataManager

#pragma mark - Initialization

- (instancetype)init {
    if (self = [super init]) {
        self.defaultResponseHandler = [PSApiResponseHandler new];
    }
    return self;
}

#pragma mark - Public methods

@end
