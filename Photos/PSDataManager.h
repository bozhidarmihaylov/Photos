//
//  PSDataManager.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "ActionBlock.h"
#import "PSApiResponseHandler.h"
#import "NSError+API.h"

@interface PSDataManager : NSObject

@property (strong, nonatomic) id<PSApiResponseHandler> defaultResponseHandler;

@end
