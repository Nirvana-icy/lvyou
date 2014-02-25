//
//  Periphery.h
//  百度旅游
//
//  Created by Lucky on 13-3-23.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKSegmentedControl.h"
#import "HttpDownload.h"
@interface Periphery : UIViewController <AKSegmentedControlDelegate,UITableViewDataSource,UITableViewDelegate,HttpDownloadDelegate>
{

    UIButton * btn;
    UIViewController *viewController;
    AKSegmentedControl *segmentedControl3;
    
    UITableView * mTableView;
    NSMutableArray * cateArray;

    UIView * footTableView;
    UILabel * first;
    UILabel * second;
    UITableView * mTableview ;
    NSMutableArray * dataArray;
    NSMutableArray * dataArray2;
    NSMutableArray * dataArray3;
    NSMutableArray * dataArray4;
    HttpDownload * mhttpdownload;
    //接收传过来的sid
    NSString * sidStr;
    //接收传过来的button类型
    NSString * buttonType;
    NSString * tableName;
    NSMutableArray * zimuArray;
    
    UIView * mOpaqueview;
    UIActivityIndicatorView * mActivityIndicator;
    
}
@property (nonatomic,retain) NSString * sidStr;
@property (nonatomic,retain)  NSString * buttonType;

@property (retain, nonatomic) AKSegmentedControl *segmentedControl1;
@end
