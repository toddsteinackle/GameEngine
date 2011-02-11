//
//  MainMenuView.h

#import <Foundation/Foundation.h>

#import "GameState.h"

@class GameEngineAppDelegate;

@interface MainMenuView : GameState {
    IBOutlet UIView* subview;
    GameEngineAppDelegate *appDelegate;
    IBOutlet UIButton* leaderboardButton;
}

- (IBAction)doGraphicsTest;
- (IBAction)doMenuTest;
- (IBAction)doLeaderboardTest;

@end
