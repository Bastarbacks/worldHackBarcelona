//
//  GameService.m
//  worldHackBarcelona
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
    @property (nonatomic, retain) AFHTTPClient *game;
    @property (nonatomic, retain) AFHTTPClient *deezer;

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
        myInstance = [[self alloc] init];
        myInstance.game = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://50.17.254.203:6699/"]];
        myInstance.deezer = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.deezer.com/2.0/"]];
	});
    
    return myInstance;
}

#pragma mark - Requests

+ (void)getQuestionsAndAnswersWithSuccess:(SuccessCallback)successCallback
                                    error:(ErrorCallback)errorCallback
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:[self instance].accessToken forKey:@"access_token"];
    NSMutableURLRequest *request = [[self instance].game requestWithMethod:@"GET" path:@"play" parameters:parameters];
    
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
                    songInfo = [[[SongInfoEntity alloc] initWithTitle:[[tmpQuestion objectForKey:@"songInfo"] valueForKey:@"title"]
                                                               album:[[tmpQuestion objectForKey:@"songInfo"] valueForKey:@"album"]
                                                              artist:[[tmpQuestion objectForKey:@"songInfo"] valueForKey:@"artist"]
                                                               cover:[[tmpQuestion objectForKey:@"songInfo"] valueForKey:@"cover"]
                                                             preview:[[tmpQuestion objectForKey:@"songInfo"] valueForKey:@"preview"]] autorelease];
                    
                    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
                    dispatch_async(queue, ^{
                        [self getDeezerPreviewForSongInfo:songInfo];
                    });
                }
                
                QuestionEntity *question = [[QuestionEntity alloc] initWithTitle:title
                                                                         answers:answers
                                                                   correctAnswer:correctAnswer
                                                                        songInfo:songInfo];
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
        [[self instance].game.operationQueue addOperation:operation];
    }
}

+ (void)getDeezerPreviewForSongInfo:(SongInfoEntity *)songInfo
{
    if (songInfo == nil)
    {
        return;
    }
    
    NSString *query = [NSString stringWithFormat:@"%@", songInfo.title];
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:query forKey:@"q"];
    NSMutableURLRequest *request = [[self instance].deezer requestWithMethod:@"GET" path:@"search/track" parameters:parameters];
    
    AFHTTPRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
        
        if (JSON != nil && [JSON objectForKey:@"data"] != nil)
        {
            NSArray *arraySongs = [JSON objectForKey:@"data"];
            
            if (arraySongs.count > 0)
            {
                NSURL *url = [NSURL URLWithString:[[arraySongs objectAtIndex:0] objectForKey:@"preview"]];
                
                songInfo.deezerSong = url;
            }
        }
        
    } failure:^(NSURLRequest *request, NSURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error");
    }];
    
    if (operation)
    {
        [[self instance].deezer.operationQueue addOperation:operation];
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
