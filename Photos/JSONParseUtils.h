//
//  JSONParseUtils.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONParseUtils : NSObject

+ (NSNumber *)numberFromJSON:(id)json;
+ (NSString *)stringFromJSON:(id)json;

+ (NSArray *)arrayFromJSON:(id)json;
+ (NSDictionary *)dictionaryFromJSON:(id)json;

@end
