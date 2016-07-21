//
//  PSPhoto.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSObject.h"

@interface PSPhoto : PSObject

@property (copy, nonatomic) NSString *objectId;
@property (copy, nonatomic) NSString *secret;
@property (copy, nonatomic) NSString *server;
@property (strong, nonatomic) NSNumber *farm;

@property (copy, nonatomic) NSString *owner;

@property (copy, nonatomic) NSString *title;

@property (strong, nonatomic) NSNumber *isPublic;
@property (strong, nonatomic) NSNumber *isFriend;
@property (strong, nonatomic) NSNumber *isFamily;

@end
