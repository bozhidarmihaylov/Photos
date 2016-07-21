//
//  ActionBlock.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ActionCompletionBlock)(id result, NSError *error);
typedef void (^ActionBlock)(ActionCompletionBlock completionBlock);
