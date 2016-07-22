//
//  PSThumbnailResponseHandler.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSApiResponseHandler.h"

#import <UIKit/UIKit.h>

@interface PSThumbnailResponseHandler : PSApiResponseHandler

+ (instancetype)handlerWithThumbnailSize:(CGSize)thumbnailSize;
- (instancetype)initWithThumbnailSize:(CGSize)thumbnailSize;

@property (assign, nonatomic) CGSize thumbnailSize;

@end
