//
//  QuestionCell.m
//  worldHackBacerlona
//
//  Created by Valenti on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import "QuestionCell.h"

#import <AudioToolbox/AudioToolbox.h>

@implementation QuestionCell
@synthesize playButton;
@synthesize textViewQuestion;
@synthesize songInfo;

-(void)dealloc{
    [textViewQuestion release];
    [playButton release];
    [songInfo release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)playButtonPressed:(id)sender
{
    SystemSoundID soundID;
    
    AudioServicesCreateSystemSoundID((CFURLRef)self.songInfo.deezerSong, &soundID);
    AudioServicesPlaySystemSound (soundID);
}
@end
