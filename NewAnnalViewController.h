//
//  NewAnnalViewController.h
//  百度旅游
//
//  Created by Lucky on 13-3-30.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewAnnalViewController : UIViewController<UITextFieldDelegate>
{
    UILabel * tailLable;
    int location;
}
@property (nonatomic,retain) UITextField * mTextField;
@property (nonatomic,assign) NSInteger  residualtextfieldLength;
@end
