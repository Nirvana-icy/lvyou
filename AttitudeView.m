//
//  AttitudeView.m
//  百度旅游
//
//  Created by Lucky on 13-3-31.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "AttitudeView.h"
#import "QuartzCore/QuartzCore.h"

@interface AttitudeView ()

@end

@implementation AttitudeView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [tv becomeFirstResponder];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    
    //button
    UIButton * rgtButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rgtButton.frame = CGRectMake(10, 7, 51, 30);
    [rgtButton setBackgroundImage:[UIImage imageNamed:@"image_title_button"] forState:UIControlStateNormal];
    [rgtButton setBackgroundImage:[UIImage imageNamed:@"image_title_button_down"] forState:UIControlStateHighlighted];
    [rgtButton setTitle:@"提交" forState:UIControlStateNormal];
    rgtButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rgtButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rgtButton addTarget:self action:@selector(pressRightButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rghButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rgtButton];
    self.navigationItem.rightBarButtonItem = rghButtonItem;
    
    
    
    UIButton * lftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    lftButton.frame = CGRectMake(10, 7, 51, 30);
    [lftButton setBackgroundImage:[UIImage imageNamed:@"image_titlebar_back_button"] forState:UIControlStateNormal];
    [lftButton setBackgroundImage:[UIImage imageNamed:@"image_titlebar_back_button_pressed"] forState:UIControlStateSelected];
    [lftButton setTitle:@"取消" forState:UIControlStateNormal];
    lftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [lftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lftButton addTarget:self action:@selector(pressLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;

    //头视图
    UIImageView * headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 310, 70)];
    [headImageView setImage:[UIImage imageNamed:@"image_suggestionbg"]];
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 310, 70)];
    titleLabel.text = @"欢迎您提出宝贵的意见和建议，您留下的每一个字都将帮助改善我们的产品:)";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.numberOfLines = 0 ;
    titleLabel.textColor = [UIColor blueColor];
    [headImageView addSubview:titleLabel];
    [self.view addSubview:headImageView];
    
    //textView
    tv = [[UITextView alloc] initWithFrame:CGRectMake(5, 83, 310, 80)];
    tv.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:240.0/255.0 blue:243.0/255.0 alpha:1.0];
    tv.keyboardType = UIKeyboardTypeDefault;
    tv.layer.borderWidth = 1;
    //设置uiview边框颜色
    tv.layer.borderColor = [UIColor redColor].CGColor  ;
 
    [self.view addSubview:tv];
    
    
}
-(void)pressRightButton:(UIButton *) btn
{
    
    
    
}
-(void)pressLeftButton:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
