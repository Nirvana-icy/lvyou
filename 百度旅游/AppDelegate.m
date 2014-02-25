//
//  AppDelegate.m
//  百度旅游
//
//  Created by Lucky on 13-3-23.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "AppDelegate.h"
#import "TourismStrategy.h"
#import "PlaceRecommend.h"
#import "Periphery.h"
#import "Annal.h"
#import "Individual.h"

#import "LeveyTabBarController.h"
#import "LeveyTabBar.h"

@implementation AppDelegate
@synthesize leveyTabBarController;

- (void)dealloc
{
    [leveyTabBarController release];
    leveyTabBarController = nil;
    [_window release];
    [super dealloc];
}

-(void)creatTabbar
{
    //完全自定义tabBar
    PlaceRecommend * pr = [[PlaceRecommend alloc] init];
    UINavigationController * prNav = [[UINavigationController alloc]initWithRootViewController:pr];
    [pr release];
   // [prNav.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"file_tital_bj"] forBarMetrics:UIBarMetricsDefault];
     
    Periphery * ph = [[Periphery alloc] init];
    UINavigationController * phNav = [[UINavigationController alloc]initWithRootViewController:ph];
    [ph release];
    
    TourismStrategy * ts = [[TourismStrategy alloc] init];
    UINavigationController * tsNav = [[UINavigationController alloc]initWithRootViewController:ts];
    [ts release];
    
    Annal * al = [[Annal alloc] init];
    UINavigationController * alNav = [[UINavigationController alloc] initWithRootViewController:al];
    [al release];
    
    Individual * idl = [[Individual alloc] init];
    UINavigationController * idlNav = [[UINavigationController alloc] initWithRootViewController:idl];
    [idl release];
    
    NSArray * arr = [NSArray arrayWithObjects:prNav,phNav,tsNav,alNav, idlNav,nil];
    [prNav release];
    [phNav release];
    [idlNav release];
    [alNav release];
    [tsNav release];
    
    //统一效果
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"file_tital_bj"] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic setObject:[UIImage imageNamed:@"image_tab_recommend"] forKey:@"Default"];
	[imgDic setObject:[UIImage imageNamed:@"image_tab_recommend_selected"] forKey:@"Highlighted"];
	[imgDic setObject:[UIImage imageNamed:@"image_tab_recommend_selected"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic2 setObject:[UIImage imageNamed:@"image_tab_surrounding"] forKey:@"Default"];
	[imgDic2 setObject:[UIImage imageNamed:@"image_tab_surrounding_selected"] forKey:@"Highlighted"];
	[imgDic2 setObject:[UIImage imageNamed:@"image_tab_surrounding_selected"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic3 setObject:[UIImage imageNamed:@"image_tab_travelnotes"] forKey:@"Default"];
	[imgDic3 setObject:[UIImage imageNamed:@"image_tab_travelnotes_selected"] forKey:@"Highlighted"];
	[imgDic3 setObject:[UIImage imageNamed:@"image_tab_travelnotes_selected"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic4 setObject:[UIImage imageNamed:@"image_tab_write"] forKey:@"Default"];
	[imgDic4 setObject:[UIImage imageNamed:@"image_tab_write_selected"] forKey:@"Highlighted"];
	[imgDic4 setObject:[UIImage imageNamed:@"image_tab_write_selected"] forKey:@"Seleted"];
    
    NSMutableDictionary *imgDic5 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic5 setObject:[UIImage imageNamed:@"image_tab_me"] forKey:@"Default"];
	[imgDic5 setObject:[UIImage imageNamed:@"image_tab_me_selected"] forKey:@"Highlighted"];
	[imgDic5 setObject:[UIImage imageNamed:@"image_tab_me_selected"] forKey:@"Seleted"];

    NSArray * array2 = [NSArray arrayWithObjects:imgDic,imgDic2,imgDic3,imgDic4,imgDic5, nil];
    leveyTabBarController = [[LeveyTabBarController alloc] initWithViewControllers:arr imageArray:array2];
    [leveyTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"image_tab_bg"]];
    
    //防止tabBar突起两边露白——————————————————————————————————————————————
	[leveyTabBarController setTabBarTransparent:YES];
	[self.window addSubview:leveyTabBarController.view];
    
    [leveyTabBarController.tabBar selectTabAtIndex:2];
    [self.window setRootViewController:leveyTabBarController];


    
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //	if ([viewController isKindOfClass:[SecondViewController class]])
    //	{
    //        [leveyTabBarController hidesTabBar:NO animated:YES];
    //	}
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    [self creatTabbar];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController.hidesBottomBarWhenPushed)
    {
        [leveyTabBarController hidesTabBar:YES animated:YES];
    }
    else
    {
        [leveyTabBarController hidesTabBar:NO animated:YES];
    }

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

@end
