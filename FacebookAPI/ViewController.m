//
//  ViewController.m
//  FacebookAPI
//
//  Created by Rizza on 6/9/15.
//  Copyright (c) 2015 Rizza Corella Punsalan. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+AFNetworking.h"

@interface ViewController ()

- (void)toggleHiddenState:(BOOL)shouldHide;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    // Do any additional setup after loading the view, typically from a nib.
    /*FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = CGPointMake(self.view.center.x + 25.0, self.view.center.y + 40.0);
    [self.view addSubview:loginButton];*/
    
    [self toggleHiddenState:YES];
    self.lblLoginStatus.text = @"";
    
    self.loginButton.readPermissions = @[@"public_profile", @"email"];
    [self.loginButton setDelegate:self];
    [self accessUserInfoIfCurrentToken];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toggleHiddenState:(BOOL)shouldHide {
    self.lblUsername.hidden = shouldHide;
    self.lblEmail.hidden = shouldHide;
    self.profilePicture.hidden = shouldHide;
    self.lblGender.hidden = shouldHide;
}

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    NSLog(@"Someone is logged in (Delegate Method).\n");
    NSLog(@"Result: %@\n", result);
    NSLog(@"Error/s: %@\n", [error localizedDescription]);
    [self accessUserInfoIfCurrentToken];
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    NSLog(@"Logged out.");
    self.lblLoginStatus.text = @"You are not logged in.";
    [self toggleHiddenState:YES];
}

- (void) accessUserInfoIfCurrentToken {
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
                 [self toggleHiddenState:NO];
                 self.lblLoginStatus.text = @"You are now logged in.";
                 self.lblEmail.text = [result objectForKey:@"email"];
                 self.lblUsername.text = [result objectForKey:@"name"];
                 self.lblGender.text = [result objectForKey:@"gender"];
                 //self.profilePicture.profileID = [result objectForKey:@"id"];
                 
                 /*NSString *ImageURL = [NSString stringWithFormat:@"", [result objectForKey:@"id"]];
                 NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
                 self.profilePicture.image = [UIImage imageWithData:imageData];*/
                 
                 [self.profilePicture setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",[result objectForKey:@"id"]]]
                           placeholderImage:[UIImage imageNamed:@"unknownUser.png"]];

             }
         }];
    }
}

@end
