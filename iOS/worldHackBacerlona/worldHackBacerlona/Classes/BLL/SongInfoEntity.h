//
//  SongInfoEntity.h
//  worldHackBacerlona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

@interface SongInfoEntity : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *album;
@property (nonatomic, retain) NSString *artist;

@property (nonatomic, retain) NSString *cover;
@property (nonatomic, retain) NSString *preview;

- (id)initWithTitle:(NSString *)title
              album:(NSString *)album
             artist:(NSString *)artist
              cover:(NSString *)cover
            preview:(NSString *)preview;

@end
