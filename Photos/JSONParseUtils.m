//
//  JSONParseUtils.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "JSONParseUtils.h"

@implementation JSONParseUtils

+ (NSNumber *)numberFromJSON:(id)json {
    __autoreleasing NSNumber *result = nil;
    
    if ([json isKindOfClass:[NSNumber class]]) {
        result = json;
    }
    else if ([json isKindOfClass:[NSString class]]) {
        NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        
        result = [numberFormatter numberFromString:json];
    }
    
    return result;
}

+ (NSString *)stringFromJSON:(id)json {
    __autoreleasing NSString *result = nil;
    
    if ([json isKindOfClass:[NSString class]]) {
        result = json;
    }
    else if ([json isKindOfClass:[NSNumber class]]) {
        result = [json description];
    }
    
    return result;
}

+ (NSArray *)arrayFromJSON:(id)json {
    __autoreleasing NSArray *result = nil;
    
    if ([json isKindOfClass:[NSArray class]]) {
        result = json;
    }
    
    return result;
}

+ (NSDictionary *)dictionaryFromJSON:(id)json {
    __autoreleasing NSDictionary *result = nil;
    
    if ([json isKindOfClass:[NSDictionary class]]) {
        result = json;
    }
    
    return result;
}

@end
