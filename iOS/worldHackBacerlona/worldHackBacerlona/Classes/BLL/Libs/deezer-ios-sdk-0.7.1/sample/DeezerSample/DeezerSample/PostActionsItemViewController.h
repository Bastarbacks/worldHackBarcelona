#import "DeezerItemViewController.h"

typedef enum {
    ItemPostAction_ReOrderTracks
} ItemPostAction;

@interface PostActionsItemViewController : DeezerItemViewController

@property (nonatomic, assign) ItemPostAction postAction;

@end
