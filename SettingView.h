//
//  SettingView.h
//  百度旅游
//
//  Created by Lucky on 13-3-30.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingView : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * mTableView;
    UISwitch * rightButton;
    NSArray * firstArray;
    NSArray * secondArray;
    NSArray * thirdArray;
    NSMutableArray * dataArray;
    BOOL isopen;
}

@end
