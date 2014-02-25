//
//  TourismItem.m
//  百度旅游
//
//  Created by Lucky on 13-3-28.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "TourismItem.h"

@implementation TourismItem
@synthesize sid,sname,pic_url,scene_layer,parent_sid;
-(void)dealloc
{
    sid = nil;
    sname = nil;
    pic_url =nil;
    scene_layer = nil;
    parent_sid = nil;
    [super dealloc];

}
@end
