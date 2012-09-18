#import <UIKit/UIKit.h>
#import "DeezerSession.h"

typedef enum {
    SearchButton_TRACKS  = 1 << 0,
    SearchButton_ARTISTS = 1 << 1,
    SearchButton_ALBUMS  = 1 << 2,
} SearchButton;

@interface SearchViewController : UIViewController <DeezerSessionRequestDelegate, UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITextField* _textField;
    IBOutlet UIButton* _searchTrackButton;
    IBOutlet UIButton* _searchArtistButton;
    IBOutlet UIButton* _searchAlbumButton;

    IBOutlet UITableView* _tableView;
    
    NSArray* _resultArray;
}

@property (nonatomic, assign) NSInteger activeButtons;

- (id)initWithActiveButtons:(NSInteger)activeButtons;

@end
