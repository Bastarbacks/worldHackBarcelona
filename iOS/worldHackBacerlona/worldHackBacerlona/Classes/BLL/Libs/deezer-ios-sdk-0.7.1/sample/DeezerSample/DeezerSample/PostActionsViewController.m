#import "PostActionsViewController.h"
#import "DeezerSession.h"
#import "PostActionsItemViewController.h"
#import "PostActionsItemConnectionViewController.h"
#import "PostActionsSearchViewController.h"

@interface PostActionsViewController ()

@end

@implementation PostActionsViewController

- (id)init {
    NSString* nibName;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibName = @"PostActionsViewController_iPhone";
    } else {
        nibName = @"PostActionsViewController_iPad";
    }
    self = [super initWithNibName:nibName bundle:nil];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [_scrollView setContentSize:CGSizeMake([_scrollView bounds].size.width, [_scrollView bounds].size.height)]; 
        [_scrollView setFrame:[[self view] bounds]]; 
    }
}

- (void)dealloc {
    [_createPlaylistTextField release];
    [_createFolderTextField release];
    [_scrollView release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[DeezerSession sharedSession] setRequestDelegate:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - IBActions

- (IBAction)createPlaylist:(id)sender {
    if ([_createPlaylistTextField text]) {
        [[DeezerSession sharedSession] createPlaylistNamed:[_createPlaylistTextField text] forUser:@"me"];
    }
}

- (IBAction)createFolder:(id)sender {
    if ([_createFolderTextField text]) {
        [[DeezerSession sharedSession] createFolderNamed:[_createPlaylistTextField text] forUser:@"me"];
    }
}

- (IBAction)addFavoriteAlbumOrArtist:(id)sender {
    PostActionsSearchViewController* postActionsSearchViewController = [[PostActionsSearchViewController alloc] initWithActiveButtons:SearchButton_ARTISTS|SearchButton_ALBUMS];
    [postActionsSearchViewController setPostAction:SearchPostAction_AddFavoriteToUser];
    [[self navigationController] pushViewController:postActionsSearchViewController animated:YES];
    [postActionsSearchViewController release];
}

- (IBAction)renamePlaylist:(id)sender {
    PostActionsItemConnectionViewController* postActionsItemConnectionViewController = [[PostActionsItemConnectionViewController alloc] initWithConnectionName:@"playlists" forItemWithName:@"user" andID:@"me"];
    [postActionsItemConnectionViewController setPostAction:ItemConnectionPostAction_Rename];
    [[self navigationController] pushViewController:postActionsItemConnectionViewController animated:YES];
    [postActionsItemConnectionViewController release];
}

- (IBAction)addCommentToPlaylist:(id)sender {
    PostActionsItemConnectionViewController* postActionsItemConnectionViewController = [[PostActionsItemConnectionViewController alloc] initWithConnectionName:@"playlists" forItemWithName:@"user" andID:@"me"];
    [postActionsItemConnectionViewController setPostAction:ItemConnectionPostAction_AddComment];
    [[self navigationController] pushViewController:postActionsItemConnectionViewController animated:YES];
    [postActionsItemConnectionViewController release];
}

- (IBAction)addTrackToPlaylist:(id)sender {
    PostActionsSearchViewController* postActionsSearchViewController = [[PostActionsSearchViewController alloc] initWithActiveButtons:SearchButton_TRACKS];
    [postActionsSearchViewController setPostAction:SearchPostAction_AddTrackToPlaylist];
    [[self navigationController] pushViewController:postActionsSearchViewController animated:YES];
    [postActionsSearchViewController release];
}

- (IBAction)reorderTracksInPlaylist:(id)sender {
    PostActionsItemConnectionViewController* postActionsItemConnectionViewController = [[PostActionsItemConnectionViewController alloc] initWithConnectionName:@"playlists" forItemWithName:@"user" andID:@"me"];
    [postActionsItemConnectionViewController setPostAction:ItemConnectionPostAction_ReOrderPlaylist];
    [[self navigationController] pushViewController:postActionsItemConnectionViewController animated:YES];
    [postActionsItemConnectionViewController release];
}


- (IBAction)renameFolder:(id)sender {
    PostActionsItemConnectionViewController* postActionsItemConnectionViewController = [[PostActionsItemConnectionViewController alloc] initWithConnectionName:@"folders" forItemWithName:@"user" andID:@"me"];
    [postActionsItemConnectionViewController setPostAction:ItemConnectionPostAction_Rename];
    [[self navigationController] pushViewController:postActionsItemConnectionViewController animated:YES];
    [postActionsItemConnectionViewController release];
}

- (IBAction)addPlaylistInFolder:(id)sender {
    PostActionsItemConnectionViewController* postActionsItemConnectionViewController = [[PostActionsItemConnectionViewController alloc] initWithConnectionName:@"playlists" forItemWithName:@"user" andID:@"me"];
    [postActionsItemConnectionViewController setPostAction:ItemConnectionPostAction_AddInFolder_Select];
    [[self navigationController] pushViewController:postActionsItemConnectionViewController animated:YES];
    [postActionsItemConnectionViewController release];
    
}

- (IBAction)addAlbumToFolder:(id)sender {
    PostActionsItemConnectionViewController* postActionsItemConnectionViewController = [[PostActionsItemConnectionViewController alloc] initWithConnectionName:@"albums" forItemWithName:@"user" andID:@"me"];
    [postActionsItemConnectionViewController setPostAction:ItemConnectionPostAction_AddInFolder_Select];
    [[self navigationController] pushViewController:postActionsItemConnectionViewController animated:YES];
    [postActionsItemConnectionViewController release];
    
}


#pragma mark - DeezerSessionRequestDelegate

- (void)deezerSessionRequestDidReceiveResponse:(NSData*)data {
    
}

- (void)deezerSessionRequestDidFailWithError:(NSError*)error {
    
}

@end
