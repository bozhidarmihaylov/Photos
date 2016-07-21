//
//  PSPhotosResponse.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSPhoto.h"

@interface PSPhotosResponse : PSObject

@property (strong, nonatomic) NSNumber *page;
@property (strong, nonatomic) NSNumber *perPage;

@property (strong, nonatomic) NSNumber *pageCount;
@property (strong, nonatomic) NSNumber *totalCount;

@property (strong, nonatomic) NSArray *results; // of PSPhoto

@end
