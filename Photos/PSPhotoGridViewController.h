//
//  PSPhotoGridViewController.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSPageCursor.h"

#import <UIKit/UIKit.h>

@class PSPhotoGridViewController;
@protocol PSPhotoGridViewControllerDataSource  <NSObject>

@end

@interface PSPhotoGridViewController : UICollectionViewController

@property (weak, nonatomic) id<PSPhotoGridViewControllerDataSource> dataSource;

@property (strong, nonatomic) NSNumber *interItemOffset; // defaults to 5.0f points
@property (strong, nonatomic) NSNumber *numberOfColumns; // defaults to 3

@property (copy, nonatomic) NSString *searchString;

@end
