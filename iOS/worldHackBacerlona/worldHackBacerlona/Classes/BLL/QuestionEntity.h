//
//  QuestionEntity.h
//  worldHackBarcelona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AnswerEntity;
@class SongInfoEntity;

@interface QuestionEntity : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) NSUInteger correctAnswerIndex;
@property (nonatomic, retain) NSArray *answers;
@property (nonatomic, retain) SongInfoEntity *songInfo;

@property (nonatomic, assign) AnswerEntity *correctAnswer;

- (id)initWithTitle:(NSString *)title
            answers:(NSArray *)answers
      correctAnswer:(NSUInteger)correctAnswerIndex
           songInfo:(SongInfoEntity *)songInfo;

@end
