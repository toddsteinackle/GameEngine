//
//  GLView.m

#import "GLView.h"
#import "GameEngineAppDelegate.h"
#import "Image.h"
#import "ImageRenderManager.h"
#import "Animation.h"
#import "BitmapFont.h"
#import "SpriteSheet.h"
#import "PackedSpriteSheet.h"
#import "ParticleEmitter.h"
#import "GameEngineViewController.h"
#import "OpenGLViewController.h"

@implementation GLView

@synthesize viewController;

-(GLView*)initWithFrame:(CGRect)frame {

    appDelegate = (GameEngineAppDelegate *)[[UIApplication sharedApplication] delegate];

    sceneState = 3;
    if ((self = [super initWithFrame:frame])) {
        //do initialization here.
        switch (sceneState) {
            case 1:
                sharedImageRenderManager = [ImageRenderManager sharedImageRenderManager];
                myImage = [[Image alloc] initWithImageNamed:@"knight.gif" filter:GL_LINEAR];
                myImage.color = Color4fMake(1.0, 0.5, 0.5, 0.75);
                myImage1 = [[Image alloc] initWithImageNamed:@"knight.gif" filter:GL_LINEAR];
                scaleAmount = 2;
                break;
            case 2:
                // Grab an instance of the render manager
                sharedImageRenderManager = [ImageRenderManager sharedImageRenderManager];

                // Set the speed at which the image should scale.  This will increase the scale or the image by 3 per second
                scaleAmount = 3;

                // Define a sprite sheet
                packedSpriteSheet = [PackedSpriteSheet  packedSpriteSheetForImageNamed:@"atlas.png" controlFile:@"coordinates" imageFilter:GL_LINEAR];

                Image *spriteSheetImage = [packedSpriteSheet imageForKey:@"player_spritesheet.png"];

                spriteSheet = [SpriteSheet spriteSheetForImage:spriteSheetImage sheetKey:@"spriteSheet" spriteSize:CGSizeMake(40, 40) spacing:0 margin:0];

                // Create three images by taking three different images from the sprite sheet.  Remember that the retain
                // is important as the sprite sheet does not control the life cycle of returned images
                myImage = [[spriteSheet spriteImageAtCoords:CGPointMake(2, 2)] retain];

                myImage1 = [[spriteSheet spriteImageAtCoords:CGPointMake(0, 0)] retain];

                // Set the scale of myImage1
                myImage1.scale = Scale2fMake(2, 4);

                myImage2 = [[spriteSheet spriteImageAtCoords:CGPointMake(1, 3)] retain];
                // Set the color filter
                myImage2.color = Color4fMake(1.0, 0.5, 0.5, 1.0f);

                ////////////////////////////////////////////////////////////////////////
                // Ghost Animation
                ////////////////////////////////////////////////////////////////////////

                // Grab the ghost sprite sheet from within the packed sprite sheet
                Image *ghostImages = [packedSpriteSheet imageForKey:@"ghost_spritesheet.png"];

                // By scaling the image that is going to be used in the sprite sheet, you can create scaled
                // animations.  The command below causes the ghost sprites to be double their normal size
                ghostImages.scale = Scale2fMake(2.0f, 2.0f);

                // Create a sprite sheet using the ghost image we have just obtained
                SpriteSheet *ghostSprites = [SpriteSheet spriteSheetForImage:ghostImages sheetKey:@"ghostImages" spriteSize:CGSizeMake(40, 40) spacing:0 margin:0];

                // Create a new animation instance
                ghostAnim = [[Animation alloc] init];

                // Define how long each frame should be displayed before moving on.  Each frame could have its own
                // delay, they do not all need to be the same.
                float delay = 0.2f;

                // Add the frames of animation to the animation instance
                [ghostAnim addFrameWithImage:[ghostSprites spriteImageAtCoords:CGPointMake(0, 0)] delay:delay];
                [ghostAnim addFrameWithImage:[ghostSprites spriteImageAtCoords:CGPointMake(1, 0)] delay:delay];
                [ghostAnim addFrameWithImage:[ghostSprites spriteImageAtCoords:CGPointMake(2, 0)] delay:delay];

                // Set the state and type of animation
                ghostAnim.state = kAnimationState_Running;
                ghostAnim.type = kAnimationType_PingPong;

                ////////////////////////////////////////////////////////////////////////
                // Player Animation
                ////////////////////////////////////////////////////////////////////////

                // Grab the ghost sprite sheet from within the packed sprite sheet
                Image *playerImages = [packedSpriteSheet imageForKey:@"player_spritesheet.png"];

                // By scaling the image that is going to be used in the sprite sheet, you can create scaled
                // animations.  The command below causes the ghost sprites to be double their normal size
                playerImages.scale = Scale2fMake(2.0f, 2.0f);

                // You can also set the rotation point and rotation of an image that is going to be used as a
                // sprite sheet.  This will cause each image extracted from the sprite sheet to have their
                // properties set to these values
                playerImages.rotationPoint = CGPointMake(20, 20);
                playerImages.rotation = -45.0f;

                // Create a sprite sheet using the ghost image we have just obtained
                SpriteSheet *playerSprites = [SpriteSheet spriteSheetForImage:playerImages sheetKey:@"playerSprites" spriteSize:CGSizeMake(40, 40) spacing:0 margin:0];

                // Create a new animation instance
                playerAnim = [[Animation alloc] init];

                // Define how long each frame should be displayed before moving on.  Each frame could have its own
                // delay, they do not all need to be the same.
                delay = 0.1f;

                // Add the frames of animation to the animation instance
                [playerAnim addFrameWithImage:[playerSprites spriteImageAtCoords:CGPointMake(1, 2) ] delay:delay];
                [playerAnim addFrameWithImage:[playerSprites spriteImageAtCoords:CGPointMake(2, 2) ] delay:delay];
                [playerAnim addFrameWithImage:[playerSprites spriteImageAtCoords:CGPointMake(1, 2) ] delay:delay];
                [playerAnim addFrameWithImage:[playerSprites spriteImageAtCoords:CGPointMake(3, 2) ] delay:delay];

                // Set the state and type of animation
                playerAnim.state = kAnimationState_Running;
                playerAnim.type = kAnimationType_Repeating;

                ////////////////////////////////////////////////////////////////////////
                // Bitmapt Font
                ////////////////////////////////////////////////////////////////////////
                font = [[BitmapFont alloc] initWithFontImageNamed:@"testFont.png" controlFile:@"testFont" scale:Scale2fMake(1, 1) filter:GL_LINEAR];
                break;
            case 3:
                // Grab an instance of the render manager
                sharedImageRenderManager = [ImageRenderManager sharedImageRenderManager];

                pe = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"emitter.pex"];

                break;


            default:
                break;
        }

    }
    return self;
}

