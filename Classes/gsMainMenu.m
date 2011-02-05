//
//  gsMainMenu.m

#import "gsMainMenu.h"

@implementation gsMainMenu

-(gsMainMenu*) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager
{
	if(self = [super initWithFrame:frame andManager:pManager]) {
		//load the gsMainMenu.xib file here.
		//this will instantiate the 'subview' uiview.
		[[NSBundle mainBundle] loadNibNamed:@"gsmainmenu" owner:self options:nil];
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

@end
