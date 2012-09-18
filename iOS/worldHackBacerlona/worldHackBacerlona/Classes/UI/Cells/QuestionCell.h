//
//  QuestionCell.h
//  worldHackBacerlona
//
//  Created by Valenti on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionCell : UITableViewCell
{

    UITextView *textViewQuestion;
}

@property (nonatomic,retain) IBOutlet UITextView *textViewQuestion;

@end
