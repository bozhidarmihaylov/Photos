//
//  PSPhotosResponseHandler.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSPhotosResponseHandler.h"
#import "JSONParseUtils.h"

#import <ObjectiveSugar/ObjectiveSugar.h>

@implementation PSPhotosResponseHandler


#pragma mark - PSApiResponseHandler

- (void)handleResponseWithResult:(NSDictionary *)resultJSON
                           error:(NSError *)error
                      completion:(ActionCompletionBlock)completion
{
    if (completion) {
        PSPhotosResponse *result = nil;
        
        if (!error) {
            resultJSON = [resultJSON valueForKeyPath:@"photos"];
            
            resultJSON = [JSONParseUtils dictionaryFromJSON:resultJSON];
            
            if (resultJSON) {
                result = [PSPhotosResponse new];
                
                result.page = [JSONParseUtils numberFromJSON:[resultJSON valueForKeyPath:@"page"]];
                result.perPage = [JSONParseUtils numberFromJSON:[resultJSON valueForKeyPath:@"perpage"]];
                
                result.pageCount = [JSONParseUtils numberFromJSON:[resultJSON valueForKeyPath:@"pages"]];
                result.page = [JSONParseUtils numberFromJSON:[resultJSON valueForKeyPath:@"total"]];
                
                NSArray *photoInfos = [JSONParseUtils arrayFromJSON:[resultJSON valueForKeyPath:@"photo"]];
                
                if (photoInfos.count) {
                    result.results = [photoInfos map:^PSPhoto *(NSDictionary *photoInfo) {
                        PSPhoto *photo = [PSPhoto new];
                        
                        photo.objectId = [JSONParseUtils stringFromJSON:[photoInfo valueForKeyPath:@"id"]];
                        photo.secret = [JSONParseUtils stringFromJSON:[photoInfo valueForKeyPath:@"secret"]];
                        photo.server = [JSONParseUtils stringFromJSON:[photoInfo valueForKeyPath:@"server"]];
                        photo.farm = [JSONParseUtils numberFromJSON:[photoInfo valueForKeyPath:@"farm"]];
                        
                        photo.owner = [JSONParseUtils stringFromJSON:[photoInfo valueForKeyPath:@"owner"]];
                        photo.title = [JSONParseUtils stringFromJSON:[photoInfo valueForKeyPath:@"title"]];
                        
                        photo.isPublic = [JSONParseUtils numberFromJSON:[photoInfo valueForKeyPath:@"ispublic"]];
                        photo.isFriend = [JSONParseUtils numberFromJSON:[photoInfo valueForKeyPath:@"isfriend"]];
                        photo.isFamily = [JSONParseUtils numberFromJSON:[photoInfo valueForKeyPath:@"isfamily"]];
                        
                        return photo;
                    }];
                }
            }
        }
        
        [super handleResponseWithResult:result
                                  error:error
                             completion:completion];
    }
}

@end
