//
//  PSServerSentError.m
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSServerSentError.h"
#import "JSONParseUtils.h"

@implementation PSServerSentError

- (instancetype)initWithJSONInfo:(NSDictionary *)JSONInfo {
    if (self = [super init]) {
        self.code = [JSONParseUtils numberFromJSON:[JSONInfo valueForKeyPath:@"code"]];
        self.message = [JSONParseUtils stringFromJSON:[JSONInfo valueForKeyPath:@"message"]];
    }
    return self;
}

@end
