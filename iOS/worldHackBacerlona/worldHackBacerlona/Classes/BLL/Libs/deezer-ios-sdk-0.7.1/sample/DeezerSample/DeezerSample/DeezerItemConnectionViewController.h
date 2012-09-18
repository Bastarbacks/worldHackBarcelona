#import <UIKit/UIKit.h>
#import "DeezerSession.h"

@interface DeezerItemConnectionViewController : UIViewController <DeezerSessionRequestDelegate, UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView* _tableView;
    
    NSString* _itemName;
    NSString* _itemID;
    NSString* _connectionName;
    NSArray*  _dataArray;
}

@property (nonatomic, retain) NSArray* dataArray;

- (id)initWithConnectionName:(NSString*)connectionName forItemWithName:(NSString*)itemName andID:(NSString*)itemID;

@end
