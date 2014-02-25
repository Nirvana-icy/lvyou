//
//  HiddenTabBar.h
//  百度旅游
//
//  Created by Lucky on 13-4-2.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HiddenTabBar : NSObject
+(void)hidden:(UITabBarController *)tabbarcontroller isHidden:(BOOL)hidden;
+(void)hiddenTabBar:(UITabBarController *)tabbarcontroller animated:(BOOL)animated isHidden:(BOOL)isHidden;
@end
