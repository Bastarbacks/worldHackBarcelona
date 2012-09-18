#import "PostActionsItemConnectionViewController.h"
#import "PostActionsItemViewController.h"
#import "DeezerItem.h"
#import "DeezerPlaylist.h"
#import "DeezerFolder.h"
#import "DeezerAlbum.h"
#import "JSONKit.h"

@implementation PostActionsItemConnectionViewController

@synthesize selectedItem = _selectedItem;
@synthesize postAction = _postAction;

- (void)dealloc {
    [_selectedItem release];
    [super dealloc];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_postAction == ItemConnectionPostAction_Rename) {
        self.selectedItem = [_dataArray objectAtIndex:[indexPath row]];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Rename item"
                                                            message:@"Enter new name"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Rename", nil];
        [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [alertView show];
        [alertView release];
    }
    
    if (_postAction == ItemConnectionPostAction_AddComment) {
        self.selectedItem = [_dataArray objectAtIndex:[indexPath row]];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Comment"
                                                            message:@"Enter your comment"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Comment", nil];
        [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [alertView show];
        [alertView release];
    }
    
    if (_postAction == ItemConnectionPostAction_AddInFolder_Select) {
        self.selectedItem = [_dataArray objectAtIndex:[indexPath row]];
        PostActionsItemConnectionViewController* postActionsItemConnectionViewController = [[PostActionsItemConnectionViewController alloc] initWithConnectionName:@"folders" forItemWithName:@"user" andID:@"me"];
        [postActionsItemConnectionViewController setSelectedItem:_selectedItem];
        [postActionsItemConnectionViewController setPostAction:ItemConnectionPostAction_AddInFolder_Add];
        [[self navigationController] pushViewController:postActionsItemConnectionViewController animated:YES];
        [postActionsItemConnectionViewController release];
    }
    
    if (_postAction == ItemConnectionPostAction_AddInFolder_Add) {
        // _selected item contains the album or playlist
        DeezerFolder* folder = [_dataArray objectAtIndex:[indexPath row]];
        if ([_selectedItem isKindOfClass:[DeezerAlbum class]]) {
            [[DeezerSession sharedSession] addAlbum:[_selectedItem deezerID] toFolder:[folder deezerID]];
        }
        if ([_selectedItem isKindOfClass:[DeezerPlaylist class]]) {
            [[DeezerSession sharedSession] addPlaylist:[_selectedItem deezerID] toFolder:[folder deezerID]];
        }
    }
    
    if (_postAction == ItemConnectionPostAction_ReOrderPlaylist) {
        DeezerPlaylist* selectedPlaylist = [_dataArray objectAtIndex:[indexPath row]];
        PostActionsItemViewController* postActionsItemViewController = [[PostActionsItemViewController alloc] initWithItemRequestName:@"playlist" withID:[selectedPlaylist deezerID]];
        [postActionsItemViewController setPostAction:ItemPostAction_ReOrderTracks];
        [[self navigationController] pushViewController:postActionsItemViewController animated:YES];
        [postActionsItemViewController release];
    }
    
    if (_postAction == ItemConnectionPostAction_AddTrackToPlaylist) {
        DeezerPlaylist* selectedPlaylist = [_dataArray objectAtIndex:[indexPath row]];
        [[DeezerSession sharedSession] addTrack:[_selectedItem deezerID] toPlaylist:[selectedPlaylist deezerID]];
    }
}

#pragma mark - DeezerSessionRequestDelegate

- (void)deezerSessionRequestDidReceiveResponse:(NSData *)data {
    id response = [data objectFromJSONData];
    if (response) {
        [super deezerSessionRequestDidReceiveResponse:data];
    } else {
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (_postAction == ItemConnectionPostAction_Rename) {
        if (buttonIndex == [alertView firstOtherButtonIndex]) {
            NSString* newTitle = [[alertView textFieldAtIndex:0] text];
            if (newTitle) {
                if ([_selectedItem isKindOfClass:[DeezerPlaylist class]]) {
                    [[DeezerSession sharedSession] renamePlaylist:[_selectedItem deezerID] newTitle:newTitle];
                }
                if ([_selectedItem isKindOfClass:[DeezerFolder class]]) {
                    [[DeezerSession sharedSession] renameFolder:[_selectedItem deezerID] newTitle:newTitle];
                }
            }
        }
    }
    
    if (_postAction == ItemConnectionPostAction_AddComment) {
        if (buttonIndex == [alertView firstOtherButtonIndex]) {
            NSString* comment = [[alertView textFieldAtIndex:0] text];
            if (comment) {
                [[DeezerSession sharedSession] addComment:comment toPlaylist:[_selectedItem deezerID]];
            }
        }
    }
}



@end
