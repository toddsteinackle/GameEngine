//
//  MainMenuView.h

#import <Foundation/Foundation.h>

#import "GameState.h"

@class GameEngineAppDelegate;

@interface MainMenuView : GameState {
	IBOutlet UIView* subview;
    GameEngineAppDelegate *appDelegate;
}

- (IBAction)doGraphicsTest;
- (IBAction)doMenuTest;
- (IBAction)doLeaderboardTest;

@end
