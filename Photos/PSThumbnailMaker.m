//
//  PSThumbnailMaker.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSThumbnailMaker.h"

#import <ImageIO/ImageIO.h>

@implementation PSThumbnailMaker

// http://stackoverflow.com/a/17884863/6363991

- (UIImage *)imageWithImage:(UIImage *)image
           scaledToFillSize:(CGSize)size
{
    CGFloat scale = MAX(size.width/image.size.width, size.height/image.size.height);
    
    CGFloat width = image.size.width * scale;
    CGFloat height = image.size.height * scale;
    
    CGRect imageRect = CGRectMake((size.width - width) / 2.0f,
                                  (size.height - height) / 2.0f,
                                  width,
                                  height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:imageRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - PSThumbnailMaker

- (UIImage *)thumbnailForImageWithData:(NSData *)imageData
                      scaledToFillSize:(CGSize)size;
{
    UIImage *result = nil;

    UIImage *sourceImage = [UIImage imageWithData:imageData];
    
    result = [self imageWithImage:sourceImage scaledToFillSize:size];

    return result;
}

@end
