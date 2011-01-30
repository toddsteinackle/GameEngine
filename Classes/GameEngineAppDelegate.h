//
//  GameEngineAppDelegate.h
//  GameEngine
//
//  Created by Todd Steinackle on 1/30/11.
//  Copyright 2011 The No Quarter Arcade. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameEngineViewController;

@interface GameEngineAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GameEngineViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GameEngineViewController *viewController;

@end

