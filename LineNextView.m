//
//  LineNextView.m
//  百度旅游
//
//  Created by Lucky on 13-4-8.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "LineNextView.h"
#import "LineItem.h"
#import "Database.h"

@interface LineNextView ()

@end

@implementation LineNextView
@synthesize sid,count;
@synthesize labelone,labelfive,labelfour,labelthree,laebeltwo;
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
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%@",sid);
    //左返回按钮
    UIButton * lftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    lftButton.frame = CGRectMake(10, 7, 51, 30);
    [lftButton setBackgroundImage:[UIImage imageNamed:@"image_titlebar_back_button"] forState:UIControlStateNormal];
    [lftButton setBackgroundImage:[UIImage imageNamed:@"image_titlebar_back_button_pressed"] forState:UIControlStateSelected];
    [lftButton setTitle:@"返回" forState:UIControlStateNormal];
    lftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [lftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lftButton addTarget:self action:@selector(pressLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    LineItem * item = [[LineItem alloc] init];
    NSString * tableName = [NSString stringWithFormat:@"line%@",sid];
    dataArray = [[NSMutableArray alloc] initWithArray: [[Database sharedDatabase] selectFrom:tableName readItem:0 count:20 withItemType:item]];
    NSLog(@"打印Linenext,dataArray数量%d",[dataArray count]);
    item = [dataArray objectAtIndex:count];
    NSLog(@"%@",item.keyword);
    
    labelone.text = item.key;
    laebeltwo.text = item.keyword;
    labelthree.text = item.desc;
    labelfour.text = item.dinning;
    labelfive.text = item.accordination;
    

}
//返回响应
-(void)pressLeftButton:(UIButton *)btn
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc
{
    sid = nil;
    dataArray = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
