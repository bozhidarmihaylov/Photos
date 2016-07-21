//
//  PSUserManager.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSDataManager.h"
#import "PSPageCursor.h"

@interface PSPhotosManager : PSDataManager

+ (instancetype)sharedManager;

- (void)photosWithSearchText:(NSString *)searchText
                  pageCursor:(PSPageCursor *)pageCursor
                  completion:(ActionCompletionBlock)completion;

@end
