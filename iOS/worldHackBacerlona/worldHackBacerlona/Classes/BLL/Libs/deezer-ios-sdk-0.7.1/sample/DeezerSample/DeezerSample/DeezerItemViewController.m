#import "DeezerItemViewController.h"
#import "DeezerItem.h"
#import "DeezerURL.h"
#import "DeezerItemConnection.h"
#import "UIImageView+AFNetworking.h"
#import "JSONKit.h"
#import "DictionaryParser.h"

@interface DeezerItemViewController () {
    NSString* _itemRequestName;
    NSString* _itemID;
}
@end

@implementation DeezerItemViewController

@synthesize item = _item;

- (id)initWithItemRequestName:(NSString*)itemRequestName withID:(NSString*)itemID {
    NSString* nibName;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibName = @"DeezerItemViewController_iPhone";
    } else {
        nibName = @"DeezerItemViewController_iPad";
    }

    if (self = [super initWithNibName:nibName bundle:nil]) {
        [self setTitle:itemRequestName];
        _itemRequestName = [itemRequestName copy];
        _itemID = [itemID copy];
    }
    
    return self;
}

- (void)dealloc {
    [_itemRequestName release];
    [_itemID release];
    [_item release];
    _item = nil;
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[DeezerSession sharedSession] setRequestDelegate:self];
    [[DeezerSession sharedSession] requestItemType:_itemRequestName withDeezerID:_itemID];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Setters

- (void)setItem:(DeezerItem*)item {
    [_item release];
    _item = nil;
    _item = [item retain];
    [_imageView setImageWithURL:[NSURL URLWithString:[_item image]]];
    [_infos setText:[_item description]];
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_item) {
        return [[_item dataForTableView] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DeezerItem* item = [[_item dataForTableView] objectAtIndex:[indexPath row]];
    UITableViewCell* cell = [item cellForTableView:tableView];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DeezerItem* item = [[_item dataForTableView] objectAtIndex:[indexPath row]];
    
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
    [self setItem:[DictionaryParser getItemFromDictionary:dictionary]];
}

- (void)deezerSessionRequestDidFailWithError:(NSError*)error {
}
@end
