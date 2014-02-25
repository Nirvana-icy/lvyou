//
//  LineItem.m
//  百度旅游
//
//  Created by Lucky on 13-4-8.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "LineItem.h"

@implementation LineItem
@synthesize desc,accordination,dinning,keyword,key;
- (void)dealloc
{
    key=nil;
    keyword = nil;
    desc = nil;
    accordination = nil;
    dinning = nil;
    [super dealloc];
}
@end
