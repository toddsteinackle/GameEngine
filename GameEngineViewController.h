//
//  GameEngineViewController.h
//  GameEngine
//
//  Created by Todd Steinackle on 1/30/11.
//  Copyright 2011 The No Quarter Arcade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@class SettingsMenuViewController;
@class GameEngineAppDelegate;
@class OpenGLViewController;

@interface GameEngineViewController : UIViewController <GKLeaderboardViewControllerDelegate> {
    GKLeaderboardViewController *leaderboardController;
    SettingsMenuViewController *settingsMenu;
    GameEngineAppDelegate *appDelegate;
    OpenGLViewController *glViewController;
}

- (void)showLeaderboard;
- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController;
- (void)showSettingsMenu;
- (void)showGLView;
- (void)dismissGLView;

@end

