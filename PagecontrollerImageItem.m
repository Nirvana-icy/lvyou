//
//  PagecontrollerImageItem.m
//  百度旅游
//
//  Created by Lucky on 13-4-5.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "PagecontrollerImageItem.h"

@implementation PagecontrollerImageItem
@synthesize pic_url,is_cover,title,desc;
- (void)dealloc
{
    pic_url = nil;
    is_cover = nil;
    title = nil;
    desc = nil;
    [super dealloc];
}
@end
