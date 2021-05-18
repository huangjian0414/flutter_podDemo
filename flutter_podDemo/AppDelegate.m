//
//  AppDelegate.m
//  flutter_podDemo
//
//  Created by Jayehuang on 2021/5/18.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    ViewController *con = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:con];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    
    [GeneratedPluginRegistrant registerWithRegistry:self];
    
    return YES;
}


@end
