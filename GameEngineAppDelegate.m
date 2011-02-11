//
//  GameEngineAppDelegate.m
//  GameEngine
//
//  Created by Todd Steinackle on 1/30/11.
//  Copyright 2011 The No Quarter Arcade. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <GameKit/GameKit.h>
#import "GameEngineAppDelegate.h"
#import "GameEngineViewController.h"
#import "GLESGameState.h"

BOOL isGameCenterAvailable() {
    // Check for presence of GKLocalPlayer API.
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    // The device must be running running iOS 4.1 or later.
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer
                                           options:NSNumericSearch] != NSOrderedAscending);
    return (gcClass && osVersionSupported);
}

@implementation GameEngineAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize currentViewController;
@synthesize animating;
@dynamic animationFrameInterval;
@synthesize gameCenterAvailable;
@synthesize ios4orGreater;

#pragma mark -
#pragma mark Game Engine

#define MAXIMUM_FRAME_RATE 45
#define MINIMUM_FRAME_RATE 15
#define UPDATE_INTERVAL (1.0 / MAXIMUM_FRAME_RATE)
#define MAX_CYCLES_PER_FRAME (MAXIMUM_FRAME_RATE / MINIMUM_FRAME_RATE)

- (void)gameLoop {

    static double lastFrameTime = 0.0f;
    static double cyclesLeftOver = 0.0f;
    double currentTime;
    double updateIterations;

#ifdef FRAME_COUNTER
    double currTime = [[NSDate date] timeIntervalSince1970];
    m_FPS_framesThisSecond++;
    float timeThisSecond = currTime - m_FPS_lastSecondStart;
    if( timeThisSecond > 1.0f ) {
        m_FPS = m_FPS_framesThisSecond;
        m_FPS_framesThisSecond = 0;
        m_FPS_lastSecondStart = currTime;
        NSLog(@"fps -- %i", m_FPS);
    }
#endif

    // Apple advises to use CACurrentMediaTime() as CFAbsoluteTimeGetCurrent() is synced with the mobile
    // network time and so could change causing hiccups.
    currentTime = CACurrentMediaTime();
    updateIterations = ((currentTime - lastFrameTime) + cyclesLeftOver);

    if(updateIterations > (MAX_CYCLES_PER_FRAME * UPDATE_INTERVAL))
        updateIterations = (MAX_CYCLES_PER_FRAME * UPDATE_INTERVAL);

    while (updateIterations >= UPDATE_INTERVAL) {
        updateIterations -= UPDATE_INTERVAL;

        // Update the game logic passing in the fixed update interval as the delta
        [((GameState*)currentViewController.view) updateSceneWithDelta:UPDATE_INTERVAL];
    }

    cyclesLeftOver = updateIterations;
    lastFrameTime = currentTime;

    // Render the scene
    [((GameState*)currentViewController.view) drawView:nil];
}

- (void) renderCurrentScene {
    [((GameState*)currentViewController.view) renderScene];
}

- (NSInteger)animationFrameInterval {
    return animationFrameInterval;
}

- (void)setAnimationFrameInterval:(NSInteger)frameInterval {
    // Frame interval defines how many display frames must pass between each time the
    // display link fires. The display link will only fire 30 times a second when the
    // frame interval is two on a display that refreshes 60 times a second. The default
    // frame interval setting of one will fire 60 times a second when the display refreshes
    // at 60 times a second. A frame interval setting of less than one results in undefined
    // behavior.
    if (frameInterval >= 1)
    {
        animationFrameInterval = frameInterval;

        if (animating)
        {
            [self stopAnimation];
            [self startAnimation];
        }
    }
}

- (void)startAnimation {
    if (!animating)
    {
        if (displayLinkSupported)
        {
            // CADisplayLink is API new to iPhone SDK 3.1. Compiling against earlier versions will result in a warning, but can be dismissed
            // if the system version runtime check for CADisplayLink exists in -initWithCoder:. The runtime check ensures this code will
            // not be called in system versions earlier than 3.1.

            displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(gameLoop)];
            [displayLink setFrameInterval:animationFrameInterval];
            [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        }
        else
            animationTimer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)((1.0 / 60.0) * animationFrameInterval)
                                                              target:self selector:@selector(gameLoop) userInfo:nil repeats:TRUE];

        animating = TRUE;

        // Setup the lastTime ivar
        lastTime = CFAbsoluteTimeGetCurrent();
    }
}

- (void)stopAnimation {
    if (animating)
    {
        if (displayLinkSupported)
        {
            [displayLink invalidate];
            displayLink = nil;
        }
        else
        {
            [animationTimer invalidate];
            animationTimer = nil;
        }

        animating = FALSE;
    }
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Override point for customization after application launch.

    if (isGameCenterAvailable()) {
        gameCenterAvailable = TRUE;
    }

    [viewController customInit];

    //now set our view as visible
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

    animating = FALSE;
    displayLinkSupported = FALSE;
    animationFrameInterval = 1;
    displayLink = nil;
    animationTimer = nil;

    // A system version of 3.1 or greater is required to use CADisplayLink. The NSTimer
    // class is used as fallback when it isn't available.
    NSString *reqSysVer = @"3.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
        displayLinkSupported = TRUE;
    reqSysVer = @"4.0";
    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
        ios4orGreater = TRUE;

    currentViewController = viewController;

#ifdef GAMECENTER
    if (gameCenterAvailable) {
#ifdef GAMECENTER_DEBUG
        NSLog(@"Game Center Available");
#endif
        [self authenticateLocalPlayer];
        [self registerForAuthenticationNotification];
    } else {
#ifdef GAMECENTER_DEBUG
        NSLog(@"Game Center Not Available");
#endif
        gameCenterAvailable = FALSE;
    }
#endif

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state.
     This can occur for certain types of temporary interruptions (such as an
     incoming phone call or SMS message) or when the user quits the application
     and it begins the transition to the background state.

     Use this method to pause ongoing tasks, disable timers, and throttle down
     OpenGL ES frame rates. Games should use this method to pause the game.
     */
    [self stopAnimation];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate
     timers, and store enough application state information to restore your
     application to its current state in case it is terminated later.

     If your application supports background execution, called instead of
     applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state:
     here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the
     application was inactive. If the application was previously in the
     background, optionally refresh the user interface.
     */
    if ([currentViewController.view isKindOfClass:[GLESGameState class]]) {
        [self startAnimation];
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
    [self stopAnimation];
}

#pragma mark -
#pragma mark Game Center

- (void)authenticateLocalPlayer {
    [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
        if (error == nil)
        {
            // Insert code here to handle a successful authentication.
#ifdef GAMECENTER_DEBUG
            NSLog(@"player authenticated -- initial");
#endif
        }

        else
        {
            // Your application can process the error parameter to report the error to the player.
#ifdef GAMECENTER_DEBUG
            NSLog(@"GC authenticateWithCompletionHandler error");
#endif
        }
    }];
}

- (void)registerForAuthenticationNotification {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver: self
           selector:@selector(authenticationChanged)
               name:GKPlayerAuthenticationDidChangeNotificationName
             object:nil];
}

- (void)authenticationChanged {
    if ([GKLocalPlayer localPlayer].isAuthenticated) {
        // Insert code here to handle a successful authentication.
#ifdef GAMECENTER_DEBUG
        NSLog(@"player authenticated -- authenticationChanged");
#endif
        //[self loadAndReportGKScores];
    } else {
#ifdef GAMECENTER_DEBUG
        NSLog(@"authenticationChanged player not authenticated");
#endif
        // Insert code here to clean up any outstanding Game Center-related classes.
    }

}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can
     be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
