//
//  HttpDownload.h
//  XmlDemo
//
//  Created by DuHaiFeng on 13-3-5.
//  Copyright (c) 2013年 dhf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpDownloadDelegate.h"
#import "ASIHTTPRequest.h"
@interface HttpDownload : NSObject<NSURLConnectionDataDelegate,ASIHTTPRequestDelegate>
{
    //http连接类
    NSURLConnection *mConnection;
    //保存数据的缓冲区
    NSMutableData *mData;
    
    id<HttpDownloadDelegate> delegate;
    
    SEL method;
    
}
@property (nonatomic,assign) NSInteger downloadType;//接口类型(登录或注册等)
@property (nonatomic,readonly) NSMutableData *mData;
@property (nonatomic,assign) SEL method;
@property (nonatomic,assign) id<HttpDownloadDelegate> delegate;
//从指定的网址下载数据(系统方式)
-(void)downloadFromUrl:(NSString *)urlstr;
//post请求,dict为请求的参数
-(void)downloadPostUrl:(NSString *)urlstr dict:(NSDictionary *)dict method:(NSString*)methodstr;

//从指定的网址下载数据(第三方方式)
-(void)downloadFromUrlWithAsi:(NSString*)url;
//从指定的网址下载数据 post方式(第三方方式)
-(void)downloadWithAsi:(NSString *)url dict:(NSDictionary *)dict;
@end







