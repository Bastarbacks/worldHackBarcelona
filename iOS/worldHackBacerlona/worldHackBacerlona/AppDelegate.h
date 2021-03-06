//
//  AppDelegate.h
//  worldHackBarcelona
//
//  Created by Oriol Blanc on 18/09/12.
//  Copyright (c) 2012 Bastarbuks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,FBSessionDelegate,FBRequestDelegate,FBDialogDelegate>{

    Facebook                    *facebook;
    id                          detailDelegate;
    
    AVAudioPlayer *_backgroundMusicPlayer;
    BOOL _backgroundMusicPlaying;
    BOOL _backgroundMusicInterrupted;
    UInt32 _otherMusicIsPlaying;
}
@property (nonatomic, retain) id                       detailDelegate;

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) Facebook                 *facebook;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

-(void) initFacebook;
-(void) initFacebook:(id)delegate;

+ (void)playSound:(NSURL *)url;
@end
