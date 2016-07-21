//
//  UIViewController+Embed.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Embed)

- (void)embedInRootViewController;

- (void)embedInParentViewController:(UIViewController *)parentVC
              withFillContainerView:(UIView *)containerView;

- (void)embedInParentViewController:(UIViewController *)parentVC
              withFillContainerView:(UIView *)containerView
                  bellowSiblingView:(UIView *)onTopSiblingView;

- (void)presentEmbeddedInNavigationControllerVC:(UIViewController *)vc
                                       animated:(BOOL)animated
                                     completion:(void (^)(void))completion;

- (void)detachFromParentViewController;

@end
