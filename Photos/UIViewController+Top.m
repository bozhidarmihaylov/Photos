//
//  UIViewController+Top.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "UIViewController+Top.h"

@implementation UIViewController (Top)

+ (UIViewController *)topmostViewController {
    UIViewController *result = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    return [result topmostViewController];
}

- (UIViewController *)topmostViewController {
    UIViewController *result = self;
    
    if (self.presentedViewController) {
        for (; result.presentedViewController; result = result.presentedViewController);
        
        result = [result topmostViewController];
    }
    else if ([result isKindOfClass:[UITabBarController class]]) {
        result = [[(UITabBarController *)result selectedViewController] topmostViewController];
    }
    else if ([result isKindOfClass:[UINavigationController class]]) {
        result = [[(UINavigationController *)result topViewController] topmostViewController];
    }
    
    return result;
}

@end
