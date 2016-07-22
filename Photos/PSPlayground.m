//
//  PSPlayground.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSPlayground.h"
#import "PSPhotosApiManager.h"
#import "PSPhotosManager.h"
#import "PSThumbnailMaker.h"
#import "PSPhotosResponse.h"

@implementation PSPlayground

#pragma mark - Initialization

+ (instancetype)playgroundWithWindow:(UIWindow *)window {
    return [[self alloc] initWithWindow:window];
}

- (instancetype)initWithWindow:(UIWindow *)window {
    if (self = [super init]) {
        self.window = window;
    }
    return self;
}

#pragma mark - Public methods

- (void)play {
//    PSPhotosApiManager *photosApiManager = [PSPhotosApiManager sharedManager];
//    
//    [photosApiManager photosWithWithInfo:@{
//                                           @"text" : @"cat"
//                                               }
//                              completion:^(id result, NSError *error) {
//                                  NSLog(@"\nresult:\n%@\nerror=\n%@", result, error);
//                              }];
    
//    PSPhotosManager *photosManager = [PSPhotosManager sharedManager];
//    
//    [photosManager photosWithSearchText:@"cats"
//                             pageCursor:[PSPageCursor cursorWithPage:@(1)
//                                                             perPage:nil]
//                             completion:^(PSPhotosResponse *response, NSError *error) {
//                                 PSPhoto *photo = response.results.firstObject;
    
//                                 [photosManager thumbnailForPhoto:photo
//                                                         withSize:CGSizeMake(96.66f, 96.66f)
//                                                       completion:^(UIImage *thumbnail, NSError *error) {
//                                                           NSLog(@"\nthumbnail:\n%@\nerror:\n%@", thumbnail, error);
//                                                       }];
//                             }];
    
//    PSThumbnailMaker *maker = [PSThumbnailMaker new];
//    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"jpg"];
//    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
//    
//    
//    UIImage *image = [maker thumbnailWithSize:CGSizeMake(200, 200) forImageWithData:imageData];
    
//    NSLog(@"%@", image);
}

@end
