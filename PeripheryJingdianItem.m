//
//  PeripheryJingdianItem.m
//  百度旅游
//
//  Created by Lucky on 13-4-8.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "PeripheryJingdianItem.h"

@implementation PeripheryJingdianItem
@synthesize sid,sname,pic_url,distance,map_x,map_y,star,going_count;
- (void)dealloc
{
    sid = nil;
    sname = nil;
    pic_url = nil;
    distance = nil;
    map_x = nil;
    map_y = nil;
    star = nil;
    going_count = nil;
    [super dealloc];
}
@end
 