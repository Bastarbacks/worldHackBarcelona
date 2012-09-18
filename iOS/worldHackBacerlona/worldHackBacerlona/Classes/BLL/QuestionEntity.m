//
//  QuestionEntity.m
//  worldHackBacerlona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import "QuestionEntity.h"

#import "AnswerEntity.h"
#import "SongInfoEntity.h"

@implementation QuestionEntity
@synthesize title = _title;
@synthesize correctAnswerIndex = _correctAnswerIndex;
@synthesize answers = _answers;
@synthesize songInfo = _songInfo;

- (id)initWithTitle:(NSString *)title
            answers:(NSArray *)answers
      correctAnswer:(NSUInteger)correctAnswerIndex
           songInfo:(SongInfoEntity *)songInfo
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

- (NSString *)description
{
    return [NSString stringWithFormat:@"[Question] %@ (correctAnswer: %d) \n%@", self.title, self.correctAnswerIndex, self.answers];
}

#pragma mark - Memory Management

- (void)dealloc
{
    [_title release];
    [_answers release];
    [_songInfo release];
    
    [super dealloc];
}

@end
