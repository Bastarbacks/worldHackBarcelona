#import "RadioPlayerViewController.h"
#import "PlayerAndBufferSlider.h"
#import "UIImageView+AFNetworking.h"
#import "JSONKit.h"
#import "DeezerTrack.h"
#import "DeezerAlbum.h"
#import "DeezerArtist.h"

@interface RadioPlayerViewController ()
- (void)setCurrentTrack:(DeezerTrack*)track;
@end

@implementation RadioPlayerViewController

- (id)initWithRadioId:(NSString *)radioId andName:(NSString*)name {
    NSString* nibName;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibName = @"RadioPlayerViewController_iPhone";
    } else {
        nibName = @"RadioPlayerViewController_iPad";
    }
    self = [super initWithNibName:nibName bundle:nil];
    
    if (self) {
        [_radioNameLabel setText:name];
        _radioId = [radioId copy];
    }
    
    return self;
}

- (void)dealloc {
    [_coverImageView release];
    [_radioNameLabel release];
    [_artistNameLabel release];
    [_trackNameLabel release];
    [_albumNameLabel release];
    [_progressSliderView release];
    
    [_radioId release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Radios can't be seeked, so we disable user interaction on the slider and hide the knob
    [_progressSliderView setUserInteractionEnabled:NO];
    [_progressSliderView hideKnob];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[DeezerSession sharedSession] setRequestDelegate:self];
    [[DeezerSession sharedSession] requestRadioForListening:_radioId];
    
    [[DeezerAudioPlayer sharedSession] setDelegate:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[DeezerAudioPlayer sharedSession] setDelegate:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)setCurrentTrack:(DeezerTrack*)track {
    [_coverImageView setImageWithURL:[NSURL URLWithString:[[track album] cover]]];
    [_artistNameLabel setText:[[track artist] name]];
    [_trackNameLabel setText:[track title]];
    [_albumNameLabel setText:[[track album] title]];
}

#pragma mark - DeezerSessionRequestDelegate

- (void)deezerSessionRequestDidReceiveResponse:(NSData *)data {
    NSDictionary* dictionary = [data objectFromJSONData];
    
    DeezerTrack* track = [[DeezerTrack alloc] initWithDictionary:dictionary];
    [self setCurrentTrack:track];
    
    NSString* stream = [dictionary objectForKey:@"stream"];
    if ([stream isKindOfClass:[NSString class]]) {
        [[DeezerAudioPlayer sharedSession] initPlayerForRadioWithDeezerId:[track deezerID]
                                                                   stream:stream];
    }
    [track release];
}

- (void)deezerSessionRequestDidFailWithError:(NSError*)error {
    NSLog(@"Request failed : %@", [error description]);
}

#pragma mark - DeezerAudioPlayerDelegate

- (void)bufferStateChanged:(BufferState)bufferState {
    [_progressSliderView setDuration:[[DeezerAudioPlayer sharedSession] trackDuration]];
}

- (void)playerStateChanged:(DeezerPlayerState)playerState {
    switch (playerState) {
        case DeezerPlayerState_Initialized :
            break;
        case DeezerPlayerState_Ready :
            break;
        case DeezerPlayerState_Playing :
            _btnActionIsPlay = NO;
            [_progressSliderView startTimer];
            break;
        case DeezerPlayerState_Paused :
            [_progressSliderView pauseTimer];
            _btnActionIsPlay = YES;
            break;
        case DeezerPlayerState_WaitingForData :
            break;
        case DeezerPlayerState_Stopped :
            [_progressSliderView pauseTimer];
            _btnActionIsPlay = YES;
            break;
        case DeezerPlayerState_Finished :
            break;
    }
}

#pragma mark - DeezerAudioPlayerDelegate

- (void)bufferProgressChanged:(float)bufferProgress {
    [_progressSliderView setBufferProgress:bufferProgress];
    [_progressSliderView setDuration:[[DeezerAudioPlayer sharedSession] trackDuration]];
}

- (void)playerProgressChanged:(float)playerProgress {
    DeezerAudioPlayer* player = [DeezerAudioPlayer sharedSession];
    
    [_progressSliderView setDuration:[player trackDuration]];
    [_progressSliderView setPlayProgress:(playerProgress / [player trackDuration])];
}

- (void)trackDurationDidChange:(long)trackDuration {
    [_progressSliderView setDuration:trackDuration];
}

@end
