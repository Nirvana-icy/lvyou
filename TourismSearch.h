//
//  TourismSearch.h
//  百度旅游
//
//  Created by Lucky on 13-3-25.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MySearchBar.h"
#import "iFlyMSC/IFlyRecognizeControl.h"
@interface TourismSearch : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,IFlyRecognizeControlDelegate>
{
    UIButton * btn;

    MySearchBar * mSearchBar;

    UIButton * speakButton;
    
    UITableView * mTableView;
    //存储查询数据的数组
    NSMutableArray * searchArray;
    
    IFlyRecognizeControl * _iFlyRecognizeControl;
}
@end
