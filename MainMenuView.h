//
//  MainMenuView.h

#import <Foundation/Foundation.h>

@class GameEngineAppDelegate;

@interface MainMenuView : UIView {
    IBOutlet UIView* subview;
    GameEngineAppDelegate *appDelegate;
    IBOutlet UIButton* leaderboardButton;
}

- (IBAction)doGraphicsTest;
- (IBAction)doMenuTest;
- (IBAction)doLeaderboardTest;

@end
