//
//  PSServerSentError.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSObject.h"

@interface PSServerSentError : PSObject

- (instancetype)initWithJSONInfo:(NSDictionary *)JSONInfo;

@property (strong, nonatomic) NSNumber *code;
@property (copy, nonatomic) NSString *message;

@end
