//
//  QuestionEntity.h
//  worldHackBacerlona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AnswerEntity;

@interface QuestionEntity : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) NSUInteger correctAnswerIndex;
@property (nonatomic, retain) NSArray *answers;

@property (nonatomic, assign) AnswerEntity *correctAnswer;

@end
