//
//  OpenGLViewController.h
//  GameEngine
//
//  Created by Todd Steinackle on 2/6/11.
//  Copyright 2011 The No Quarter Arcade. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLView;
@class PauseMenuViewController;
@class GameEngineAppDelegate;

@interface OpenGLViewController : UIViewController {
    GLView *glView;
    PauseMenuViewController *pauseMenu;
    GameEngineAppDelegate *appDelegate;
}

- (void)showPauseView;
- (void)dismissPauseView;
- (void)quitGame;

@end
