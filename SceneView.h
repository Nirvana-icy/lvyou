//
//  SceneView.h
//  百度旅游
//
//  Created by Lucky on 13-4-7.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpDownload.h"
@interface SceneView : UIViewController<UITableViewDataSource,UITableViewDelegate,HttpDownloadDelegate>
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
}
@property (nonatomic,retain) NSString * sidStr;
@property (nonatomic,retain)  NSString * buttonType;
@end