-(void)renderScene {

    switch (sceneState) {
        case 1:
            [myImage1 renderCenteredAtPoint:CGPointMake(160, 240)];
            [myImage renderCenteredAtPoint:CGPointMake(160, 240)];
            [sharedImageRenderManager renderImages];
            break;
        case 2:
            // Get each image to render itself
            [myImage renderCenteredAtPoint:CGPointMake(160, 240)];
            [myImage1 renderCenteredAtPoint:CGPointMake(50, 100)];
            [myImage2 renderCenteredAtPoint:CGPointMake(270, 430)];

            [ghostAnim renderCenteredAtPoint:CGPointMake(50, 400)];
            [playerAnim renderCenteredAtPoint:CGPointMake(270, 75)];

            // Ask the image render manager to render all images in its render queue
            [sharedImageRenderManager renderImages];

            // Render text horizontally centered on the screen
            [font renderStringJustifiedInFrame:CGRectMake(0, 250, 320, 80) justification:BitmapFontJustification_TopLeft text:@"Hello"];
            [font renderStringJustifiedInFrame:CGRectMake(0, 150, 320, 80) justification:BitmapFontJustification_BottomRight text:@"World"];

            [sharedImageRenderManager renderImages];
            break;
        case 3:
            glClear(GL_COLOR_BUFFER_BIT);

            // Render the particles
            [pe renderParticles];

            [sharedImageRenderManager renderImages];
            break;


        default:
            break;
    }
}

- (void)updateSceneWithDelta:(float)aDelta {
    float xScale, yScale;
    switch (sceneState) {
        case 1:
            xScale = myImage.scale.x + scaleAmount * aDelta;
            yScale = myImage.scale.y + scaleAmount * aDelta;
            myImage.scale = Scale2fMake(xScale, yScale);
            myImage.rotationPoint = CGPointMake(45 * myImage.scale.x, 15 * myImage.scale.y);
            myImage.rotation = myImage.rotation -= 180 * aDelta;
            if (myImage.scale.x >= 5 || myImage.scale.x <= 1) {
                scaleAmount *= -1;
            }
            break;
        case 2:
            // Change the scale of the image
            xScale = myImage.scale.x + scaleAmount * aDelta;
            yScale = myImage.scale.y + scaleAmount * aDelta;

            // Set the scale of the image based on the values calculated above
            myImage.scale = Scale2fMake(xScale, yScale);

            // Set the point of rotation to the middle of the image taking the scale into account
            myImage.rotationPoint = CGPointMake(20 * myImage.scale.x, 20 * myImage.scale.y);

            // This will rotate the image by 360 degrees per second
            myImage.rotation = myImage.rotation -= 360 * aDelta;

            // Reverse the scaling factor when we reach the limits defined below
            if (myImage.scale.x >= 5 || myImage.scale.x <= 1) {
                scaleAmount *= -1;
            }

            [ghostAnim updateWithDelta:aDelta];
            [playerAnim updateWithDelta:aDelta];
            break;
        case 3:
            // Update the particle emitter using the delta value
            [pe updateWithDelta:aDelta];
            break;


        default:
            break;
    }
}

-(void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    UITouch* touch = [touches anyObject];
    CGPoint loc = [touch locationInView:self];
    NSLog(@"x -- %f y -- %f", loc.x, loc.y);
    NSUInteger numTaps = [touch tapCount];
    if( numTaps > 1 ) {
        [self.viewController showPauseView];
    }
}

@end
