//
//  SettingsMenuViewController.h
//  GameEngine
//
//  Created by Todd Steinackle on 2/6/11.
//  Copyright 2011 The No Quarter Arcade. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameEngineAppDelegate;


@interface SettingsMenuViewController : UIViewController {

    GameEngineAppDelegate * appDelegate;

}

- (IBAction)dismiss;

@end
