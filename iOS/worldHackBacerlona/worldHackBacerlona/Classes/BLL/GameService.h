//
//  GameService.h
//  worldHackBacerlona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameService : NSObject

+ (void)loginWithAccessToken:(NSString *)accessToken;

+ (void)getUserStats;

+ (void)getQuestionsAndAnswers;

@end
