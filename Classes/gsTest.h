//
//  gsTest.h

#import <Foundation/Foundation.h>

#import "GLESGameState.h"

@class Image;
@class ImageRenderManager;
@class SpriteSheet;
@class PackedSpriteSheet;
@class Animation;
@class BitmapFont;
@class ParticleEmitter;

@interface gsTest : GLESGameState {

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
	BitmapFont *bmf;
	NSString *emitterType;

}

@end
