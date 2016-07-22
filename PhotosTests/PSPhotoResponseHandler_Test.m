//
//  PSPhotoResponseHandler_Test.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSTestCase.h"
#import "PSPhotosResponseHandler.h"
#import "NSObject+Runtime.h"

@interface PSPhotoResponseHandler_Test : PSTestCase

@end

@implementation PSPhotoResponseHandler_Test

- (void)setUp {
    [super setUp];

}

- (void)tearDown {
    [super tearDown];

}

- (void)test_parsingPhotosWorks {
    PSPhotosResponseHandler *handler = [PSPhotosResponseHandler new];
    
    NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Photos" ofType:@"JSON"];
    NSData *responseData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *responseInfo = [NSJSONSerialization JSONObjectWithData:responseData
                                                                 options:0
                                                                   error:NULL];
    
    XCTestExpectation *passedCompletion = [self expectationWithDescription:@"Completion got called"];
    
    [handler handleResponseWithResult:responseInfo
                                error:nil
                           completion:^(PSPhotosResponse *result, NSError *error) {
                               XCTAssert([result isKindOfClass:[PSPhotosResponse class]]);
                               XCTAssert(!error);
                               
                               NSArray *objects = [result.results ?: [NSArray new] arrayByAddingObjectsFromArray:@[result]];
                               
                               for (id object in objects) {
                                   for (NSString *propertyName in [object fullPropertyNameList]) {
                                       id value = [object valueForKey:propertyName];
                                       
                                       XCTAssertNotNil(value);
                                       XCTAssert(value != [NSNull null]);
                                   }
                               }
                               
                               [passedCompletion fulfill];
                           }];
    
    [self waitForExpectationsWithTimeout:1.0 handler:nil];
}

@end
