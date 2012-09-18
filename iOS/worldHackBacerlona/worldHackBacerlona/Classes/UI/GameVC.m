//
//  GameVC.m
//  worldHackBacerlona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import "GameVC.h"
#import "QuestionCell.h"
#import "QuestionEntity.h"
#import "ResultVC.h"
#import "SongInfoEntity.h"

@interface GameVC ()
-(void) showWin;
-(void) showLose;
-(void) resetBackground;
@end

@implementation GameVC
@synthesize myTableView,list;
@synthesize step,wins,lose,totalSteps;
@synthesize labelWins,labelLost;

-(void)dealloc{
    [labelWins release];
    [labelLost release];
    [myTableView release];
    [super dealloc];
}

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
    step = 1;
    wins = 0;
    lose = 0;
    
    self.labelWins.text = [NSString stringWithFormat:@"%i",wins];
    self.labelLost.text = [NSString stringWithFormat:@"%i",lose];
        
    self.list = [GameService questions];
    totalSteps = [self.list count];
    NSLog(@"%@",list);
    self.title = [NSString stringWithFormat:@"Step %i/%i",step,totalSteps];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
        [self.navigationController.navigationBar setHidden:NO];
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

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.list.count == 0)
        return 0;
    
    return 2;

}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;//[self.list count];
            break;
        default:
            break;
    }
    return [self.list count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"QuestionCell";


    QuestionCell *cell = (QuestionCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"QuestionCell" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (QuestionCell *) currentObject;
				break;
			}
		}
	}
    
    QuestionEntity *quest = [self.list objectAtIndex:step-1];
    
    switch (indexPath.section) {
        case 0:
            cell.textViewQuestion.text = quest.title;
            break;
        case 1:
            cell.textViewQuestion.text = [[quest.answers objectAtIndex:indexPath.row] title];;
            
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

            break;
        default:
            break;
    }
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        if (quest.songInfo.deezerSong != nil)
        {
            cell.songInfo = quest.songInfo;
            cell.playButton.hidden = NO;
            cell.textViewQuestion.frame = CGRectMake(79, 13, 182, 60);
        }
        else
        {
        }
    }
    else
    {
        cell.playButton.hidden = YES;
        cell.textViewQuestion.frame = CGRectMake(11, 13, 250, 60);
    }
    return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    QuestionEntity *quest = [self.list objectAtIndex:step-1];
    
    if ([quest correctAnswerIndex] == indexPath.row) {
        [self showWin];
    }else{
        [self showLose];
    }
    
    //correctAnswerIndex
    step++;
    
    if(step>totalSteps){
        ResultVC *vc = [[ResultVC alloc]initWithNibName:@"ResultVC" bundle:nil andWins:wins andLose:lose andTotal:totalSteps];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }else{
        self.title = [NSString stringWithFormat:@"Step %i/%i",step,totalSteps];
        
        [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        [self.myTableView reloadData];
    }

}

//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
//	[self tableView:tableView didSelectRowAtIndexPath:indexPath];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"QuestionCell";
	
    QuestionCell *cell = (QuestionCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"QuestionCell" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (QuestionCell *) currentObject;
				break;
			}
		}
	}
    
    QuestionEntity *quest = [self.list objectAtIndex:step-1];
    
    switch (indexPath.section) {
        case 0:
            cell.textViewQuestion.text = quest.title;
            break;
        case 1:
            cell.textViewQuestion.text = [[quest.answers objectAtIndex:indexPath.row] title];;
            
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            
            break;
        default:
            break;
    }
    
    CGRect frame = cell.textViewQuestion.frame;
    frame.size.height = cell.textViewQuestion.contentSize.height;
    cell.textViewQuestion.frame = frame;
    
    
    return 10+cell.textViewQuestion.frame.size.height;
}

-(void) showWin{
    wins++;
    self.labelWins.text = [NSString stringWithFormat:@"%i",wins];
    self.labelLost.text = [NSString stringWithFormat:@"%i",lose];
    
    [self.myTableView setBackgroundColor:[UIColor greenColor]];
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    [self performSelectorInBackground:@selector(resetBackground) withObject:nil];
}

-(void) showLose{
    lose++;
    self.labelWins.text = [NSString stringWithFormat:@"%i",wins];
    self.labelLost.text = [NSString stringWithFormat:@"%i",lose];
    [self.myTableView setBackgroundColor:[UIColor redColor]];
    [self.view setBackgroundColor:[UIColor redColor]];
    [self performSelectorInBackground:@selector(resetBackground) withObject:nil];
}

-(void) resetBackground{
//    [self.myTableView setBackgroundColor:[UIColor whiteColor]];
//    [self.view setBackgroundColor:[UIColor whiteColor]];
}


@end
