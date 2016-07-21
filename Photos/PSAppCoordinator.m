//
//  PSAppCoordinator.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSAppCoordinator.h"
#import "PSPhotoGridViewController.h"

#import "UIViewController+Embed.h"

@interface PSAppCoordinator ()

@property (strong, nonatomic) UIWindow *window;

@end

@implementation PSAppCoordinator

#pragma makr - Initialization

+ (instancetype)sharedCoordinator {
    static id _sharedCoordinator = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedCoordinator = [self new];
    });
    
    return _sharedCoordinator;
}

#pragma mark - Accessors / Mutators

- (UIApplication *)application {
    return [UIApplication sharedApplication];
}

- (UIWindow *)window {
    return self.application.delegate.window;
}

- (void)setWindow:(UIWindow *)window {
    self.application.delegate.window = window;
}

#pragma mark - Public Methods

- (void)setupInitialUI {
    UIWindow *window = self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    PSPhotoGridViewController *photoGridVC = [PSPhotoGridViewController new];
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:photoGridVC];
    
    window.rootViewController = navVC;
    
    [window makeKeyAndVisible];
}

#pragma mark - Utilities



@end
