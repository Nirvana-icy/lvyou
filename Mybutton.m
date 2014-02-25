//
//  Mybutton.m
//  百度旅游
//
//  Created by Lucky on 13-4-5.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "Mybutton.h"
#import "QuartzCore/QuartzCore.h"


@implementation Mybutton
@synthesize type;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    
//    CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:12]];

    [self.imageView setContentMode:UIViewContentModeCenter];
//    [self setImageEdgeInsets:UIEdgeInsetsMake(-25.0, 0.0,0.0,-titleSize.width)];
     [self setImageEdgeInsets:UIEdgeInsetsMake(-25.0, 0.0,0.0,-32)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
    //[self.titleLabel setFont:(12.0f)];
  //  [self.titleLabel setTextColor:COLOR_ffffff];
//    [self setTitleEdgeInsets:UIEdgeInsetsMake(50.0,-image.size.width, 0.0, 0.0)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(50.0,-34, 0.0, 0.0)];
    [self setTitle:title forState:stateType]; 
    [self setTitleColor:[UIColor blackColor] forState:stateType];
 
    //设置边框
    self.layer.borderColor = [[UIColor grayColor] CGColor];
    [self.layer setMasksToBounds:YES];
    [self.layer setBorderWidth:1.0f];
    self.layer.backgroundColor = [[UIColor colorWithRed:235.0/255.0 green:240.0/255.0 blue:243.0/255.0 alpha:1.0]CGColor];
    
    
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
