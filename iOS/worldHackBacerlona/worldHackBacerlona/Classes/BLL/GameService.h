//
//  GameService.h
//  worldHackBacerlona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import "AFHTTPClient.h"

@class SongInfoEntity;

typedef void (^SuccessCallback)(id data);
typedef void (^ErrorCallback)(NSError *error);

@interface GameService : NSObject

@property (nonatomic, retain) NSArray *questions;

+ (void)getQuestionsAndAnswersWithSuccess:(SuccessCallback)success
                                    error:(ErrorCallback)error;

+ (void)getDeezerPreviewForSongInfo:(SongInfoEntity *)songInfo;

//
+ (void)getUserStatsWithSuccess:(SuccessCallback)success
                          error:(ErrorCallback)error;

+ (NSArray*)questions;

@end
