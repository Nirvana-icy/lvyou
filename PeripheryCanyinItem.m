//
//  PeripheryCanyinItem.m
//  百度旅游
//
//  Created by Lucky on 13-4-8.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "PeripheryCanyinItem.h"

@implementation PeripheryCanyinItem
@synthesize name,address,distance,uid,map_x,map_y,comm_num,price,star,type;
- (void)dealloc
{
    name = nil;
    address = nil;
    distance = nil;
    uid = nil;
    map_x = nil;
    map_y = nil;
    comm_num = nil;
    price = nil;
    star = nil;
    type = nil;
    [super dealloc];
}
@end
