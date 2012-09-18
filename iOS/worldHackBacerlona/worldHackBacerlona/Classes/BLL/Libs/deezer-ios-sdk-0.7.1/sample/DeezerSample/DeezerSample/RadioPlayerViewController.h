#import <UIKit/UIKit.h>
#import "DeezerSession.h"
#import "DeezerAudioPlayer.h"

@class PlayerAndBufferSlider;

@interface RadioPlayerViewController : UIViewController <DeezerSessionRequestDelegate, DeezerAudioPlayerDelegate> {
    IBOutlet UILabel*       _radioNameLabel;
    IBOutlet UIImageView*   _coverImageView;
    IBOutlet UILabel*       _artistNameLabel;
    IBOutlet UILabel*       _trackNameLabel;
    IBOutlet UILabel*       _albumNameLabel;
    IBOutlet PlayerAndBufferSlider* _progressSliderView;
    
    NSString*           _radioId;
    DeezerPlayerState   _playerState;
    BOOL                _btnActionIsPlay;
}

- (id)initWithRadioId:(NSString *)radioId andName:(NSString*)name;

@end
