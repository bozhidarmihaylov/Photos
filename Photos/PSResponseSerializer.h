//
//  PSResponseSerializer.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface PSResponseSerializer : AFJSONResponseSerializer

@property (strong, nonatomic) NSURL *apiBaseURL;

@end
