//
//  NSObject+Runtime.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "NSObject+Runtime.h"

#import <objc/runtime.h>

@implementation NSObject (Runtime)

+ (NSArray *)propertyNameList {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList(self, &outCount);
    
    for(NSInteger i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        const char *propName = property_getName(property);
        if(propName) {
            const char *attrs = property_getAttributes(property);
            
            if (attrs) {
                NSString *attrString = [NSString stringWithUTF8String:attrs];
                
                if (NSNotFound == [attrString rangeOfString:@",R"].location) {
                    NSString *propertyName = [NSString stringWithCString:propName
                                                                encoding:[NSString defaultCStringEncoding]];
                    [result addObject:propertyName];
                }
            }
        }
    }
    free(properties);
    
    return result;
}

+ (NSArray *)fullPropertyNameList {
    NSMutableArray *propertyNameList = [NSMutableArray new];
    for (Class class = [self class]; class != [NSObject class]; class = [class superclass]) {
        [propertyNameList addObjectsFromArray:[class propertyNameList]];
    }
    return propertyNameList;
}

- (NSArray *)propertyNameList {
    return [self.class propertyNameList];
}

- (NSArray *)fullPropertyNameList {
    return [self.class fullPropertyNameList];
}

- (NSString *)classNameForKey:(NSString *)key {
    NSString *result = nil;
    
    objc_property_t property = class_getProperty(self.class, key.UTF8String);
    
    NSString* propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
    NSArray* splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@"\""];
    
    if ([splitPropertyAttributes count] >= 2) {
        result = [splitPropertyAttributes objectAtIndex:1];
    }
    
    return result;
}

- (Class)classForKey:(NSString *)key {
    return NSClassFromString([self classNameForKey:key]);
}

@end
