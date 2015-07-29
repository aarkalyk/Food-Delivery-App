//
//  AppDelegate.m
//  FoodDeliveryApp
//
//  Created by Student on 7/20/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Parse enableLocalDatastore];
    [Parse setApplicationId:@"syuPiyGO5M16zWUATMTLjmjJzkD260yjyBRIkq3s" clientKey:@"yYk8f39luELKmfMDT7NmW6qPhclt8PY2HNPGYVUq"];
    
    ViewController* mainController = (ViewController*)  self.window.rootViewController;
    
    float width = CGRectGetWidth(mainController.view.frame);
    
    // set the selected icon color
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
    // remove the shadow
    [[UITabBar appearance] setShadowImage:nil];
    
    // Set the dark color to selected tab (the dimmed background)
    [[UITabBar appearance] setSelectionIndicatorImage:[AppDelegate imageFromColor:[UIColor colorWithRed:89/255.0 green:218/255.0 blue:145/255.0 alpha:1] forSize:CGSizeMake(width/4.0f, 49) withCornerRadius:0]];
    
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

+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}

@end
