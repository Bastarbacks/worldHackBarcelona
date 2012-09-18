/*
 * DeezerItemViewController is a convenient view controller to show a DeezerItem infos.
 * It has three components :
 * - An image view to show the item's image if it exists (ex: the album cover, the user avatar...);
 * - A text view to show the item's fields;
 * - A table view to show a list of components of the item (ex: the album tracks, ...) and the item's connections (ex: the album comments, the user's friends, ...)
 * 
 * The request for the item is made in the viewWillAppear method, with the item's request name and it's Deezer id, 
 * (http://apiBaseURL/itemRequestName/itemID)
 */

#import <UIKit/UIKit.h>
#import "DeezerSession.h"

@class DeezerItem;

@interface DeezerItemViewController : UIViewController <DeezerSessionRequestDelegate, UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UIImageView* _imageView;
    IBOutlet UITextView*  _infos;
    IBOutlet UITableView* _tableView;
}

@property (nonatomic, retain) DeezerItem* item;

- (id)initWithItemRequestName:(NSString*)itemRequestName withID:(NSString*)itemID;

@end
