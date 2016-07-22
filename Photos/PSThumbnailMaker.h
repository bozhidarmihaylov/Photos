//
//  PSThumbnailMaker.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PSThumbnailMaker <NSObject>

- (UIImage *)thumbnailForImageWithData:(NSData *)imageData
                      scaledToFillSize:(CGSize)size;

@end

@interface PSThumbnailMaker : NSObject <PSThumbnailMaker>

@end
