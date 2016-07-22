//
//  PSTestCase.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSTestCase.h"

@implementation PSTestCase

- (NSData *)resourceNamed:(NSString *)resourceName {
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:resourceName ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    return data;

}

@end
