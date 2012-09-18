#import "DeezerSessionViewController.h"
#import "DeezerSession.h"
#import "DeezerItemViewController.h"
#import "PostActionsViewController.h"
#import "DeleteActionsViewController.h"
#import "JSONKit.h"

@interface DeezerSessionViewController()
- (void)setIsLoggedIn:(BOOL)isLoogedIn;
@end

@implementation DeezerSessionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Session"];
        [[self tabBarItem] setImage:[UIImage imageNamed:@"first"]];
        [self setView:_authorizeView];
    }
    return self;
}

- (void)dealloc {
    [_authorizeView release];
    [_basicAccessSwitch release];
    [_emailAccessSwitch release];
    [_offlineAccessSwitch release];
    [_manageLibrarySwitch release];
    [_deleteLibrarySwitch release];
    [_authorizeButton release];
    
    [_loggedView release];
    [_tokenLabel release];
    [_expirationDateLabel release];
    
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [_authorizeView setContentSize:CGSizeMake([_authorizeView bounds].size.width, [_authorizeView bounds].size.height)];
        [_loggedView setContentSize:CGSizeMake([_loggedView bounds].size.width, [_loggedView bounds].size.height)];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[DeezerSession sharedSession] setConnectionDelegate:self];
    [self setIsLoggedIn:[[DeezerSession sharedSession] isSessionValid]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[DeezerSession sharedSession] setConnectionDelegate:nil];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


- (void)setIsLoggedIn:(BOOL)isLoggedIn {
    [_tokenLabel setText:[NSString stringWithFormat:@"Token : %@", [[[DeezerSession sharedSession] deezerConnect] accessToken]]];
    [_expirationDateLabel setText:[NSString stringWithFormat:@"Expiration Date : %@", [[[[DeezerSession sharedSession] deezerConnect] expirationDate] description]]];
    [self setView:isLoggedIn ? _loggedView : _authorizeView];
    [_authorizeView setHidden:isLoggedIn];
}


#pragma mark - IBAction
- (IBAction)onAuthorizeButtonPushed:(id)sender {
    
    NSMutableArray* permissionsArray = [NSMutableArray array];
    
    if ([_basicAccessSwitch isOn]) {
        [permissionsArray addObject:@"basic_access"];
    }
    if ([_emailAccessSwitch isOn]) {
        [permissionsArray addObject:@"email"];
    }
    if ([_offlineAccessSwitch isOn]) {
        [permissionsArray addObject:@"offline_access"];
    }
    if ([_manageLibrarySwitch isOn]) {
        [permissionsArray addObject:@"manage_library"];
    }
    if ([_deleteLibrarySwitch isOn]) {
        [permissionsArray addObject:@"delete_library"];
    }
    [[DeezerSession sharedSession] connectToDeezerWithPermissions:permissionsArray];
}

- (IBAction)showUser:(id)sender {
    DeezerItemViewController* itemViewController = [[DeezerItemViewController alloc] initWithItemRequestName:@"user" withID:@"me"];
    [[self navigationController] pushViewController:itemViewController animated:YES];
    [itemViewController release];
}

- (IBAction)goToPostActionsView:(id)sender {
    PostActionsViewController* postActionsViewController = [[PostActionsViewController alloc] init];
    [[self navigationController] pushViewController:postActionsViewController animated:YES];
    [postActionsViewController release];
}

- (IBAction)goToDeleteActionsView:(id)sender {
    DeleteActionsViewController* deleteActionsViewController = [[DeleteActionsViewController alloc] init];
    [[self navigationController] pushViewController:deleteActionsViewController animated:YES];
    [deleteActionsViewController release];
}

- (IBAction)disconnect:(id)sender {
    [[DeezerSession sharedSession] disconnect];
}

#pragma mark - DeezerItemConnectionDelegate

- (void)deezerSessionDidConnect {
    [self setIsLoggedIn:YES];
}

- (void)deezerSessionDidFailConnectionWithError:(NSError*)error {
    
}

- (void)deezerSessionDidDisconnect {
    [self setIsLoggedIn:NO];
}


@end
