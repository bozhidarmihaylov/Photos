//
//  PSAppConfig.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PSAppCofig <NSObject>

@property (strong, nonatomic, readonly) NSURL *APIBaseURL;
@property (strong, nonatomic, readonly) NSString *APIAppKey;

@end

@interface PSAppConfig : NSObject <PSAppCofig>

+ (instancetype)sharedConfig;

@end
