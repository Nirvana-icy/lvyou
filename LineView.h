//
//  LineView.h
//  百度旅游
//
//  Created by Lucky on 13-4-8.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpDownload.h"
@interface LineView : UIViewController<HttpDownloadDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView * mTableview ;
    NSMutableArray * dataArray;
    HttpDownload * mhttpdownload;
    //接收传过来的sid
    NSString * sidStr;
    //接收传过来的button类型
    NSString * buttonType;
    NSString * tableName;
    
    UIView * mOpaqueview;
    UIActivityIndicatorView * mActivityIndicator;
    //图片数组
    NSMutableArray * imageArray;
    NSString * imageTablename;
}
@property (nonatomic,retain) NSString * sidStr;
@property (nonatomic,retain)  NSString * buttonType;
@end
