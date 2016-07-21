//
//  PSRequestSerializer.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@class PSRequestSerializer;
@protocol PSRequestSerializerDelegate <NSObject>

@optional
- (NSURLRequest *)requestToGoForRequest:(NSURLRequest *)request;

@end

@interface PSRequestSerializer : AFJSONRequestSerializer

@property (weak, nonatomic) id<PSRequestSerializerDelegate> delegate;

@end
