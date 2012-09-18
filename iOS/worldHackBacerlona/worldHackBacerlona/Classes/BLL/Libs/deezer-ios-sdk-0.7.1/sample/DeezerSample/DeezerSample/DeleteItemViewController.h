#import "DeezerItemViewController.h"

typedef enum {
    ItemDeleteAction_RemoveTrackFromPlaylist_SelectTrack
} ItemDeleteAction;

@class DeezerItem;

@interface DeleteItemViewController : DeezerItemViewController

@property (nonatomic, assign) ItemDeleteAction deleteAction;

@end
