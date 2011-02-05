//
//  GameEngineAppDelegate.h
//  GameEngine
//
//  Created by Todd Steinackle on 1/30/11.
//  Copyright 2011 The No Quarter Arcade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameStateManager.h"

@class GameEngineViewController;
@class gsTest;
@class gsMainMenu;
@class gsMenu;

@interface GameEngineAppDelegate : GameStateManager <UIApplicationDelegate> {
    UIWindow *window;
    GameEngineViewController *viewController;

#ifdef FRAME_COUNTER
    CFTimeInterval m_FPS_lastSecondStart;
    int m_FPS_framesThisSecond;
    int m_FPS;
#endif

    gsTest *glTestView;
    gsMainMenu *mainMenu;
    gsMenu *menu;

    NSMutableDictionary *gameStates;
    BOOL rotationSupported;


@private
    BOOL animating;
	BOOL displayLinkSupported;
	NSInteger animationFrameInterval;
	// Use of the CADisplayLink class is the preferred method for controlling your animation timing.
	// CADisplayLink will link to the main display and fire every vsync when added to a given run-loop.
	// The NSTimer class is used only as fallback when running on a pre 3.1 device where CADisplayLink
	// isn't available.
	id displayLink;
    NSTimer *animationTimer;
    CFTimeInterval lastTime;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GameEngineViewController *viewController;
@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;
@property (readonly, nonatomic) BOOL rotationSupported;

- (void) startAnimation;
- (void) stopAnimation;
- (void) gameLoop;
- (void) renderCurrentScene;
- (void) authenticateLocalPlayer;
- (void) registerForAuthenticationNotification;
- (void) authenticationChanged;

@end

