//
//  NSObject+JSON.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "NSObject+JSON.h"

@implementation NSObject (JSON)

- (NSString *)jsonString {
    NSString *result = nil;
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0
                                                     error:&error];
    if (data && !error) {
        result = [[NSString alloc] initWithData:data
                                       encoding:NSUTF8StringEncoding];
    }
    
    return result;
}

@end
