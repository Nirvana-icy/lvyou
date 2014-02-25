//
//  TourismLocationItem.m
//  百度旅游
//
//  Created by Lucky on 13-3-29.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "TourismLocationItem.h"

@implementation TourismLocationItem
@synthesize sid,sname,pic_url,top_count,city,district,province,street,street_number;
- (void)dealloc
{
    sid = nil;
    sname = nil;
    pic_url = nil;
    top_count = nil;
    city = nil;
    district = nil;
    province = nil;
    street = nil;
    street_number = nil;
    [super dealloc];
}

@end
