//
//  ChinaProvinceSecondView.m
//  百度旅游
//
//  Created by Lucky on 13-4-3.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "ChinaProvinceSecondView.h"
#import "AppDelegate.h"
#import "LeveyTabBarController.h"
#import "ReadJsonClass.h"

@interface ChinaProvinceSecondView ()

@end

@implementation ChinaProvinceSecondView
@synthesize sidStr;
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
    //左按钮
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
    
    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStylePlain];
    mTableView.delegate =self;
    mTableView.dataSource = self;
    mTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:mTableView];
    [ShardApp leveyTabBarController].tabBar.hidden = YES;
    zongDict = [[NSDictionary alloc] initWithDictionary:[ReadJsonClass readBigDictionary]];
    zongArray = [zongDict objectForKey:sidStr];
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([zongArray count] == 0) {
        return 1;
    }
        return [zongArray count];

}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"ChinaProvinceSecondeView";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID]autorelease];
    }
    NSDictionary * dic = [zongArray objectAtIndex:indexPath.row];
    if ([zongArray count] == 0) {
        cell.textLabel.text = @"直辖市、特区无二级分页";
    }
    cell.textLabel.text = [dic objectForKey:@"sname"];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    return cell;
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
