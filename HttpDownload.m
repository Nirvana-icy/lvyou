//
//  HttpDownload.m
//  XmlDemo
//
//  Created by DuHaiFeng on 13-3-5.
//  Copyright (c) 2013年 dhf. All rights reserved.
//

#import "HttpDownload.h"
#import "ASIFormDataRequest.h"
@implementation HttpDownload
@synthesize mData,delegate,method;
@synthesize downloadType;

//get或post是指http协议规定的请求方法
-(void)downloadPostUrl:(NSString *)urlstr dict:(NSDictionary *)dict method:(NSString*)methodstr
{
    //对中文及非法字符编码
    NSString *newstr=[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:newstr];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] init];
    [request setURL:url];
    
    
    
    if ([methodstr isEqualToString:@"POST"]) {
        [request setHTTPMethod:@"POST"];
        
        NSMutableString *body=[[NSMutableString alloc] init];
        for (NSString *key in dict) {
            if ([body length]==0) {
                [body appendFormat:@"%@=%@",key,[dict objectForKey:key]];
            }
            else{
                [body appendFormat:@"&%@=%@",key,[dict objectForKey:key]];
            }
        }
        NSLog(@"body:%@",body);
        
        
        NSString *bodydata=[body stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSData *postData = [bodydata dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:postData];
    }
    
    
    
    
    mConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}
-(void)downloadFromUrl:(NSString *)urlstr
{
    //对中文及非法字符编码
    NSString *newstr=[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:newstr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
        
    mConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}
-(void)downloadWithAsi:(NSString *)url dict:(NSDictionary *)dict
{
    if (!mData) {
        mData=[[NSMutableData alloc] initWithCapacity:0];
    }
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate=self;
    for (NSString *key in [dict allKeys]) {
        id object=[dict objectForKey:key];
        //二进制数据,上传文件
        if ([object isKindOfClass:[NSData class]]) {
            [request setData:object withFileName:@"temp.png" andContentType:nil forKey:key];
        }
        //其它数据
        else{
            [request setPostValue:object forKey:key];
        }
    }
    //启动异步下载
    [request startAsynchronous];
    
}
-(void)downloadFromUrlWithAsi:(NSString *)url
{
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate=self;
    //启动异步下载
    [request startAsynchronous];
    if (!mData) {
        mData=[[NSMutableData alloc] initWithCapacity:0];
    }
    //启动同步下载
    //[request startSynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    //清空旧数据
    [mData setLength:0];
    //保存新数据
    [mData appendData:[request responseData]];
    if ([delegate respondsToSelector:@selector(downloadComplete:)]) {
        //调用对象delegate的方法downloadComplete:
        [delegate downloadComplete:self];
    }
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"第三方下载失败");
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"下载失败");
    //************通知下载失败，调用其后应该时候的函数
    if ([delegate respondsToSelector:@selector(downloadFaild:)]) {
        [delegate downloadFaild: self];
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (!mData) {
        mData=[[NSMutableData alloc] init];
    }
    else{
        [mData setLength:0];
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //对象delegate是否实现了方法downloadComplete:
    if ([delegate respondsToSelector:@selector(downloadComplete:)]) {
        //调用对象delegate的方法downloadComplete:
        [delegate downloadComplete:self];
    }
    
//    if ([delegate respondsToSelector:method]) {
//        [delegate performSelector:method withObject:self];
//    }
}
@end
