//
//  ShoppingBusinessItem.m
//  百度旅游
//
//  Created by Lucky on 13-4-8.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "ShoppingBusinessItem.h"

@implementation ShoppingBusinessItem
@synthesize key,desc,pic_url;
- (void)dealloc
{
    key = nil;
    desc = nil;
    pic_url = nil;
    [super dealloc];
}
@end
