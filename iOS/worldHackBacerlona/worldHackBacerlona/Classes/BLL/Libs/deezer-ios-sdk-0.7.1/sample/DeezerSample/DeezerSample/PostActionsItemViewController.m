#import "PostActionsItemViewController.h"
#import "DeezerPlaylist.h"
#import "UIImageView+AFNetworking.h"
#import "JSONKit.h"

@interface PostActionsItemViewController ()

@end

@implementation PostActionsItemViewController

@synthesize item = _item;
@synthesize postAction = _postAction;

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView setEditing:YES];
}

#pragma mark - Setters

- (void)setItem:(DeezerItem*)item {
    [_item release];
    _item = [item retain];
    [_imageView setImageWithURL:[NSURL URLWithString:[_item image]]];
    [_infos setText:[_item description]];
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_item) {
        return [[(DeezerPlaylist*)_item tracks] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DeezerItem* item = [[(DeezerPlaylist*)_item tracks] objectAtIndex:[indexPath row]];
    UITableViewCell* cell = [item cellForTableView:tableView];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return (_postAction == ItemPostAction_ReOrderTracks);
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone; 
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSUInteger from = [sourceIndexPath row];
    NSUInteger to = [destinationIndexPath row];
    NSMutableArray* reorderedArray = [NSMutableArray arrayWithArray:[(DeezerPlaylist*)_item tracks]];
    if (to != from) {
        id obj = [reorderedArray objectAtIndex:from];
        [obj retain];
        [reorderedArray removeObjectAtIndex:from];
        if (to >= [reorderedArray count]) {
            [reorderedArray addObject:obj];
        } else {
            [reorderedArray insertObject:obj atIndex:to];
        }
        [obj release];
        
        NSMutableArray* tracksIDsArray = [NSMutableArray arrayWithCapacity:[reorderedArray count]];
        for (int i = 0; i < [reorderedArray count]; i++) {
            [tracksIDsArray addObject:[(DeezerItem*)[reorderedArray objectAtIndex:i] deezerID]];
        }
        [[DeezerSession sharedSession] reorderTracks:tracksIDsArray inPlaylist:[_item deezerID]];
    }
}

#pragma mark - DeezerSessionRequestDelegate

- (void)deezerSessionRequestDidReceiveResponse:(NSData *)data {
    id response = [data objectFromJSONData];
    if (response) {
        [super deezerSessionRequestDidReceiveResponse:data];
    } else {
    }
}

@end
