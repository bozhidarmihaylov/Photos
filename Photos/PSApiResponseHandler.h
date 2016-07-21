//
//  PSApiResponseHandler.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "ActionBlock.h"

@protocol PSApiResponseHandler <NSObject>

- (void)handleResponseWithResult:(id)result
                           error:(NSError *)error
                      completion:(ActionCompletionBlock)completion;

@end

@interface PSApiResponseHandler : NSObject <PSApiResponseHandler>

@property (strong, nonatomic) dispatch_queue_t completionQueue; // if nil uses the Main queue

@end
