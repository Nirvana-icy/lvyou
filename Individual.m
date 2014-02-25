//
//  Individual.m
//  百度旅游
//
//  Created by Lucky on 13-3-23.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "Individual.h"
#import "SettingView.h"
@interface Individual ()

@end

@implementation Individual

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    //右侧按钮
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(200, 0, 40, 40);
    [rightBtn setImage:[UIImage imageNamed:@"image_setting_button"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"image_setting_button_down"] forState:UIControlStateSelected];
    [rightBtn addTarget:self action:@selector(pressRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItemBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItemBtn;
    
    
}
-(void)pressRightBtn:(UIButton *)btn
{
    SettingView * sv = [[SettingView alloc] init];
    [self.navigationController pushViewController:sv animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
