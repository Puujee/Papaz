//
//  AppDelegate.m
//  Papaz
//
//  Created by L on 7/24/13.
//  Copyright (c) 2013 Sorako. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize papazViewController;
@synthesize myPapazViewController;
@synthesize cameraViewController;
@synthesize papazersViewController;
@synthesize settingsViewController;
@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [self configureTabBar];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)configureTabBar{
    self.tabBarController = [[UITabBarController alloc]init];
            
    NSMutableArray *tabArray = [NSMutableArray array];
    
    // Social tabbar
    {
        self.papazViewController = [[PapazViewController alloc] initWithStyle:UITableViewStylePlain];
        [papazViewController setTitle:@"Papaz"];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:papazViewController];
        [tabArray addObject:navController];
        papazViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 0, -3, 0);
        papazViewController.tabBarItem.image = [UIImage imageNamed:@"icon_home.png"];
    }
    
    // MyPapaz tabbar
    {
        self.myPapazViewController = [[MyPapazViewController alloc] initWithNibName:nil bundle:nil];
        [myPapazViewController setTitle:@"MyPapaz"];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:myPapazViewController];
        [tabArray addObject:navController];
        myPapazViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 0, -3, 0);
        myPapazViewController.tabBarItem.image = [UIImage imageNamed:@"icon_user.png"];
    }
    
    // Camera tabbar
    {
        self.cameraViewController = [[CameraViewController alloc] initWithNibName:nil bundle:nil];
        [cameraViewController setTitle:@"Camera"];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:cameraViewController];
        [tabArray addObject:navController];
        cameraViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 0, -3, 0);
        cameraViewController.tabBarItem.image = [UIImage imageNamed:@"icon_camera.png"];
    }
    
    // Papazers tabbar
    {
         papazersViewController = [[PapazersViewController alloc] initWithNibName:nil bundle:nil];
        [papazersViewController setTitle:@"Papazers"];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:papazersViewController];
        [tabArray addObject:navController];
        papazersViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 0, -3, 0);
        papazersViewController.tabBarItem.image = [UIImage imageNamed:@"icon_group.png"];
    }
    
    // Settings tabbar
    {
        self.settingsViewController = [[SettingsViewController alloc] initWithNibName:nil bundle:nil];
        [settingsViewController setTitle:@"Settings"];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
        [tabArray addObject:navController];
        settingsViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 0, -3, 0);
        settingsViewController.tabBarItem.image = [UIImage imageNamed:@"icon_group.png"];
    }
    self.tabBarController.viewControllers = tabArray;
    self.window.rootViewController = tabBarController;
//    self.navigationController.delegate = self;

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

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    NSLog(@"openurl");
    // Facebook SDK * login flow *
    // Attempt to handle URLs to complete any auth (e.g., SSO) flow.
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication fallbackHandler:^(FBAppCall *call) {
        // Facebook SDK * App Linking *
        // For simplicity, this sample will ignore the link if the session is already
        // open but a more advanced app could support features like user switching.
        if (call.accessTokenData) {
            if ([FBSession activeSession].isOpen) {
                NSLog(@"INFO: Ignoring app link because current session is open.");
            }
            else {
                NSLog(@"calling handleapplink");
              //  [self handleAppLink:call.accessTokenData];
            }
        }
    }];
}

@end
