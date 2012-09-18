//
//  GameService.m
//  worldHackBacerlona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import "GameService.h"
#import "QuestionEntity.h"
#import "AnswerEntity.h"
#import "SongInfoEntity.h"

#import "AFJSONRequestOperation.h"

@interface GameService ()
    @property (nonatomic, readonly) NSString *accessToken;

    + (GameService *)instance;
@end

@implementation GameService
@synthesize questions = _questions;

#pragma mark - Singleton

+ (GameService *)instance
{
    static dispatch_once_t dispatchOncePredicate;
    static GameService *myInstance = nil;
    
    dispatch_once(&dispatchOncePredicate, ^{
        myInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://50.17.254.203:6699/"]];
	});
    
    return myInstance;
}

#pragma mark - Requests

+ (void)loginWithAccessToken:(NSString *)accessToken
                     success:(SuccessCallback)success
                       error:(ErrorCallback)error
{
    
}

+ (void)getQuestionsAndAnswersWithSuccess:(SuccessCallback)successCallback
                                    error:(ErrorCallback)errorCallback
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:[self instance].accessToken forKey:@"accessToken"];
    NSMutableURLRequest *request = [[self instance] requestWithMethod:@"GET" path:@"play" parameters:parameters];
    
    AFHTTPRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {

        if (JSON != nil && [JSON objectForKey:@"questions"] != nil)
        {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *tmpQuestion in [JSON objectForKey:@"questions"])
            {
                NSString *title = [tmpQuestion valueForKey:@"title"];
                NSUInteger correctAnswer = [[tmpQuestion valueForKey:@"correctAnswer"] intValue];
                NSMutableArray *answers = [NSMutableArray array];
                
                for (NSDictionary *tmpAnswer in [tmpQuestion objectForKey:@"answers"])
                {
                    AnswerEntity *answer = [[AnswerEntity alloc] initWithTitle:[tmpAnswer valueForKey:@"answer"]];
                    [answers addObject:answer];
                    [answer release];
                }
                
                SongInfoEntity *songInfo = nil;
                
                if ([tmpQuestion objectForKey:@"songInfo"])
                {
                    songInfo = [[[SongInfoEntity alloc] initWithTitle:[tmpQuestion valueForKey:@"title"]
                                                               album:[tmpQuestion valueForKey:@"album"]
                                                              artist:[tmpQuestion valueForKey:@"artist"]
                                                               cover:[tmpQuestion valueForKey:@"cover"]
                                                             preview:[tmpQuestion valueForKey:@"preview"]] autorelease];
                }
                
                QuestionEntity *question = [[QuestionEntity alloc] initWithTitle:title
                                                                         answers:answers
                                                                   correctAnswer:correctAnswer
                                                                        songInfo:songInfo];
                [array addObject:question];
                [array addObject:question];//todoooo
                [array addObject:question];
                [question release];
            }
            [self instance].questions = array;
            
            if (successCallback != NULL)
            {
                @try
                {
                    successCallback([self instance].questions);
                }
                @catch (NSException *e) {
                    
                    if (errorCallback != NULL)
                    {
                        errorCallback(nil);
                    }
                    
                    return;
                }
            }
        }
        
    } failure:^(NSURLRequest *request, NSURLResponse *response, NSError *error, id JSON) {
        if (errorCallback != NULL)
        {
            errorCallback(error);
        }
    }];
    
    if (operation)
    {
        [[self instance].operationQueue addOperation:operation];
    }
}

+ (void)getUserStatsWithSuccess:(SuccessCallback)success
                          error:(ErrorCallback)error
{
    
}

#pragma mark - Private Methods

- (NSString *)accessToken
{
    NSString *accessToken = [appDelegate facebook].accessToken;
    return accessToken;
}

+ (NSArray*)questions{
    return [self instance].questions;
}



@end
