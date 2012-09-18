//
//  QuestionEntity.m
//  worldHackBacerlona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import "QuestionEntity.h"
#import "AnswerEntity.h"

@implementation QuestionEntity
@synthesize title = _title;
@synthesize correctAnswerIndex = _correctAnswerIndex;
@synthesize answers = _answers;

- (id)initWithTitle:(NSString *)title
               answers:(NSArray *)answers
         correctAnswer:(NSUInteger)correctAnswerIndex
{
    if (self = [super init])
    {
        self.title = title;
        self.answers = answers;
        self.correctAnswerIndex = correctAnswerIndex;
    }
    
    return self;
}

- (AnswerEntity *)correctAnswer
{
    if (self.answers != nil && self.answers.count >= self.correctAnswerIndex)
    {
        return [self.answers objectAtIndex:self.correctAnswerIndex];
    }
    
    return nil;
}

#pragma mark - Memory Management

- (void)dealloc
{
    [_title release];
    [_answers release];
    
    [super dealloc];
}

@end
