//
//  WelcomeViewController.m
//  worldHackBacerlona
//
//  Created by Valenti on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LoginVC.h"
#import "GameVC.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //if session no valid
    
    LoginVC *vc = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
    [self presentModalViewController:vc animated:NO];
    [vc release];
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

#pragma mark - action

-(IBAction)start:(id)sender{
    GameVC * vc = [[[GameVC alloc] initWithNibName:@"GameVC" bundle:nil] autorelease];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
