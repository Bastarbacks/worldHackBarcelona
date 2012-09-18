#import "DeezerItemConnectionViewController.h"
#import "DeezerSession.h"
#import "DeezerItem.h"
#import "DeezerURL.h"
#import "DeezerItemViewController.h"
#import "JSONKit.h"
#import "DictionaryParser.h"

@interface DeezerItemConnectionViewController ()

@end

@implementation DeezerItemConnectionViewController

@synthesize dataArray = _dataArray;

- (id)initWithConnectionName:(NSString*)connectionName forItemWithName:(NSString*)itemName andID:(NSString*)itemID {
    NSString* nibName;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibName = @"DeezerItemConnectionViewController_iPhone";
    } else {
        nibName = @"DeezerItemConnectionViewController_iPad";
    }
    
    if (self = [super initWithNibName:nibName bundle:nil]) {
        [self setTitle:connectionName];
        _connectionName = [connectionName copy];
        _itemName = [itemName copy];
        _itemID = [itemID copy];
    }
    
    return self;
}

- (void)dealloc {
    [_connectionName release];
    [_itemName release];
    [_itemID release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[DeezerSession sharedSession] setRequestDelegate:self];
    if (_connectionName && _itemID) {
        [[DeezerSession sharedSession] requestConnectionType:_connectionName forItemType:_itemName withDeezerID:_itemID];
    } else {
        [[DeezerSession sharedSession] requestItemNamed:_itemName];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DeezerItem* item = [_dataArray objectAtIndex:[indexPath row]];
    UITableViewCell* cell = [item cellForTableView:tableView];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DeezerItem* item = [_dataArray objectAtIndex:[indexPath row]];
    
    UIViewController* viewController = [item viewController];
    if (viewController) {
        [[self navigationController] pushViewController:viewController animated:YES];
        return;
    }
    
    if ([item isKindOfClass:[DeezerURL class]]) {
        NSString* urlString = [(DeezerURL*)item urlString];
        if (urlString) {
            [[DeezerSession sharedSession] requestWithURLString:urlString];
        }
        return;
    }
}

#pragma mark - DeezerSessionRequestDelegate

- (void)deezerSessionRequestDidReceiveResponse:(NSData *)data {
    NSDictionary* dictionary = [data objectFromJSONData];
    self.dataArray = [DictionaryParser getItemsFromDictionary:dictionary];
    [_tableView reloadData];
}

- (void)deezerSessionRequestDidFailWithError:(NSError*)error {
}
@end
