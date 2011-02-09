//
//  GLESGameState.h
//  GameEngine
//
//  Created by Todd Steinackle on 1/30/11.
//  Copyright 2011 The No Quarter Arcade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameState.h"
#import "ESRenderer.h"

@interface GLESGameState : GameState {

@private
    id <ESRenderer> renderer;

}

- (id)initWithFrame:(CGRect)frame;

@end
