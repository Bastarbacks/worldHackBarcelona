#import <UIKit/UIKit.h>
#import "DeezerSession.h"

@interface DeezerSessionViewController : UIViewController <DeezerSessionConnectionDelegate> {
    
    /******************\
    |* Authorize View *|
    \******************/
    
    // Superview
    IBOutlet UIScrollView* _authorizeView;
    
    // Permissions labels and switches
    IBOutlet UISwitch*  _basicAccessSwitch;
    IBOutlet UISwitch*  _emailAccessSwitch;
    IBOutlet UISwitch*  _offlineAccessSwitch;
    IBOutlet UISwitch*  _manageLibrarySwitch;
    IBOutlet UISwitch*  _deleteLibrarySwitch;
    
    // Authorize button
    IBOutlet UIButton* _authorizeButton;
    
    /**************\
    |* Token View *|
    \**************/
    
    IBOutlet UIScrollView*  _loggedView;
    IBOutlet UILabel*       _tokenLabel;
    IBOutlet UILabel*       _expirationDateLabel;
}

- (IBAction)showUser:(id)sender;
- (IBAction)goToPostActionsView:(id)sender;
- (IBAction)goToDeleteActionsView:(id)sender;
- (IBAction)disconnect:(id)sender;

@end
