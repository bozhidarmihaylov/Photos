//
//  NSError+API.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "NSError+API.h"
#import <objc/runtime.h>

static void *PSServerSentErrorPropertyKey = &PSServerSentErrorPropertyKey;

@implementation NSError (API)

#pragma mark - Accessors / Mutators

- (PSServerSentError *)serverSentError {
    return objc_getAssociatedObject(self, PSServerSentErrorPropertyKey);
}

- (void)setServerSentError:(PSServerSentError *)serverSentError {
    objc_setAssociatedObject(self, PSServerSentErrorPropertyKey, serverSentError, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
