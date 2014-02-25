//
//  SceneItem.m
//  百度旅游
//
//  Created by Lucky on 13-4-7.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "SceneItem.h"

@implementation SceneItem
@synthesize sid,scene_layer,sname,parent_sid,going_count,gone_count,pic_url,distance,map_x,map_y,abstract,desc;

- (void)dealloc
{
    sid = nil;
    scene_layer = nil;
    sname = nil;
    parent_sid = nil;
    going_count = nil;
    gone_count = nil;
    pic_url = nil;
    distance = nil;
    map_x = nil;
    map_y = nil;
    abstract = nil;
    desc = nil;
    [super dealloc];
}
@end
