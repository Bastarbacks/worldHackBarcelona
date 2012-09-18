#import <UIKit/UIKit.h>
#import "DeezerSession.h"

@interface DeleteActionsViewController : UIViewController <DeezerSessionRequestDelegate> {
    // for iPhone only
    IBOutlet UIScrollView* _scrollView;
}

- (IBAction)deleteFolder:(id)sender;
- (IBAction)removePlaylistFromFolder:(id)sender;
- (IBAction)removeAlbumFromFolder:(id)sender;

- (IBAction)deletePlaylist:(id)sender;
- (IBAction)removeTrackFromPlaylist:(id)sender;

- (IBAction)removeFavoriteAlbum:(id)sender;
- (IBAction)removeFavoriteArtist:(id)sender;

@end
