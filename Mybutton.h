//
//  Mybutton.h
//  百度旅游
//
//  Created by Lucky on 13-4-5.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mybutton : UIButton
@property (nonatomic,retain) NSString * type;
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;
@end
