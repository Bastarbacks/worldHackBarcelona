#import "DeleteItemViewController.h"
#import "DeezerPlaylist.h"
#import "UIImageView+AFNetworking.h"
#import "JSONKit.h"

@interface DeleteItemViewController ()

@end

@implementation DeleteItemViewController

@synthesize item = _item;
@synthesize deleteAction = _deleteAction;

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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    DeezerItem* selectedItem = [[(DeezerPlaylist*)_item tracks] objectAtIndex:[indexPath row]];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (_deleteAction == ItemDeleteAction_RemoveTrackFromPlaylist_SelectTrack) {
            [[DeezerSession sharedSession] removeTrack:[selectedItem deezerID] fromPlaylist:[_item deezerID]];
        }
    }    
}

#pragma mark - DeezerSessionRequestDelegate

- (void)deezerSessionRequestDidReceiveResponse:(NSData *)data {
    id response = [data objectFromJSONData];
    if (response) {
        [super deezerSessionRequestDidReceiveResponse:data];
    } else {
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

@end
