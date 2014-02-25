//
//  ChinaProvinceSecondView.h
//  百度旅游
//
//  Created by Lucky on 13-4-3.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChinaProvinceSecondView : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * mTableView;
    NSMutableArray * zongArray;
    NSDictionary * zongDict;
    NSString * sidStr;

}
@property (nonatomic,retain) NSString * sidStr;
@end
