//
//  PSUserApiManager.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSApiManager.h"

@interface PSPhotosApiManager : PSApiManager

+ (instancetype)sharedManager;

- (void)photosWithWithInfo:(NSDictionary *)info
                completion:(ActionCompletionBlock)completion;

@end
