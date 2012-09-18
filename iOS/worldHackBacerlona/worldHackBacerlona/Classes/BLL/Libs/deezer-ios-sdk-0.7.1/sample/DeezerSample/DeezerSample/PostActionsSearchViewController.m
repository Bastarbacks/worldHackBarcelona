#import "PostActionsSearchViewController.h"
#import "PostActionsItemConnectionViewController.h"
#import "DeezerItem.h"
#import "DeezerAlbum.h"
#import "DeezerArtist.h"
#import "JSONKit.h"

@interface PostActionsSearchViewController ()

@end

@implementation PostActionsSearchViewController

@synthesize postAction = _postAction;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DeezerItem* item = [_resultArray objectAtIndex:[indexPath row]];
    
    if (_postAction == SearchPostAction_AddFavoriteToUser) {
    
        if ([item isKindOfClass:[DeezerAlbum class]]) {
            [[DeezerSession sharedSession] addFavoriteAlbum:[item deezerID] toUser:@"me"];
        }
    
        if ([item isKindOfClass:[DeezerArtist class]]) {
            [[DeezerSession sharedSession] addFavoriteArtist:[item deezerID] toUser:@"me"];
        }
    }
    
    if (_postAction == SearchPostAction_AddTrackToPlaylist) {
        PostActionsItemConnectionViewController* postActionsItemConnectionViewController = [[PostActionsItemConnectionViewController alloc] initWithConnectionName:@"playlists" forItemWithName:@"user" andID:@"me"];
        [postActionsItemConnectionViewController setSelectedItem:item];
        [postActionsItemConnectionViewController setPostAction:ItemConnectionPostAction_AddTrackToPlaylist];
        [[self navigationController] pushViewController:postActionsItemConnectionViewController animated:YES];
        [postActionsItemConnectionViewController release];
    }
}

- (void)deezerSessionRequestDidReceiveResponse:(NSData *)data {
    id response = [data objectFromJSONData];
    if (response) {
        [super deezerSessionRequestDidReceiveResponse:data];
    } else {
        [[self navigationController] popViewControllerAnimated:YES];
    }
}


@end
