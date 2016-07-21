//
//  UIViewController+Embed.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "UIViewController+Embed.h"

@implementation UIViewController (Embed)

- (void)detachFromParentViewController {
    if (self.parentViewController) {
        [self.parentViewController willMoveToParentViewController:nil];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }
}

- (void)embedInRootViewController {
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    [self embedInParentViewController:rootVC
                withFillContainerView:rootVC.view];
}

- (void)embedInParentViewController:(UIViewController *)parentVC
              withFillContainerView:(UIView *)containerView
{
    [self embedInParentViewController:parentVC
                withFillContainerView:containerView
                    bellowSiblingView:nil];
}

- (void)embedInParentViewController:(UIViewController *)parentVC
              withFillContainerView:(UIView *)containerView
                  bellowSiblingView:(UIView *)onTopView
{
    [self detachFromParentViewController];
    
    if (parentVC) {
        [parentVC addChildViewController:self];
        self.view.frame = containerView.bounds;
        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        if (onTopView.superview == containerView) {
            [containerView insertSubview:self.view
                            belowSubview:onTopView];
        }
        else {
            [containerView addSubview:self.view];
        }
        
        [self didMoveToParentViewController:parentVC];
    }
}

- (void)presentEmbeddedInNavigationControllerVC:(UIViewController *)vc
                                       animated:(BOOL)animated
                                     completion:(void (^)(void))completion
{
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:navVC animated:animated completion:completion];
}

@end
