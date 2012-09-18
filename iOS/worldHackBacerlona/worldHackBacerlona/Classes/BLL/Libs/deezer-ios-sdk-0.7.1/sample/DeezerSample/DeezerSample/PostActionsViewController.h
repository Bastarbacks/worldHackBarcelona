#import <UIKit/UIKit.h>
#import "DeezerSession.h"

@interface PostActionsViewController : UIViewController <DeezerSessionRequestDelegate> {
    IBOutlet UITextField*   _createPlaylistTextField;
    IBOutlet UITextField*   _createFolderTextField;
    
    // for iPhone only
    IBOutlet UIScrollView* _scrollView;
}

- (IBAction)createPlaylist:(id)sender;
- (IBAction)createFolder:(id)sender;
- (IBAction)addFavoriteAlbumOrArtist:(id)sender;

- (IBAction)renamePlaylist:(id)sender;
- (IBAction)addCommentToPlaylist:(id)sender;
- (IBAction)addTrackToPlaylist:(id)sender;
- (IBAction)reorderTracksInPlaylist:(id)sender;

- (IBAction)renameFolder:(id)sender;
- (IBAction)addPlaylistInFolder:(id)sender;
- (IBAction)addAlbumToFolder:(id)sender;

@end
