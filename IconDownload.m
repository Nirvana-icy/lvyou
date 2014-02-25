//
//  IconDownload.m
//  AutoLayoutDemo
//
//  Created by DuHaiFeng on 13-3-8.
//  Copyright (c) 2013年 dhf. All rights reserved.
//

#import "IconDownload.h"
#import "Helper.h"
@implementation IconDownload
@synthesize indexPath=_indexPath,index=_index,url=_url;

@synthesize delegate,selector;
-(void)downloadImage
{
    if (!mData) {
        mData=[[NSMutableData alloc] initWithCapacity:0];
    }
    //启动异步下载
    mConnection=[[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]] delegate:self];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"下载失败");
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse*)response;
    if ([httpResponse statusCode]>=200&& [httpResponse statusCode]<300) {
        [mData setLength:0];
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *fullPath=[Helper md5ByUrl:self.url];
    
    NSFileManager *fm=[NSFileManager defaultManager];
    //如果文件不存在
    if ([fm fileExistsAtPath:fullPath]==NO) {
        //将下载的数据保存到指定目录下
        [mData writeToFile:fullPath atomically:YES];
    }
    [mData setLength:0];//清空缓冲区
    
    //对象delegate是否实现了方法selector
    if ([delegate respondsToSelector:selector]) {
        //调用对象delegate的方法selector,参数为self
        [delegate performSelector:selector withObject:self];
    }
}
@end






