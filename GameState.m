//
//  GameState.m
//  GameEngine
//
//  Created by Todd Steinackle on 1/30/11.
//  Copyright 2011 The No Quarter Arcade. All rights reserved.
//

#import "GameState.h"


@implementation GameState

-(id) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		Manager = pManager;
		self.userInteractionEnabled = true;
    }
    return self;
}

- (void) updateSceneWithDelta:(float)aDelta { }
- (void) renderScene { }
- (void) drawView:(id)sender{ }

- (void)dealloc {
    [super dealloc];
}

@end
