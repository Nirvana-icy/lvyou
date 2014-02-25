//
//  TrafficLocalItem.m
//  百度旅游
//
//  Created by Lucky on 13-4-7.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "TrafficLocalItem.h"

@implementation TrafficLocalItem
@synthesize key,desc,pic_url;
- (void)dealloc
{
    key = nil;
    desc = nil;
    pic_url = nil;
    [super dealloc];
}
@end
