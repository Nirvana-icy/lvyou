//
//  Helper.m
//  AutoLayoutDemo
//
//  Created by DuHaiFeng on 13-3-8.
//  Copyright (c) 2013年 dhf. All rights reserved.
//

#import "Helper.h"
#import "NSString+Hashing.h"
@implementation Helper

//获得指定的某个远程图片在本地保存的全路径
//这里保存在当前目录下的tmp目录下
+(NSString*)md5ByUrl:(NSString *)url
{
    NSString *path=NSHomeDirectory();
    
    path=[path stringByAppendingPathComponent:@"tmp"];
    //检查path是否存在
    //code.....
    path=[path stringByAppendingPathComponent:[url MD5Hash]];
    
    return path;
}
@end








