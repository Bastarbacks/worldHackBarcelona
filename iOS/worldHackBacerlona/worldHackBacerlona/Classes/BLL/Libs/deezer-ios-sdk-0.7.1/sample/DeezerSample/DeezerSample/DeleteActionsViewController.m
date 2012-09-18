#import "DeleteActionsViewController.h"
#import "DeleteItemViewController.h"
#import "DeleteItemConnectionViewController.h"

@interface DeleteActionsViewController ()

@end

@implementation DeleteActionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSString* nibName;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibName = @"DeleteActionsViewController_iPhone";
    } else {
        nibName = @"DeleteActionsViewController_iPad";
    }
    self = [super initWithNibName:nibName bundle:nil];
    
    return self;
}

- (void)dealloc {
    [_scrollView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [_scrollView setContentSize:CGSizeMake([_scrollView bounds].size.width, [_scrollView bounds].size.height)]; 
        [_scrollView setFrame:[[self view] bounds]]; 
    }
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

- (IBAction)deleteFolder:(id)sender {
    DeleteItemConnectionViewController* deleteItemConnectionViewController = [[DeleteItemConnectionViewController alloc] initWithConnectionName:@"folders" forItemWithName:@"user" andID:@"me"];
    [deleteItemConnectionViewController setDeleteAction:ItemConnectionDeleteAction_DeleteFolder];
    [[self navigationController] pushViewController:deleteItemConnectionViewController animated:YES];
    [deleteItemConnectionViewController release];
}

- (IBAction)removePlaylistFromFolder:(id)sender {
    DeleteItemConnectionViewController* deleteItemConnectionViewController = [[DeleteItemConnectionViewController alloc] initWithConnectionName:@"folders" forItemWithName:@"user" andID:@"me"];
    [deleteItemConnectionViewController setDeleteAction:ItemConnectionDeleteAction_RemoveFromFolder_SelectFolder];
    [[self navigationController] pushViewController:deleteItemConnectionViewController animated:YES];
    [deleteItemConnectionViewController release];
}

- (IBAction)removeAlbumFromFolder:(id)sender {
    DeleteItemConnectionViewController* deleteItemConnectionViewController = [[DeleteItemConnectionViewController alloc] initWithConnectionName:@"folders" forItemWithName:@"user" andID:@"me"];
    [deleteItemConnectionViewController setDeleteAction:ItemConnectionDeleteAction_RemoveFromFolder_SelectFolder];
    [[self navigationController] pushViewController:deleteItemConnectionViewController animated:YES];
    [deleteItemConnectionViewController release];
}

- (IBAction)deletePlaylist:(id)sender {
    DeleteItemConnectionViewController* deleteItemConnectionViewController = [[DeleteItemConnectionViewController alloc] initWithConnectionName:@"playlists" forItemWithName:@"user" andID:@"me"];
    [deleteItemConnectionViewController setDeleteAction:ItemConnectionDeleteAction_DeletePlaylist];
    [[self navigationController] pushViewController:deleteItemConnectionViewController animated:YES];
    [deleteItemConnectionViewController release];
}

- (IBAction)removeTrackFromPlaylist:(id)sender {
    DeleteItemConnectionViewController* deleteItemConnectionViewController = [[DeleteItemConnectionViewController alloc] initWithConnectionName:@"playlists" forItemWithName:@"user" andID:@"me"];
    [deleteItemConnectionViewController setDeleteAction:ItemConnectionDeleteAction_RemoveTrackFromPlaylist_SelectPlaylist];
    [[self navigationController] pushViewController:deleteItemConnectionViewController animated:YES];
    [deleteItemConnectionViewController release];
}

- (IBAction)removeFavoriteAlbum:(id)sender {
    DeleteItemConnectionViewController* deleteItemConnectionViewController = [[DeleteItemConnectionViewController alloc] initWithConnectionName:@"albums" forItemWithName:@"user" andID:@"me"];
    [deleteItemConnectionViewController setDeleteAction:ItemConnectionDeleteAction_RemoveFavoriteAlbum];
    [[self navigationController] pushViewController:deleteItemConnectionViewController animated:YES];
    [deleteItemConnectionViewController release];
}

- (IBAction)removeFavoriteArtist:(id)sender {
    DeleteItemConnectionViewController* deleteItemConnectionViewController = [[DeleteItemConnectionViewController alloc] initWithConnectionName:@"artists" forItemWithName:@"user" andID:@"me"];
    [deleteItemConnectionViewController setDeleteAction:ItemConnectionDeleteAction_RemoveFavoriteArtist];
    [[self navigationController] pushViewController:deleteItemConnectionViewController animated:YES];
    [deleteItemConnectionViewController release];
    
}


@end
