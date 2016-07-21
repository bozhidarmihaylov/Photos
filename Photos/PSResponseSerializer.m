//
//  PSResponseSerializer.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSResponseSerializer.h"
#import "NSError+API.h"

@implementation PSResponseSerializer

- (BOOL)isApiURL:(NSURL *)url {
    NSURL *baseURL = self.apiBaseURL;
    
    return [url.host isEqualToString:baseURL.host]
        && [url.path isEqualToString:baseURL.path];
}

#pragma mark - 

- (NSData *)JSONDataForFlickrResponseData:(NSData *)data {
    NSData *result = data;
    
    NSString *expectedPrefix = @"jsonFlickrApi(";
    NSString *expectedSuffix = @")";
    
    NSString *prefix = @"";
    NSString *suffix = @"";
    
    if (data.length >= expectedPrefix.length + expectedSuffix.length) {
        prefix = [[NSString alloc] initWithBytes:data.bytes
                                          length:expectedPrefix.length
                                        encoding:NSUTF8StringEncoding];
        
        suffix = [[NSString alloc] initWithBytes:data.bytes + data.length - expectedSuffix.length
                                          length:expectedSuffix.length
                                        encoding:NSUTF8StringEncoding];
        
        if ([prefix isEqualToString:expectedPrefix] &&
            [suffix isEqualToString:expectedSuffix])
        {
            const char *responseBytes = data.bytes;
            
            void *bytes = (void *)(responseBytes + expectedPrefix.length);
            NSInteger length = data.length - expectedPrefix.length - expectedSuffix.length;
            
            result = [NSData dataWithBytesNoCopy:bytes
                                          length:length
                                    freeWhenDone:NO];
        }
    }

    return result;
}

- (id)responseObjectForResponse:(NSHTTPURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)outError
{
    id result = nil;
    NSError *error = nil;
    
    NSURL *url = response.URL;
    
    if ([self isApiURL:url]) {
        NSData *jsonData = [self JSONDataForFlickrResponseData:data];
        
        result = [super responseObjectForResponse:response
                                             data:jsonData
                                            error:&error];
        
        NSDictionary *errorInfo = nil;
        
        if (error) {
            if (jsonData) {
                errorInfo = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:0
                                                              error:NULL];
            }
        }
        else {
            NSString *apiStatus = [result valueForKeyPath:@"stat"];

            if ([apiStatus isEqualToString:@"ok"]) {
                // ok
            }
            else if ([apiStatus isEqualToString:@"fail"]) {
                result = nil;
                error = [NSError errorWithDomain:@"com.bozhidarmihaylov.Photos.api" code:2 userInfo:nil];
                
                errorInfo = result;
            }
            else {
                result = nil;
                error = [NSError errorWithDomain:@"com.bozhidarmihaylov.Photos" code:1 userInfo:nil];
            }

        }
        
        if (errorInfo) {
            error.serverSentError = [[PSServerSentError alloc] initWithJSONInfo:errorInfo];
        }
    }
    else {
        [self validateResponse:response
                          data:data
                         error:&error];
        
        if (!error) {
            result = data;
        }
    }
    
    if (outError && error) {
        *outError = error;
    }
    
    return result;
}

@end
