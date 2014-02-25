//
//  ReadJsonClass.m
//  百度旅游
//
//  Created by Lucky on 13-4-2.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "ReadJsonClass.h"

@implementation ReadJsonClass
+(NSArray *)readzhouArray
{
    NSString * jsonPath = [[NSBundle mainBundle] pathForResource:@"scene" ofType:@"json"];
    NSDictionary * zongdict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jsonPath] options:NSJSONReadingMutableContainers error:nil];
    //此数组包含洲sid sname;每一项是一个字典
    NSArray * zhouArray =  [zongdict objectForKey:@"continent_list"];
    return zhouArray;
}

+(NSArray *)readprovinceArray
{
    NSString * jsonPath = [[NSBundle mainBundle] pathForResource:@"scene" ofType:@"json"];
    NSDictionary * zongdict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jsonPath] options:NSJSONReadingMutableContainers error:nil];
    //此数组包含国内省份sid sname 每一项是一个字典
    NSArray * provinceArray = [zongdict objectForKey:@"province"];
    return provinceArray;
}
+(NSDictionary *)readBigDictionary
{
    NSString * jsonPath = [[NSBundle mainBundle] pathForResource:@"scene" ofType:@"json"];
    NSDictionary * zongdict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jsonPath] options:NSJSONReadingMutableContainers error:nil];
    //此字典是大字典，包含七大洲国家，国家城市，中国各省份景点
    NSDictionary * bigDict = [zongdict objectForKey:@"list"];
    return bigDict;
}

@end
