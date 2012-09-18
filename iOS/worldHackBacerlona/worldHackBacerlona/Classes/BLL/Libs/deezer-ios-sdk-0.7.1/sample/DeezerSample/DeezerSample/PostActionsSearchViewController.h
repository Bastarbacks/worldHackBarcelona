#import "SearchViewController.h"

typedef enum {
    SearchPostAction_AddFavoriteToUser,
    SearchPostAction_AddTrackToPlaylist
} SearchPostAction;

@interface PostActionsSearchViewController : SearchViewController

@property (nonatomic, assign) SearchPostAction postAction;

@end
