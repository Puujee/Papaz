//
//  AppDelegate.h
//  Papaz
//
//  Created by L on 7/24/13.
//  Copyright (c) 2013 Sorako. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PapazViewController.h"
#import "SettingsViewController.h"
#import "MyPapazViewController.h"
#import "CameraViewController.h"
#import "PapazersViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) PapazViewController *papazViewController;
@property (strong, nonatomic) MyPapazViewController *myPapazViewController;
@property (strong, nonatomic) CameraViewController *cameraViewController;
@property (strong, nonatomic) PapazersViewController *papazersViewController;
@property (strong, nonatomic) SettingsViewController *settingsViewController;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;

@end
