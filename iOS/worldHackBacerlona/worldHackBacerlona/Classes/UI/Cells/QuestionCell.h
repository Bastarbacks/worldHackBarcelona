//
//  QuestionCell.h
//  worldHackBarcelona
//
//  Created by Valenti on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongInfoEntity.h"

@interface QuestionCell : UITableViewCell
{

    UITextView *textViewQuestion;
}

@property (retain, nonatomic) IBOutlet UIButton *playButton;
@property (nonatomic,retain) IBOutlet UITextView *textViewQuestion;
@property (nonatomic, retain) SongInfoEntity *songInfo;

- (IBAction)playButtonPressed:(id)sender;

@end
