//
//  AppDelegate.m
//  List
//
//  Created by lemon on 15/11/30.
//  Copyright © 2015年 lemon. All rights reserved.
//

#import "AppDelegate.h"
#import "HYLeftMenuViewController.h"
#import "HYRightMenuViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init] ];
    HYLeftMenuViewController *leftc = [[HYLeftMenuViewController alloc] init];
    HYRightMenuViewController *rightc = [[HYRightMenuViewController alloc] init];
    
    RESideMenu *sidec = [[RESideMenu alloc] initWithContentViewController:navc
                                                   leftMenuViewController:leftc
                                                  rightMenuViewController:rightc];
    sidec.menuPreferredStatusBarStyle = 1;
    sidec.delegate = self;
    sidec.backgroundImage = [UIImage imageNamed:@"sidebg"];
    sidec.contentViewShadowColor = [UIColor blackColor];
    sidec.contentViewShadowOffset = CGSizeMake(0, 0);
    sidec.contentViewShadowOpacity = 0.6;
    sidec.contentViewShadowRadius = 12;
    sidec.contentViewShadowEnabled = YES;
    
    self.window.rootViewController = sidec;
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController{
    //NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController{
    //NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController{
    //NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController{
    //NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
