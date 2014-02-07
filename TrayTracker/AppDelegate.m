//
//  AppDelegate.m
//  TrayTracker
//
//  Created by pramesh on 11/20/13.
//  Copyright (c) 2013 pramesh. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize splashView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Create your own color
//#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
    
    //[[UINavigationBar appearance] setTintColor:UIColorFromRGB(0x067AB5)];
    
    // Create custom color
    UIColor *color = [UIColor colorWithRed:0/255.0f green:150/255.0f blue:225/255.0f alpha:1.0f];
    [[UINavigationBar appearance] setBarTintColor:color];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // change default status bar color to whiteColor
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    //[[UITabBar appearance] setBarTintColor:color];
    [[UITabBar appearance] setTintColor:color];
    
    // Change navigation's bar background's color
    //[[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
  //  [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"bg_fade.png"] forBarMetrics:UIBarMetricsDefault];
    // Change the font of the Navigation Bar Title
    //NSShadow *shadow = [[NSShadow alloc]init];
    //shadow.shadowColor = [UIColor colorWithRed:5.0 green:0.0 blue:0.9 alpha:2.0];
    //shadow.shadowOffset = CGSizeMake(0, 1);
    //[[UINavigationBar appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName, shadow, NSShadowAttributeName,
        //[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:25.0],NSFontAttributeName, nil]];
    
    // Set background image for UIToolbar
    //[[UIToolbar appearance]setBackgroundImage:[UIImage imageNamed:@"bg_fade.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    //[[UIToolbar appearance]setBackgroundImage:[UIImage imageNamed:@"bg_fade.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsLandscapePhone];
    
    
     [self performSelector:@selector(splashFade) withObject:nil];    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) splashFade
{
    splashView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    splashView.image = [UIImage imageNamed:@"Default.png"];
    [_window addSubview:splashView];
    [_window bringSubviewToFront:splashView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationDelay:2.9];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:_window cache:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(startupAnimationDone:finished:context:)];
    splashView.alpha = 0.0;
    [UIView commitAnimations];
    
    // create and add the activity indicator to splashview
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.alpha = 1.0;
    activityIndicator.center = CGPointMake(160, 360);
    activityIndicator.hidesWhenStopped = NO;
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(140, 435, 160, 30)];
    text.backgroundColor = [UIColor clearColor];
    text.textColor = [UIColor redColor];
    text.font = [UIFont systemFontOfSize:14];
    text.text = @"loading....";
    [splashView addSubview:text];
    [splashView addSubview:activityIndicator];
    [activityIndicator startAnimating];
}

- (void) startupAnimationDone:(NSString*)animationID finished:(NSNumber*)finished context:(void *)context{
    [splashView removeFromSuperview];
}

@end
