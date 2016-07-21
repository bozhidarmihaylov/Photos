//
//  NSObject+Runtime.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)

+ (NSArray *)propertyNameList;
+ (NSArray *)fullPropertyNameList; // including properties in superclasses except NSObject's

- (NSArray *)propertyNameList;
- (NSArray *)fullPropertyNameList;

- (Class)classForKey:(NSString *)key;
- (NSString *)classNameForKey:(NSString *)key;

@end
