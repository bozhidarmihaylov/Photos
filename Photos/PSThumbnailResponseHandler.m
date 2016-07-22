//
//  PSThumbnailResponseHandler.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSThumbnailResponseHandler.h"
#import "PSThumbnailMaker.h"

@interface PSThumbnailResponseHandler ()

@property (strong, nonatomic) id<PSThumbnailMaker> thumbnailMaker;

@end

@implementation PSThumbnailResponseHandler

#pragma mark - Initialization

+ (instancetype)handlerWithThumbnailSize:(CGSize)thumbnailSize {
    return [[self alloc] initWithThumbnailSize:thumbnailSize];
}

- (instancetype)initWithThumbnailSize:(CGSize)thumbnailSize {
    if (self = [super init]) {
        self.thumbnailSize = thumbnailSize;
        self.thumbnailMaker = [PSThumbnailMaker new];
    }
    return self;
}

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

#pragma mark - PSApiResponseHandler

- (void)handleResponseWithResult:(NSData *)imageData
                           error:(NSError *)error
                      completion:(ActionCompletionBlock)completion
{
    if (completion) {
        UIImage *result = nil;
        
        if (!error) {
            result = [self.thumbnailMaker thumbnailForImageWithData:imageData
                                                   scaledToFillSize:self.thumbnailSize];
        }
        
        [super handleResponseWithResult:result
                                  error:error
                             completion:completion];
    }
}

@end
