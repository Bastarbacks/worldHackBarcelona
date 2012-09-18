#import "DeezerItemConnectionViewController.h"

typedef enum {
    ItemConnectionPostAction_Rename,
    ItemConnectionPostAction_AddComment,
    ItemConnectionPostAction_AddInFolder_Select,
    ItemConnectionPostAction_AddInFolder_Add,
    ItemConnectionPostAction_ReOrderPlaylist,
    ItemConnectionPostAction_AddTrackToPlaylist
} ItemConnectionPostAction;

@class DeezerItem;

@interface PostActionsItemConnectionViewController : DeezerItemConnectionViewController <UIAlertViewDelegate>

@property (nonatomic, retain) DeezerItem* selectedItem;
@property (nonatomic, assign) ItemConnectionPostAction postAction;

@end
