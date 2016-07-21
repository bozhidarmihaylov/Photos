//
//  PSApiManager.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSApiClient.h"
#import "ActionBlock.h"

@interface PSApiManager : NSObject

@property (strong, nonatomic) id<PSApiClient> apiClient;

- (NSDictionary *)paramsByAddingMethod:(NSString *)method
                              toParams:(NSDictionary *)params;

@end
