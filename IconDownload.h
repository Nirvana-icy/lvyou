//
//  IconDownload.h
//  AutoLayoutDemo
//
//  Created by DuHaiFeng on 13-3-8.
//  Copyright (c) 2013年 dhf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IconDownload : NSObject<NSURLConnectionDataDelegate>
{
    NSURLConnection *mConnection;
    NSMutableData *mData;
    
    id delegate;
    SEL selector;
}
@property (nonatomic,assign) id delegate;
@property (nonatomic,assign) SEL selector;

@property (nonatomic,retain) NSString *url;//图片地址
@property (nonatomic,retain) NSIndexPath *indexPath;//行号
@property (nonatomic,assign) NSInteger index;//在这一行的位置

-(void)downloadImage;//下载图片
@end







