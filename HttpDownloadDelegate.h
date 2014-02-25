//
//  HttpDownloadDelegate.h
//  XmlDemo
//
//  Created by DuHaiFeng on 13-3-5.
//  Copyright (c) 2013年 dhf. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "HttpDownload.h"
@class HttpDownload;
@protocol HttpDownloadDelegate <NSObject>
//下载完成
-(void)downloadComplete:(HttpDownload *)hd;
//下载失败
-(void)downloadFaild:(HttpDownload*)hd;
@end







