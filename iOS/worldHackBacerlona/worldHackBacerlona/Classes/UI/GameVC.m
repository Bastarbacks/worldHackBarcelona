//
//  GameVC.m
//  worldHackBacerlona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import "GameVC.h"
#import "QuestionCell.h"

@interface GameVC ()

@end

@implementation GameVC
@synthesize myTableView,list;
@synthesize step;

-(void)dealloc{

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
    self.title = [NSString stringWithFormat:@"Step %i/10",step];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
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
    
    switch (indexPath.section) {
        case 0:
            cell.textViewQuestion.text = @"Questionasdasdasdasdasdasdasdas dasdasdasd as sdf dfas fdsdasdasdasda sdasd ?????????????????????????";
            break;
        case 1:
            cell.textViewQuestion.text = [NSString stringWithFormat:@"Answer %i",indexPath.row];
            
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

            break;
        default:
            break;
    }
    
    return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{

    step++;
    self.title = [NSString stringWithFormat:@"Step %i/10",step];
    
    [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    [self.myTableView reloadData];

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
    
    switch (indexPath.section) {
        case 0:
            cell.textViewQuestion.text = @"Questionasdasdasdasdasdasdasdas dasdasdasd as sdf dfas fdsdasdasdasda sdasd ?????????????????????????";
            break;
        case 1:
            cell.textViewQuestion.text = [NSString stringWithFormat:@"Answer %i",indexPath.row];
            
            break;
        default:
            break;
    }
    
    CGRect frame = cell.textViewQuestion.frame;
    frame.size.height = cell.textViewQuestion.contentSize.height;
    cell.textViewQuestion.frame = frame;
    
    
    return 30+cell.textViewQuestion.frame.size.height;
}


@end
