//
//  PSPhotoThumbnailURLMaker.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSPhoto.h"

#import <UIKit/UIKit.h>

@protocol PSPhotoThumbnailURLMaker <NSObject>

- (NSURL *)URLForThumbnailOfPhoto:(PSPhoto *)photo
                scalledToFillSize:(CGSize)size;

@end

@interface PSPhotoThumbnailURLMaker : NSObject <PSPhotoThumbnailURLMaker>

@end
