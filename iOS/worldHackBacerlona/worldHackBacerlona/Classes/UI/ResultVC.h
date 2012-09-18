//
//  ResultVC.h
//  worldHackBacerlona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultVC : UIViewController
{
    UILabel *labelWins;
    UILabel *labelLose;
    UILabel *labelTotal;
    
    int     winsDet;
    int     loseDet;
    int     totalDet;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andWins:(int)wins_ andLose:(int)lose_ andTotal:(int)total_;

@property (nonatomic,retain) IBOutlet UILabel *labelWins;
@property (nonatomic,retain) IBOutlet UILabel *labelLose;
@property (nonatomic,retain) IBOutlet UILabel *labelTotal;

@property (nonatomic,assign) int     winsDet;
@property (nonatomic,assign) int     loseDet;
@property (nonatomic,assign) int     totalDet;

-(IBAction)goStart:(id)sender;
@end
