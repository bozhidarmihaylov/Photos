//
//  PSObject.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSObject.h"
#import "NSObject+Runtime.h"

@implementation PSObject

#pragma mark - Initialization

+ (instancetype)objectWithId:(NSString *)objectId
{
    PSObject *result = nil;
    
    if (objectId.length && self != [PSObject class]) {
        result = [self new];
        result.objectId = objectId;
    }
    
    return result;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        NSArray *propertyNameList = [self.class fullPropertyNameList];
        
        for (NSString *key in propertyNameList) {
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKeyPath:key];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray *propertyNameList = [self.class fullPropertyNameList];
    
    for (NSString *key in propertyNameList) {
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    id copy = [[self.class allocWithZone:zone] init];
    
    NSArray *propertyNameList = [self.class fullPropertyNameList];
    
    for (NSString *key in propertyNameList) {
        [copy setValue:[[self valueForKey:key] copy]
                forKey:key];
    }
    
    return copy;
}

#pragma mark - Description

- (NSString *)description {
    NSMutableString *result = [NSMutableString new];
    
    [result appendString:@"{\n\t"];
    
    NSArray *propertyNameList = [self.class fullPropertyNameList];
    
    for (NSString *propName in propertyNameList) {
        NSString *propertyDescription = [[self valueForKey:propName] description];
        
        propertyDescription = [propertyDescription stringByReplacingOccurrencesOfString:@"\n"
                                                                             withString:@"\n\t"];
        if (propName == propertyNameList.lastObject) {
            [result appendFormat:@"%@ : %@\n", propName, propertyDescription];
        }
        else {
            [result appendFormat:@"%@ : %@,\n\t", propName, propertyDescription];
        }
    }
    
    [result appendString:@"}"];
    
    return result;
}

#pragma mark - Equality

- (BOOL)isEqual:(PSObject *)object {
    BOOL result = YES;
    
    NSArray *propertyNameList = [self.class fullPropertyNameList];
    
    if ([[object.class fullPropertyNameList] isEqualToArray:propertyNameList]) {
        for (NSString *propName in propertyNameList) {
            id propValue1 = [self valueForKey:propName];
            id propValue2 = [object valueForKey:propName];
            
            if (propValue1 != propValue2 && ![propValue1 isEqual:propValue2]) {
                result = NO;
                break;
            }
        }
    }
    else {
        result = NO;
    }
    
    return result;
}

@end
