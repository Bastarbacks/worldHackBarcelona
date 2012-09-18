//
//  QuestionEntity.m
//  worldHackBacerlona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import "QuestionEntity.h"

@implementation QuestionEntity
@synthesize title = _title;
@synthesize correctAnswerIndex = _correctAnswerIndex;
@synthesize answers = _answers;

- (id)initWithTitle:(NSString *)title
               answers:(NSArray *)answers
         correctAnswer:(NSUInteger)correctAnswer
{
    if (self = [super init])
    {
        self.title = title;
        self.answers = answers;
        self.correctAnswerIndex = correctAnswer;
    }
    
    return self;
}

- (void)dealloc
{
    [_title release];
    [_answers release];
    
    [super dealloc];
}

@end
