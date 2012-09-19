//
//  SongInfoEntity.m
//  worldHackBarcelona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import "SongInfoEntity.h"

@implementation SongInfoEntity
@synthesize title = _title;
@synthesize album = _album;
@synthesize artist = _artist;
@synthesize cover = _cover;
@synthesize preview = _preview;
@synthesize deezerSong = _deezerSong;

- (id)initWithTitle:(NSString *)title
              album:(NSString *)album
             artist:(NSString *)artist
              cover:(NSString *)cover
            preview:(NSString *)preview
{
    if (self = [super init])
    {
        self.title = title;
        self.album = album;
        self.artist = artist;
        self.cover = cover;
        self.preview = preview;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"[SongInfo] %@ - %@ (%@)", self.artist, self.title, self.album];
}

#pragma mark - Memory Management

- (void)dealloc
{
    [_title release];
    [_album release];
    [_artist release];
    [_cover release];
    [_preview release];
    [_album release];
    [_deezerSong release];
    
    [super dealloc];
}

@end
