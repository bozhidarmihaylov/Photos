//
//  PSPageCursor.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSObject.h"

@interface PSPageCursor : PSObject

+ (instancetype)cursorWithPage:(NSNumber *)page
                       perPage:(NSNumber *)perPage;

- (instancetype)initWithPage:(NSNumber *)page
                     perPage:(NSNumber *)perPage;

@property (strong, nonatomic) NSNumber *page;
@property (strong, nonatomic) NSNumber *perPage;

- (PSPageCursor *)nextCursor;

@end
