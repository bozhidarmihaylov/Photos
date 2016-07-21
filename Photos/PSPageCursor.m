//
//  PSPageCursor.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSPageCursor.h"

@implementation PSPageCursor

#pragma mark - Initialization

+ (instancetype)cursorWithPage:(NSNumber *)page
                       perPage:(NSNumber *)perPage
{
    return [[self alloc] initWithPage:page
                              perPage:perPage];
}

- (instancetype)initWithPage:(NSNumber *)page
                     perPage:(NSNumber *)perPage
{
    if (self = [super init]) {
        self.page = page;
        self.perPage = perPage;
    }    
    return self;
}


@end
