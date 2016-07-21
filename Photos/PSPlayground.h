//
//  PSPlayground.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSPlayground : NSObject

+ (instancetype)playgroundWithWindow:(UIWindow *)window;
- (instancetype)initWithWindow:(UIWindow *)window;

@property (strong, nonatomic) UIWindow *window;

- (void)play;

@end
