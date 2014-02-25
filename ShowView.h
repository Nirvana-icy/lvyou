//
//  ShowView.h
//  百度旅游
//
//  Created by Lucky on 13-4-4.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLCycleScrollView.h"
#import "HttpDownload.h"

@interface ShowView : UIViewController<XLCycleScrollViewDatasource,XLCycleScrollViewDelegate,UIScrollViewDelegate,HttpDownloadDelegate>
{
    UIScrollView * mScrollview;
    UIPageControl * mPagecontrol;
    NSString * titleName;
    NSString * sid;
    
    NSInteger curPage;
    NSInteger perPageCount;
    
    HttpDownload * mhttpdownload;
    NSMutableArray * dataArray;
    NSMutableArray * pageControllImageArray;
//    BOOL isLoading;
    
    XLCycleScrollView *csView;
    
    //从数据库里读出来的tag_list,拆分后的数组
    NSArray * btnArray;
    
    UIView * mOpaqueview;
    UIActivityIndicatorView * mActivityIndicator;
    
    //装载按钮图片的数组
    NSMutableArray * buttonImageArray;
    //装载按钮名称的数组
    NSMutableArray * buttonTitleArray;
    //装载八个按钮英文的数组
    NSMutableArray * buttonEnglish;
    
    NSString * titleString;
    NSString * sname;

    
}
//写文字的地方
@property (nonatomic,retain) UILabel * firstLabel ;
@property (nonatomic,retain) UILabel * secondLabel;

@property (nonatomic,retain) NSString * titleName;
@property (nonatomic,retain) NSString * sid;
@property (nonatomic,retain) NSString * titleString;
@property (nonatomic,retain) NSString * sname;
@end
