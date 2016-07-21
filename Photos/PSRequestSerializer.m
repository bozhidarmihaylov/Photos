//
//  PSRequestSerializer.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSRequestSerializer.h"

@implementation PSRequestSerializer

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)outError
{
    NSError *error = nil;
    NSURLRequest *result = [super requestBySerializingRequest:request
                                               withParameters:parameters
                                                        error:&error];
    
    if (!error) {
        if ([self.delegate respondsToSelector:@selector(requestToGoForRequest:)]) {
            result = [self.delegate requestToGoForRequest:result];
        }
    }
    else if (outError) {
        *outError = error;
    }
    
    return result;
}

@end
