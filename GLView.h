//
//  GLView.h

#import <Foundation/Foundation.h>

#import "GLESGameState.h"

@class Image;
@class ImageRenderManager;
@class SpriteSheet;
@class PackedSpriteSheet;
@class Animation;
@class BitmapFont;
@class ParticleEmitter;
@class GameEngineAppDelegate;
@class OpenGLViewController;

@interface GLView : GLESGameState {

    GameEngineAppDelegate *appDelegate;
    OpenGLViewController *viewController;

    int sceneState;
    float transY;

    ImageRenderManager *sharedImageRenderManager;

    Image *myImage;
    Image *myImage1;
    Image *myImage2;

    SpriteSheet *spriteSheet;
    PackedSpriteSheet *packedSpriteSheet;
    Animation *ghostAnim;
    Animation *playerAnim;
    BitmapFont *font;

    float scaleAmount;

    ParticleEmitter *pe;

}

@property (nonatomic, retain) OpenGLViewController *viewController;

@end
