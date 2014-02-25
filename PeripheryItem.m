//
//  PeripheryItem.m
//  百度旅游
//
//  Created by Lucky on 13-3-28.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "PeripheryItem.h"

@implementation PeripheryItem
@synthesize pinImageString,starImageString,titleString,priceString,critiqueString,distanceString;

-(void)dealloc
{
    self.pinImageString = nil;
    self.starImageString = nil;
    self.titleString = nil;
    self.priceString = nil;
    self.critiqueString = nil;
    self.distanceString = nil;
    [super dealloc];
}
@end
