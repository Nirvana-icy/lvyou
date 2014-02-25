//
//  MySearchBar.m
//  百度旅游
//
//  Created by Lucky on 13-3-25.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "MySearchBar.h"

@implementation MySearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews {
    UITextField *searchField;
    NSUInteger numViews = [self.subviews count];
    for(int i = 0; i < numViews; i++) {
        if([[self.subviews objectAtIndex:i] isKindOfClass:[UITextField class]]) {
            
            searchField = [self.subviews objectAtIndex:i];
        }
    }
    
    if(!(searchField == nil)) {
        searchField.textColor = [UIColor blueColor];
        [searchField setBorderStyle:UITextBorderStyleNone];
        UIImage *image = [UIImage imageNamed: @"image_search_button"];
        UIImageView *iView = [[UIImageView alloc] initWithImage:image];
        searchField.leftView = iView;
        [searchField setBackground: [UIImage imageNamed:@"image_searchbar"] ];
    }
    [super layoutSubviews];
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
