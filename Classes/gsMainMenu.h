//
//  gsMainMenu.h

#import <Foundation/Foundation.h>

#import "GameState.h"

@interface gsMainMenu : GameState {
	IBOutlet UIView* subview;
}

- (IBAction) doGraphicsTest;

@end
