//
//  HiddenTabBar.m
//  百度旅游
//
//  Created by Lucky on 13-4-2.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "HiddenTabBar.h"

@implementation HiddenTabBar

+(void)hidden:(UITabBarController *)tabbarcontroller isHidden:(BOOL)hidden
{
    CGRect frame=[UIScreen mainScreen].bounds;
    
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, frame.size.height, view.frame.size.width, view.frame.size.height)];
            }
            else{
                [view setFrame:CGRectMake(view.frame.origin.x, frame.size.height-49, view.frame.size.width, view.frame.size.height)];
            }
            
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, frame.size.height)];
        }
        
    }
    
}

+(void)hiddenTabBar:(UITabBarController *)tabbarcontroller animated:(BOOL)animated isHidden:(BOOL)isHidden
{
    if (animated) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        
        [self hidden:tabbarcontroller isHidden:isHidden];
        
        [UIView commitAnimations];
    }
    else{
        [self hidden:tabbarcontroller isHidden:isHidden];
    }
}
@end
