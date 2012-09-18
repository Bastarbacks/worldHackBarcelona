//
//  AnswerEntity.m
//  worldHackBacerlona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import "AnswerEntity.h"

@implementation AnswerEntity
@synthesize title = _title;

- (id)initWithTitle:(NSString *)title
{
    if (self = [super init])
    {
        self.title = title;
    }
    
    return self;
}

- (void)dealloc
{
    [_title release];
    
    [super dealloc];
}

@end
