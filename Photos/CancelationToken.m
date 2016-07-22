//
//  CancelationToken.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "CancelationToken.h"

@interface CancelationToken ()

@property (assign, atomic, readwrite, getter = isCancelled) BOOL cancelled;

@property (strong, nonatomic) dispatch_queue_t syncQueue;

@end

@implementation CancelationToken

@synthesize cancelled=_cancelled;

- (instancetype)init {
    if (self = [super init]) {
        self.syncQueue = dispatch_queue_create("CancelationTokenQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (BOOL)isCancelled {
    __block BOOL cancelled = NO;
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_sync(self.syncQueue, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        cancelled = strongSelf->_cancelled;
    });
    
    return cancelled;
}

- (void)setCancelled:(BOOL)cancelled {
    _cancelled = cancelled;
}

- (void)cancel {
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(self.syncQueue, ^{
        weakSelf.cancelled = YES;
    });
}

@end
