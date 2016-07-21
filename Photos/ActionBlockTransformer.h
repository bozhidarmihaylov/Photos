//
//  ActionBlockTransformer.h
//  Photos
//
//  Created by user119008 on 7/21/16.
//  Copyright © 2016 Bozhidar Mihaylov. All rights reserved.
//

#import "ActionBlock.h"

@protocol ActionBlockTransformer <NSObject>

- (ActionBlock)actionBlockForActionBlock:(ActionBlock)actionBlock;

@end
