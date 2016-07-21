//
//  NSDictionary+StripNil.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "NSDictionary+StripNil.h"
#import "NSArray+StripNil.h"

@implementation NSDictionary (StripNil)

- (NSDictionary *)stripNil {
    NSMutableDictionary *result = [NSMutableDictionary new];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (obj != [NSNull null]) {
            if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]]) {
                obj = [obj stripNil];
            }
            result[key] = obj;
        }
    }];
    
    return [result copy];
}

@end
