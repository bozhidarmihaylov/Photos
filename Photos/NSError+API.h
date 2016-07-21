//
//  NSError+API.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "PSServerSentError.h"

@interface NSError (API)

@property (strong, nonatomic) PSServerSentError *serverSentError;

@end
