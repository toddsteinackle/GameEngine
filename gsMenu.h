//
//  gsMenu.h

#import <Foundation/Foundation.h>

#import "GameState.h"

@interface gsMenu : GameState {
	IBOutlet UIView* subview;
}

- (IBAction) Done;

@end
