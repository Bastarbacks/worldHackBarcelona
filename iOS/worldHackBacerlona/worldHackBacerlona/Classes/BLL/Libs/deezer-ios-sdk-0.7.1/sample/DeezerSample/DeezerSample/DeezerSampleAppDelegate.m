#import "DeezerSampleAppDelegate.h"

#import "DeezerSessionViewController.h"
#import "GlobalRequestsViewController.h"

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@implementation DeezerSampleAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (void)dealloc {
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    UIViewController *viewController1, *viewController2;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController1 = [[[DeezerSessionViewController alloc] initWithNibName:@"DeezerSessionViewController_iPhone" bundle:nil] autorelease];
        viewController2 = [[[GlobalRequestsViewController alloc] initWithNibName:@"GlobalRequestsViewController_iPhone" bundle:nil] autorelease];
    } else {
        viewController1 = [[[DeezerSessionViewController alloc] initWithNibName:@"DeezerSessionViewController_iPad" bundle:nil] autorelease];
        viewController2 = [[[GlobalRequestsViewController alloc] initWithNibName:@"GlobalRequestsViewController_iPad" bundle:nil] autorelease];
    }
    
    UINavigationController* navController1 = [[[UINavigationController alloc] initWithRootViewController:viewController1] autorelease];
    UINavigationController* navController2 = [[[UINavigationController alloc] initWithRootViewController:viewController2] autorelease];
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    [_tabBarController setViewControllers:[NSArray arrayWithObjects:navController1, navController2, nil]];
    [self.window setRootViewController:_tabBarController];
    [self.window makeKeyAndVisible];
    
    /*
     * This will make the audio played even if the sound of the device is on mute.
     */
    NSError *sessionError = nil;
    [[AVAudioSession sharedInstance] setDelegate:self];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(audioRouteOverride), &audioRouteOverride);
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     * To read the audio in background
     * Don't forget to add "App plays audio" in "Required background modes", in the plist of the project.
     */
    bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    });
}

@end
