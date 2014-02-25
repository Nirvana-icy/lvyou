//
//  ChinaProvinceView.h
//  百度旅游
//
//  Created by Lucky on 13-4-2.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChinaProvinceView : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * mTableView;
    NSMutableArray * mProvinceArray;
    NSMutableArray * zongArray;
}

@end
