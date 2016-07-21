//
//  PSApiClient.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSApiClient.h"
#import "PSAppConfig.h"
#import "PSRequestSerializer.h"
#import "PSResponseSerializer.h"

#import <AFNetworking/AFNetworking.h>

static NSString * const PSAppKeyQueryParamName = @"api_key";
static NSString * const PSFormatQueryParamName = @"format";

@interface PSApiClient () <PSRequestSerializerDelegate>

@property (strong, nonatomic) id<PSAppCofig> appConfig;

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation PSApiClient

#pragma mark - Initialization

+ (instancetype)sharedClient {
    static id _sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [self new];
    });
    
    return _sharedClient;
}

- (instancetype)init {
    if (self = [super init]) {
        self.appConfig = [PSAppConfig sharedConfig];
        self.sessionManager = [self newSessionManager];
    }
    return self;
}

- (AFHTTPSessionManager *)newSessionManager {
    AFHTTPSessionManager *result = [[AFHTTPSessionManager alloc] initWithBaseURL:[self.appConfig APIBaseURL]];
    
    result.requestSerializer = [self newRequestSerializer];
    result.responseSerializer = [self newResponseSerializer];
    
    result.completionQueue = dispatch_queue_create("AFCallbackQueue", DISPATCH_QUEUE_CONCURRENT);
    
    return result;
}

- (id<AFURLRequestSerialization>)newRequestSerializer {
    PSRequestSerializer *result = [PSRequestSerializer serializer];
    
    result.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    result.delegate = self;
    
    return result;
}

- (id<AFURLResponseSerialization>)newResponseSerializer {
    PSResponseSerializer *result = [PSResponseSerializer serializer];
    
    result.apiBaseURL = self.appConfig.APIBaseURL;
    
    return result;
}

#pragma mark - PSRequestSerializerDelegate

- (NSURLRequest *)requestToGoForRequest:(NSURLRequest *)request {
    NSURLRequest *result = request;
    
    NSURL *url = request.URL;
    
    if (![url.query containsString:PSAppKeyQueryParamName]) {
        NSMutableURLRequest *mutableRequest = [request mutableCopy];
        
        mutableRequest.URL = [self URLByAddingStaticQueryArgsTorURL:url];
        
        result = [mutableRequest copy];
    }
    
    return result;
}

- (NSURL *)URLByAddingStaticQueryArgsTorURL:(NSURL *)url {
    NSString *urlString = url.absoluteString;
    
    NSString *separatorString = [urlString containsString:@"?"] ? @"&" : @"?";
    
    urlString = [urlString stringByAppendingFormat:@"%@%@=%@&%@=%@", separatorString,
                 PSAppKeyQueryParamName, self.appConfig.APIAppKey,
                 PSFormatQueryParamName, @"json"];
    
    NSURL *result = [NSURL URLWithString:urlString];
    
    return result;
}

#pragma mark - PSApiClient

- (void)GET:(NSString *)URLString
 parameters:(id)parameters
 completion:(ActionCompletionBlock)completion
{
    [self.sessionManager GET:URLString
                  parameters:parameters
                    progress:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         if (completion) {
                             completion(responseObject, nil);
                         }
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         if (completion) {
                             completion(nil, error);
                         }
                     }];
}

- (void)POST:(NSString *)URLString
  parameters:(id)parameters
  completion:(ActionCompletionBlock)completion
{
    [self.sessionManager POST:URLString
                   parameters:parameters
                     progress:nil
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          if (completion) {
                              completion(responseObject, nil);
                          }
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          if (completion) {
                              completion(nil, error);
                          }
                      }];
}

- (void)PUT:(NSString *)URLString
 parameters:(id)parameters
 completion:(ActionCompletionBlock)completion
{
    [self.sessionManager PUT:URLString
                  parameters:parameters
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         if (completion) {
                             completion(responseObject, nil);
                         }
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         if (completion) {
                             completion(nil, error);
                         }
                     }];
}

- (void)DELETE:(NSString *)URLString
    parameters:(id)parameters
    completion:(ActionCompletionBlock)completion
{
    [self.sessionManager DELETE:URLString
                     parameters:parameters
                        success:^(NSURLSessionDataTask *task, id responseObject) {
                            if (completion) {
                                completion(responseObject, nil);
                            }
                        } failure:^(NSURLSessionDataTask *task, NSError *error) {
                            if (completion) {
                                completion(nil, error);
                            }
                        }];
}

@end
