//
//  ResultVC.m
//  worldHackBarcelona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import "ResultVC.h"

@interface ResultVC ()

@end

@implementation ResultVC
@synthesize labelWins,labelLose,labelTotal;
@synthesize winsDet,loseDet,totalDet;

-(void)dealloc{
    [labelTotal release];
    [labelLose release];
    [labelWins release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andWins:(int)wins_ andLose:(int)lose_ andTotal:(int)total_
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.winsDet = wins_;
        self.loseDet = lose_;
        self.totalDet = total_;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];

    self.labelWins.text = [NSString stringWithFormat:@"%i",winsDet];
    self.labelLose.text = [NSString stringWithFormat:@"%i",loseDet];
    self.labelTotal.text = [NSString stringWithFormat:@"%i / %i",winsDet,totalDet];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)goStart:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - facebook
-(IBAction)pushFb:(id)sender{

}


@end
