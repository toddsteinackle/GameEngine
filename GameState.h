//
//  GameState.h
//  GameEngine
//
//  Created by Todd Steinackle on 1/30/11.
//  Copyright 2011 The No Quarter Arcade. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameState : UIView {

}

- (id) initWithFrame:(CGRect)frame;
- (void) renderScene;
- (void) updateSceneWithDelta:(float)aDelta;
- (void) drawView:(id)sender;

@end
