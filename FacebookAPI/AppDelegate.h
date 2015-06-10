//
//  AppDelegate.h
//  FacebookAPI
//
//  Created by Rizza on 6/9/15.
//  Copyright (c) 2015 Rizza Corella Punsalan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    ViewController *viewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

@end

