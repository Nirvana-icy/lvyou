//
//  Translucence.m
//  百度旅游
//
//  Created by Lucky on 13-3-29.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "Translucence.h"

@implementation Translucence
//@synthesize cityLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.6;
//        UILabel * cityLabel = [[UILabel alloc] init];
//        cityLabel.textColor = [UIColor redColor];
//        cityLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//        cityLabel.text = @"aaa";
//        cityLabel.backgroundColor =[UIColor blackColor];
//        [self addSubview:cityLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
