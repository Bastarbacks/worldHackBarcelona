//
//  GameService.m
//  worldHackBacerlona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import "GameService.h"

#import "AFJSONRequestOperation.h"

@interface GameService ()
@property (nonatomic, readonly) NSString *accessToken;
    + (GameService *)instance;
@end

@implementation GameService

#pragma mark - Singleton

+ (GameService *)instance
{
    static dispatch_once_t dispatchOncePredicate;
    static GameService *myInstance = nil;
    
    dispatch_once(&dispatchOncePredicate, ^{
        myInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://fbhackworld.fegabe.es/"]];
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

        if (successCallback != NULL)
        {
            @try
            {
                successCallback(JSON);
            }
            @catch (NSException *e) {
                
                if (errorCallback != NULL)
                {
                    errorCallback(nil);
                }
                
                return;
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
    return [NSString stringWithFormat:@"hola"];
}


@end
