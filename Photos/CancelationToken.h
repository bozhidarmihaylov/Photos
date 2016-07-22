//
//  CancelationToken.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CancelationToken <NSObject>

@property (assign, atomic, readonly, getter = isCancelled) BOOL cancelled;

- (void)cancel;

@end

@interface CancelationToken : NSObject <CancelationToken>

@end
