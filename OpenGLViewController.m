//
//  OpenGLViewController.m
//  GameEngine
//
//  Created by Todd Steinackle on 2/6/11.
//  Copyright 2011 The No Quarter Arcade. All rights reserved.
//

#import "OpenGLViewController.h"
#import "GLView.h"
#import "Globals.h"


@implementation OpenGLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            glView = [[GLView alloc] initWithFrame:CGRectMake(0, 0, IPAD_WIDTH, IPAD_HEIGHT)];
        } else {
            glView = [[GLView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
        }
        self.view = glView;
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
    //return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [glView release];
    [super dealloc];
}


@end
