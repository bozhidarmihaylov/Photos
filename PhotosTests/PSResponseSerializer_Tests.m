//
//  PSResponseSerializer_Tests.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSTestCase.h"
#import "PSResponseSerializer.h"
#import "NSError+API.h"

@interface PSResponseSerializer_Tests : PSTestCase

@property (strong, nonatomic) PSResponseSerializer *serializer;

@end

@implementation PSResponseSerializer_Tests

- (NSURL *)baseURL {
    return [NSURL URLWithString:@"https://dir.bg/"];
}

- (NSData *)successfulData {
    return [self resourceNamed:@"Photos.JS"];
}

- (NSData *)failureData {
    return [self resourceNamed:@"Error.JS"];
}


- (void)setUp {
    [super setUp];
    
    self.serializer = [PSResponseSerializer serializer];
    self.serializer.apiBaseURL = self.baseURL;
}

- (void)tearDown {
    [super tearDown];
}

- (void)test_ThatIt_ConvertsToJSON {
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:self.baseURL
                                                        MIMEType:@"text/javascript"
                                           expectedContentLength:1024
                                                textEncodingName:@"UTF-8"];
    NSError *error = nil;
    NSDictionary *responseInfo = [self.serializer responseObjectForResponse:response
                                                                       data:self.successfulData
                                                                      error:&error];
    XCTAssertNil(error);
    XCTAssert([responseInfo isKindOfClass:[NSDictionary class]]);
    XCTAssertEqual(responseInfo.count, 2);
    
    NSArray *photos = [responseInfo valueForKeyPath:@"photos.photo"];
    
    XCTAssert([photos isKindOfClass:[NSArray class]]);
    XCTAssertEqual(photos.count, 10);
}

- (void)test_ThatIt_FailsIfCodeAbove300 {
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:self.baseURL
                                                              statusCode:305
                                                             HTTPVersion:@"1.0"
                                                            headerFields:nil];
    NSError *error = nil;
    NSDictionary *responseInfo = [self.serializer responseObjectForResponse:response
                                                                       data:self.successfulData
                                                                      error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertNil(responseInfo);
}

- (void)test_ThatIt_HandlesServerReturnedError {
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:self.baseURL
                                                              statusCode:213
                                                             HTTPVersion:@"1.0"
                                                            headerFields:nil];
    NSError *error = nil;
    NSDictionary *responseInfo = [self.serializer responseObjectForResponse:response
                                                                       data:self.failureData
                                                                      error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertNil(responseInfo);
    XCTAssertNotNil(error.serverSentError.code);
    XCTAssertNotNil(error.serverSentError.message);
}

@end
