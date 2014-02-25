//
//  AppDelegate.h
//  百度旅游
//
//  Created by Lucky on 13-3-23.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ShardApp ((AppDelegate *)[[UIApplication sharedApplication] delegate])
@class LeveyTabBarController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LeveyTabBarController * leveyTabBarController;


@end
