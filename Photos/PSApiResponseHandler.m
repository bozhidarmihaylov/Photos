//
//  PSApiResponseHandler.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSApiResponseHandler.h"
#import "NSError+API.h"
#import "UIViewController+Top.h"

#import <UIKit/UIKit.h>

@interface PSApiResponseHandler ()

@end

@implementation PSApiResponseHandler

#pragma mark - Initialization

- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}

#pragma mark - PSApiResponseHandler

- (void)handleResponseWithResult:(id)result
                           error:(NSError *)error
                      completion:(ActionCompletionBlock)completion
{
    if (completion) {
        dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
            if (error) {
                NSString *errorMessage = error.serverSentError.message ?: @"Cannot complete operation";
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                               message:errorMessage
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil]];
                
                [[UIViewController topmostViewController] presentViewController:alert
                                                                       animated:YES
                                                                     completion:nil];
            }
            
            completion(result, error);
        });
    }
}

@end
