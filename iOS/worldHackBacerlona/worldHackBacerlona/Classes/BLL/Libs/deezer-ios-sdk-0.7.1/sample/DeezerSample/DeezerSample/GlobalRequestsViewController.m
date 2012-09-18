#import "GlobalRequestsViewController.h"
#import "SearchViewController.h"
#import "DeezerItemConnectionViewController.h"

@interface GlobalRequestsViewController ()

@end

@implementation GlobalRequestsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Global Requests"];
        [[self tabBarItem] setImage:[UIImage imageNamed:@"second"]];
    }
    return self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)goToSearchView:(id)sender {
    SearchViewController* searchViewController = [[SearchViewController alloc] initWithActiveButtons:SearchButton_TRACKS|SearchButton_ARTISTS|SearchButton_ALBUMS];
    [[self navigationController] pushViewController:searchViewController animated:YES];
    [searchViewController release];
}

- (IBAction)goToEditorialView:(id)sender {
    DeezerItemConnectionViewController* deezerItemConnectionViewController = [[DeezerItemConnectionViewController alloc] initWithConnectionName:nil forItemWithName:@"editorial" andID:nil];
    [[self navigationController] pushViewController:deezerItemConnectionViewController animated:YES];
    [deezerItemConnectionViewController release];
}

- (IBAction)goToRadiosView:(id)sender {
    DeezerItemConnectionViewController* deezerItemConnectionViewController = [[DeezerItemConnectionViewController alloc] initWithConnectionName:nil forItemWithName:@"radio" andID:nil];
    [[self navigationController] pushViewController:deezerItemConnectionViewController animated:YES];
    [deezerItemConnectionViewController release];
}

@end
