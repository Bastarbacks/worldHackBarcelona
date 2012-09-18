#import <UIKit/UIKit.h>

@interface DeezerSampleAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIBackgroundTaskIdentifier	bgTask;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;


@end
