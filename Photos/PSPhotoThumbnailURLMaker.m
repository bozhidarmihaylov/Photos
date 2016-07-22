//
//  PSPhotoThumbnailURLMaker.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSPhotoThumbnailURLMaker.h"

@implementation PSPhotoThumbnailURLMaker

#pragma mark - PSPhotoThumbnailURLMaker

- (NSURL *)URLForThumbnailOfPhoto:(PSPhoto *)photo
                scalledToFillSize:(CGSize)size
{
//    CGFloat scale = [UIScreen mainScreen].scale;
    
//    CGFloat maxDimension = MAX(size.width * scale, size.height * scale);
//    CGFloat doubleMaxDimension = maxDimension * 2.0f;
    
    NSString *suffix = nil;
    
//    if (maxDimension <= 75.0f) {
//        suffix = @"_s";
//    }
//    else if (maxDimension <= 150.0f) {
        suffix = @"_q";
//    }
//    else if (doubleMaxDimension <= 320.0f) {
//        suffix = @"_n";
//    }
//    else if (doubleMaxDimension <= 500.0f) {
//        suffix = @"";
//    }
//    else if (doubleMaxDimension <= 640.0f) {
//        suffix = @"_z";
//    }
//    else if (doubleMaxDimension <= 800.0f) {
//        suffix = @"_c";
//    }
//    else if (doubleMaxDimension <= 1024.0f) {
//        suffix = @"_b";
//    }
//    else if (doubleMaxDimension <= 1600.0f || YES) {
//        suffix = @"_h";
//    }

    NSString *urlString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@%@.jpg",
                           photo.farm, photo.server, photo.objectId, photo.secret, suffix];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    return url;
}

@end
