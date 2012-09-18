//
//  GameService.h
//  worldHackBacerlona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import "AFHTTPClient.h"

typedef void (^SuccessCallback)(id data);
typedef void (^ErrorCallback)(NSError *error);

@interface GameService : AFHTTPClient

+ (void)loginWithAccessToken:(NSString *)accessToken
                     success:(SuccessCallback)success
                       error:(ErrorCallback)error;

+ (void)getQuestionsAndAnswersWithSuccess:(SuccessCallback)success
                                    error:(ErrorCallback)error;


//
+ (void)getUserStatsWithSuccess:(SuccessCallback)success
                          error:(ErrorCallback)error;
@end
