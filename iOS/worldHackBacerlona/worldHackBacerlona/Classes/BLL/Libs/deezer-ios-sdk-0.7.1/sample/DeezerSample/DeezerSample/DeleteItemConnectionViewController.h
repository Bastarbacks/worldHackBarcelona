#import "DeezerItemConnectionViewController.h"

typedef enum {
    ItemConnectionDeleteAction_DeleteFolder,
    ItemConnectionDeleteAction_RemoveFromFolder_SelectFolder,
    ItemConnectionDeleteAction_RemoveFromFolder_SelectAlbumOrPlaylist,
    ItemConnectionDeleteAction_DeletePlaylist,
    ItemConnectionDeleteAction_RemoveTrackFromPlaylist_SelectPlaylist,
    ItemConnectionDeleteAction_RemoveFavoriteAlbum,
    ItemConnectionDeleteAction_RemoveFavoriteArtist
} ItemConnectionDeleteAction;

@class DeezerItem;

@interface DeleteItemConnectionViewController : DeezerItemConnectionViewController

@property (nonatomic, retain) DeezerItem* selectedItem;
@property (nonatomic, assign) ItemConnectionDeleteAction deleteAction;

@end
