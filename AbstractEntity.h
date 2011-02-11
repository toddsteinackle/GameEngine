//
//  AbstractEntity.h
//  GameEngine
//
//  Created by Todd Steinackle on 2/9/11.
//  Copyright 2011 The No Quarter Arcade. All rights reserved.
//

@class Image;
@class SpriteSheet;
@class Animation;
@class ParticleEmitter;
@class SoundManager;
@class GameEngineAppDelegate;

@interface AbstractEntity : NSObject <NSCoding> {

    GameEngineAppDelegate *appDelegate;
    SoundManager *sharedSoundManager;
    Image *image;
    SpriteSheet *spriteSheet;
    Animation *animation;
    CGPoint pixelLocation;
    ParticleEmitter *dyingEmitter;
    ParticleEmitter *appearingEmitter;
    int state;

    CGFloat dx, dy;
    CGFloat collisionWidth, collisionHeight, collisionXOffset, collisionYOffset;
    CGFloat height, width;
    CGFloat scaleFactor;
    CGFloat middleX;
    CGFloat middleY;
}

@property (nonatomic, readonly) Image *image;
@property (nonatomic, assign) CGPoint pixelLocation;
@property (nonatomic, assign) int state;
@property (nonatomic, assign) CGFloat dx;
@property (nonatomic, assign) CGFloat dy;
@property (nonatomic, assign) CGFloat collisionWidth;
@property (nonatomic, assign) CGFloat collisionHeight;
@property (nonatomic, assign) CGFloat collisionXOffset;
@property (nonatomic, assign) CGFloat collisionYOffset;
@property (nonatomic, assign) CGFloat scaleFactor;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, readonly) ParticleEmitter *dyingEmitter;
@property (nonatomic, readonly) ParticleEmitter *appearingEmitter;
@property (nonatomic, assign) CGFloat middleX;
@property (nonatomic, assign) CGFloat middleY;


- (id)initWithPixelLocation:(CGPoint)aLocation;
- (void)updateWithDelta:(float)aDelta;
- (void)render;
- (void)checkForCollisionWithEntity:(AbstractEntity*)otherEntity;

@end
