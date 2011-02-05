//
//  gsMainMenu.m

#import "gsMainMenu.h"
#import "GameEngineAppDelegate.h"
#import "GameEngineViewController.h"

@implementation gsMainMenu

-(gsMainMenu*) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager
{
	if(self = [super initWithFrame:frame andManager:pManager]) {
		//load the .xib file here.
		//this will instantiate the 'subview' uiview.
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [[NSBundle mainBundle] loadNibNamed:@"gsmainmenu-iPad" owner:self options:nil];
        } else {
            [[NSBundle mainBundle] loadNibNamed:@"gsmainmenu" owner:self options:nil];
        }

		//add subview as... a subview.
		//this will let everything from the nib file show up on screen.
		[self addSubview:subview];
	}
	return self;
}

- (IBAction) doGraphicsTest {
	[Manager doStateChange:@"glTest"];
}

- (IBAction) doMenuTest {
    [Manager doStateChange:@"menu"];
}

- (IBAction) doLeaderboardTest {
    GameEngineAppDelegate *appDelegate = (GameEngineAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.viewController showLeaderboard];
}

@end
