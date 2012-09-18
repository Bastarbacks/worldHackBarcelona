#import "SearchViewController.h"
#import "DeezerItem.h"
#import "JSONKit.h"
#import "DictionaryParser.h"

@interface SearchViewController ()
@property (nonatomic, retain) NSArray* resultArray;
@end

@implementation SearchViewController

@synthesize resultArray = _resultArray;
@synthesize activeButtons = _activeButtons;

- (id)initWithActiveButtons:(NSInteger)activeButtons {
    NSString* nibName;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nibName = @"SearchViewController_iPhone";
    } else {
        nibName = @"SearchViewController_iPad";
    }
    
    if (self = [super initWithNibName:nibName bundle:nil]) {
        [self setTitle:@"Search"];
        _activeButtons = activeButtons;
    }
    return self;
}

- (void)dealloc {
    [_textField release];
    [_searchTrackButton release];
    [_searchArtistButton release];
    [_searchAlbumButton release];
    [_tableView release];
    [_resultArray release];
    
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setActiveButtons:_activeButtons];
    [[DeezerSession sharedSession] setRequestDelegate:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)setActiveButtons:(NSInteger)activeButtons {
    _activeButtons = activeButtons;
    [_searchTrackButton setHidden:!(activeButtons & SearchButton_TRACKS)];
    [_searchArtistButton setHidden:!(activeButtons & SearchButton_ARTISTS)];
    [_searchAlbumButton setHidden:!(activeButtons & SearchButton_ALBUMS)];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_resultArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DeezerItem* item = [_resultArray objectAtIndex:[indexPath row]];
    UITableViewCell* cell = [item cellForTableView:tableView];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DeezerItem* item = [_resultArray objectAtIndex:[indexPath row]];
    [[self navigationController] pushViewController:[item viewController] animated:YES];
}


#pragma mark - IBActions

- (IBAction)onSearchTracksButtonPressed:(id)sender {
    [[DeezerSession sharedSession] searchTrack:[_textField text]];
    [_textField resignFirstResponder];
}

- (IBAction)onSearchArtistsButtonPressed:(id)sender {
    [[DeezerSession sharedSession] searchArtist:[_textField text]];
    [_textField resignFirstResponder];
}

- (IBAction)onSearchAlbumsButtonPressed:(id)sender {
    [[DeezerSession sharedSession] searchAlbum:[_textField text]];
    [_textField resignFirstResponder];
}


#pragma mark - DeezerSessionRequestDelegate

- (void)deezerSessionRequestDidReceiveResponse:(NSData *)data {
    NSDictionary* dictionary = [data objectFromJSONData];
    self.resultArray = [DictionaryParser getItemsFromDictionary:dictionary];
    [_tableView reloadData];
}


@end
