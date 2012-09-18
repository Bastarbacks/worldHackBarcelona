#import "DeleteItemConnectionViewController.h"
#import "DeleteItemViewController.h"
#import "DeezerItem.h"
#import "DeezerAlbum.h"
#import "DeezerPlaylist.h"
#import "JSONKit.h"

@interface DeleteItemConnectionViewController ()

@end

@implementation DeleteItemConnectionViewController

@synthesize selectedItem = _selectedItem;
@synthesize deleteAction = _deleteAction;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (    (_deleteAction == ItemConnectionDeleteAction_DeleteFolder)
        ||  (_deleteAction == ItemConnectionDeleteAction_RemoveFromFolder_SelectAlbumOrPlaylist)
        ||  (_deleteAction == ItemConnectionDeleteAction_DeletePlaylist)
        ||  (_deleteAction == ItemConnectionDeleteAction_RemoveFavoriteAlbum)
        ||  (_deleteAction == ItemConnectionDeleteAction_RemoveFavoriteArtist)
       ) {
        [_tableView setEditing:YES];
    } else {
        [_tableView setEditing:NO];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DeezerItem* item = [_dataArray objectAtIndex:[indexPath row]];
        
    if (_deleteAction == ItemConnectionDeleteAction_RemoveFromFolder_SelectFolder) {
        DeleteItemConnectionViewController* deleteItemConnectionViewController = [[DeleteItemConnectionViewController alloc] initWithConnectionName:@"items" forItemWithName:@"folder" andID:[item deezerID]];
        [deleteItemConnectionViewController setDeleteAction:ItemConnectionDeleteAction_RemoveFromFolder_SelectAlbumOrPlaylist];
        [deleteItemConnectionViewController setSelectedItem:item];
        [[self navigationController] pushViewController:deleteItemConnectionViewController animated:YES];
        [deleteItemConnectionViewController release];
    }
    
    if (_deleteAction == ItemConnectionDeleteAction_RemoveTrackFromPlaylist_SelectPlaylist) {
        DeleteItemViewController* deleteItemViewController = [[DeleteItemViewController alloc] initWithItemRequestName:@"playlist" withID:[item deezerID]];
        [deleteItemViewController setDeleteAction:ItemDeleteAction_RemoveTrackFromPlaylist_SelectTrack];
        [[self navigationController] pushViewController:deleteItemViewController animated:YES];
        [deleteItemViewController release];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return  (   (_deleteAction == ItemConnectionDeleteAction_DeleteFolder)
            ||  (_deleteAction == ItemConnectionDeleteAction_RemoveFromFolder_SelectAlbumOrPlaylist)
            ||  (_deleteAction == ItemConnectionDeleteAction_DeletePlaylist)
            ||  (_deleteAction == ItemConnectionDeleteAction_RemoveFavoriteAlbum)
            ||  (_deleteAction == ItemConnectionDeleteAction_RemoveFavoriteArtist)
            );
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DeezerItem* item = [_dataArray objectAtIndex:[indexPath row]];
        
        if (_deleteAction == ItemConnectionDeleteAction_DeleteFolder) {
            [[DeezerSession sharedSession] deleteFolder:[item deezerID]];
        }
        
        if (_deleteAction == ItemConnectionDeleteAction_RemoveFromFolder_SelectAlbumOrPlaylist) {
            if ([item isKindOfClass:[DeezerAlbum class]]) {
                [[DeezerSession sharedSession] removeAlbum:[item deezerID] fromFolder:[_selectedItem deezerID]];
            }
            if ([item isKindOfClass:[DeezerPlaylist class]]) {
                [[DeezerSession sharedSession] removePlaylist:[item deezerID] fromFolder:[_selectedItem deezerID]];
            }
        }
        
        if (_deleteAction == ItemConnectionDeleteAction_DeletePlaylist) {
            [[DeezerSession sharedSession] deletePlaylist:[item deezerID]];
        }
        
        if (_deleteAction == ItemConnectionDeleteAction_RemoveFavoriteAlbum) {
            [[DeezerSession sharedSession] removeFavoriteAlbum:[item deezerID] forUser:@"me"];
        }
        
        if (_deleteAction == ItemConnectionDeleteAction_RemoveFavoriteArtist) {
            [[DeezerSession sharedSession] removeFavoriteArtist:[item deezerID] forUser:@"me"];
        }
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

@end
