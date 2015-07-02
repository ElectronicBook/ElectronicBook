//
//  AppDelegate.m
//  ElectronicBook
//
//  Created by 你 on 15-6-30.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //初始化第一个界面
    FirstViewController *first = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    [first.tabBarItem setImage:[[UIImage imageNamed:@"tabBar1Normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [first.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabBar1Highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //初始化第二个界面
    SecondViewController *second = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    [second.tabBarItem setImage:[[UIImage imageNamed:@"tabBar2Normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [second.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabBar2Highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //初始化第三个界面
    ThirdViewController *third = [[ThirdViewController alloc] initWithNibName:@"ThirdViewController" bundle:nil];
    [third.tabBarItem setImage:[[UIImage imageNamed:@"tabBar3Normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [third.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabBar3Highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //初始化第四个界面
    FourthViewController *fourth = [[FourthViewController alloc] initWithNibName:@"FourthViewController" bundle:nil];
    [fourth.tabBarItem setImage:[[UIImage imageNamed:@"tabBar4Normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [fourth.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabBar4Highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //初始化tabBar控制器
    UITabBarController *barController = [[UITabBarController alloc] init];
    barController.viewControllers = @[first,second,third,fourth];
    [barController.tabBar setBackgroundImage:[UIImage imageNamed:@"barBackground"]];
    barController.tabBar.shadowImage = [[UIImage alloc]init];
    [barController prefersStatusBarHidden];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = barController;
    [self.window makeKeyAndVisible];
    
    return YES;
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
