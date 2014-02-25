//
//  Annal.m
//  百度旅游
//
//  Created by Lucky on 13-3-23.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "Annal.h"
#import "NewAnnalViewController.h"

@interface Annal ()

@end

@implementation Annal

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
    self.view.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:240.0/255.0 blue:243.0/255.0 alpha:1.0];
    self.navigationItem.title = @"微游记";
    
    //右侧按钮
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(200, 0, 40, 40);
    [rightBtn setImage:[UIImage imageNamed:@"new_tinyNote"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"new_tinyNote_down"] forState:UIControlStateSelected];
    [rightBtn addTarget:self action:@selector(pressRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItemBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItemBtn;
 
}

-(void)pressRightBtn:(UIButton *)btn
{
    NewAnnalViewController * nvc = [[NewAnnalViewController alloc] init];
    [self.navigationController pushViewController:nvc animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
