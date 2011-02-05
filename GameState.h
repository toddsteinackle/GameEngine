//
//  GameState.h
//  GameEngine
//
//  Created by Todd Steinackle on 1/30/11.
//  Copyright 2011 The No Quarter Arcade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameStateManager.h"


@interface GameState : UIView {
    GameStateManager* Manager;
}

- (id) initWithFrame:(CGRect)frame andManager:(GameStateManager*)Manager;
- (void) renderScene;
- (void) updateSceneWithDelta:(float)aDelta;
- (void) drawView:(id)sender;

@end
