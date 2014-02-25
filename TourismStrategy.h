//
//  TourismStrategy.h
//  百度旅游
//
//  Created by Lucky on 13-3-23.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKSegmentedControl.h"
#import "MySearchBar.h"
#import "EGORefreshTableHeaderView.h"
#import "HttpDownload.h"
#import "CONST.h"
#import "Translucence.h"
@interface TourismStrategy : UIViewController<UISearchDisplayDelegate,UISearchBarDelegate,UIScrollViewDelegate,EGORefreshTableHeaderDelegate,HttpDownloadDelegate>
{

    NSMutableArray * locationArray;
    NSMutableArray * dataArray ;
    NSMutableArray* labelsArray;
    NSData * tempData;
    
    NSInteger curPage;
    NSInteger perPageCount;
    NSInteger totalPageCount;
    
    EGORefreshTableHeaderView * refreshView;
    BOOL isLoading;
    
    NSMutableDictionary *taskListDict;
    
    //下载
    HttpDownload * mhttpdownload;
    
    //布局scrollview
    UIImageView * imageViewA1;
    UIImageView * imageViewA2;
    UIImageView * imageViewA3;
    UIImageView * imageViewA4;
    UIImageView * imageViewA5;
    UIImageView * imageViewB1;
    UIImageView * imageViewB2;
    UIImageView * imageViewB3;
    UIImageView * imageViewB4;
    UIImageView * imageViewB5;
    UIImageView * imageViewC1;
    UIView * viewC2;
    UIView * viewC3;
    UIView * viewC4;
    UIView * viewC5;
    UILabel * labelA5;
    UILabel * labelB5;
    
    UILabel * tsA1;
    UILabel * tsA2;
    UILabel * tsA3;
    UILabel * tsA4;
    UILabel * tsB1;
    UILabel * tsB2;
    UILabel * tsB3;
    UILabel * tsB4;

    //手势
    UITapGestureRecognizer * tapOne;
    
}
@property (strong,nonatomic) UISegmentedControl * mSegment;
//数据源
@property (strong,nonatomic) NSMutableArray * arrayData;
@property (strong,nonatomic) UISearchBar * mSearchBar;
@property (strong,nonatomic) NSMutableArray * arrayResultData;
//搜索结果显示控件
@property (strong,nonatomic) UISearchDisplayController * mSearchDisplayCtrl;

@property (strong,nonatomic) UIButton * searchButton;

@property (strong,nonatomic) UIScrollView * mScrollView;




@end
