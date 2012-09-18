//
//  GameService.m
//  worldHackBacerlona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import "GameService.h"

@interface GameService ()
    + (GameService *)instance;
@end

@implementation GameService

#pragma mark - Singleton

+ (GameService *)instance
{
    static dispatch_once_t dispatchOncePredicate;
    static GameService *myInstance = nil;
    
    dispatch_once(&dispatchOncePredicate, ^{
        myInstance = [[self alloc] init];
	});
    
    return myInstance;
}

#pragma mark - Requests

+ (void)loginWithAccessToken:(NSString *)accessToken
{

}

+ (void)getUserStats
{

}

+ (void)getQuestionsAndAnswers
{

}

@end
