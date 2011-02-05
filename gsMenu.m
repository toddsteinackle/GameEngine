//
//  gsMenu.m

#import "gsMenu.h"

@implementation gsMenu

-(gsMenu*) initWithFrame:(CGRect)frame andManager:(GameStateManager*)pManager
{
	if(self = [super initWithFrame:frame andManager:pManager]) {
		//load the gsMainMenu.xib file here.
		//this will instantiate the 'subview' uiview.
		[[NSBundle mainBundle] loadNibNamed:@"gsMenu" owner:self options:nil];
		//add subview as... a subview.
		//this will let everything from the nib file show up on screen.
		[self addSubview:subview];
	}
	return self;
}

- (IBAction) Done {
	[Manager doStateChange:@"MainMenu"];
}

@end
