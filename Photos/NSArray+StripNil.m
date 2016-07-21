//
//  NSArray+StripNil.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "NSArray+StripNil.h"
#import "NSDictionary+StripNil.h"

@implementation NSArray (StripNil)

- (NSArray *)stripNil {
    NSMutableArray *result = [NSMutableArray new];
    
    [self enumerateObjectsUsingBlock:^(id  obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]]) {
            obj = [obj stripNil];
        }
        
        [result addObject:obj];
    }];
    
    return [result copy];
}

@end
