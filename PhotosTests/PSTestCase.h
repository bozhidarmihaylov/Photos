//
//  PSTestCase.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <OCMock/OCMock.h>

@interface PSTestCase : XCTestCase

- (NSData *)resourceNamed:(NSString *)resourceName;

@end
