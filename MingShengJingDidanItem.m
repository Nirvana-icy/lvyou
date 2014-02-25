//
//  MingShengJingDidanItem.m
//  百度旅游
//
//  Created by Lucky on 13-4-5.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "MingShengJingDidanItem.h"


@implementation MingShengJingDidanItem
@synthesize sid,sname,scene_layer,parent_sid,is_china,x,y,pic_url,level,is_newest,package_exist,package_url,package_size,aid,pics_count,tag_list;


- (void)dealloc
{
    sid = nil;
    sname = nil;
    scene_layer = nil;
    parent_sid = nil;
    is_china = nil;
    x = nil;
    y = nil;
    pic_url = nil;
    level = nil;
    is_newest = nil;
    package_exist = nil;
    package_url = nil;
    package_size = nil;
    aid = nil;
    pics_count = nil;
    tag_list = nil;
     
    [super dealloc];
}
@end
