//
//  ChinaProvinceView.m
//  百度旅游
//
//  Created by Lucky on 13-4-2.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "ChinaProvinceView.h"
#import "ReadJsonClass.h"
#import "HiddenTabBar.h"
#import "AppDelegate.h"
#import "LeveyTabBarController.h"
#import "pinyin.h"
#import "ChinaProvinceSecondView.h"

#define MyDEBUG 0
#if MyDEBUG
#define MyLog(a...) NSLog(a)
#else
#define MyLog(a...)
#endif
@interface ChinaProvinceView ()

@end

@implementation ChinaProvinceView

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
//    [HiddenTabBar hidden:self.tabBarController isHidden:YES];
//    [HiddenTabBar hiddenTabBar:self.tabBarController animated:YES isHidden:YES];
    //这么写比较保准
    mProvinceArray = [[NSMutableArray alloc] initWithArray:[ReadJsonClass readprovinceArray]];
    MyLog(@"^^^^^^^^^^^%d",[mProvinceArray count]);
    for (NSDictionary * tedi in mProvinceArray) {
        NSString * str = [tedi objectForKey:@"sname"];
        MyLog(@"!!!%@",str);
        
    }
    
    zongArray = [[NSMutableArray alloc]init];

    //根据汉字进行排序
    for (int i = 0; i<[mProvinceArray count] - 1; i++) {
        for (int j = i+1; j<[mProvinceArray count]; j++) {
            NSDictionary * dict1 = [mProvinceArray objectAtIndex:i];
            NSString * str1 = [dict1 objectForKey:@"sname"];
            char c1 = pinyinFirstLetter([str1 characterAtIndex:0]);
            
            NSDictionary * dict2 = [mProvinceArray objectAtIndex:j];
            NSString * str2 = [dict2 objectForKey:@"sname"];
            char c2 = pinyinFirstLetter([str2 characterAtIndex:0]);
            
            if (c1 > c2) {
                [mProvinceArray exchangeObjectAtIndex:i withObjectAtIndex:j];
            }  
        }
    }
    
    //按个字母分组
    char pinyin[] ={'a','b','c','f','g','h','j','l','n','q','s','t','x','y','z'};
    NSMutableArray * jiaArray = [[NSMutableArray alloc] initWithArray:mProvinceArray];
    
    for (int i = 0; i< sizeof(pinyin); i++) {
        NSMutableArray* xarray = [[NSMutableArray alloc] init];
        for(NSDictionary * dd in jiaArray) {
            NSString * ss = [dd objectForKey:@"sname"];
            char cc = pinyinFirstLetter([ss characterAtIndex:0]);
            MyLog(@"！111····~~%c",cc);
            if (pinyin[i] == cc) {
                [xarray addObject:dd];
            }
        }
        [zongArray addObject:xarray];
    }
    [zongArray removeLastObject];
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    for (NSDictionary * dict in mProvinceArray) {
        NSString * str =[dict objectForKey:@"sid"];
        if ([str isEqualToString:@"1fdbf740851f3e07d8d23ff7"]) {
            [arr addObject:dict];
            //不能加return;
            //return;
        }
    }
    [zongArray insertObject:arr atIndex:2];
    MyLog(@"))))))))))))%d",[zongArray count]);
    
//   // MyLog(@"^^^^~~~~~****%d",[zongArray count]);
//    for (NSArray * aa in zongArray) {
//   // NSArray * aa = [zongArray objectAtIndex:8];
//  
//        for (NSDictionary * dd in aa) {
//            NSString * str = [dd objectForKey:@"sname"];
//            MyLog(@")))))0%@",str);
// }
//    }
    
    
    
	mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStylePlain];
    mTableView.delegate =self;
    mTableView.dataSource = self;
    mTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    mTableView.sectionIndexColor = [UIColor redColor];
    
    [self.view addSubview:mTableView];
    [ShardApp leveyTabBarController].tabBar.hidden = YES;
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
    
}
-(void)pressLeftButton:(UIButton *)btn
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//产生索引数组
-(NSArray*) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //NSMutableArray* array = [[NSMutableArray alloc] init];
    
    //搜索图标
   // [array addObject:UITableViewIndexSearch];
    
//    for ( int i = 'A'; i <= 'Z'; i++) {
//        NSString* str = [NSString stringWithFormat:@"%c",i];
//        [array addObject:str];
//    }
    NSMutableArray * array = [[NSMutableArray alloc] initWithObjects:@"热门",@"场合用",@"A",@"B",@"C",@"F",@"G",@"H",@"J",@"L",@"N",@"Q",@"S",@"T",@"X",@"Y",@"Z", nil];
    //结束字段
   // [array addObject:@"结束"];
    
    return array ;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [zongArray count];
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[zongArray objectAtIndex:section] count];

}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    //NSDictionary * dict = [mProvinceArray objectAtIndex:indexPath.row];
    NSArray * perArray = [zongArray objectAtIndex:indexPath.section];
    NSDictionary * dic = [perArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"sname"];
    //cell.textLabel.text = [dict objectForKey:@"sname"];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
   
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * perArray = [zongArray objectAtIndex:indexPath.section];
    NSDictionary * dic = [perArray objectAtIndex:indexPath.row];
    ChinaProvinceSecondView * cpv = [[ChinaProvinceSecondView alloc] init];
    cpv.sidStr = [dic objectForKey:@"sid"];
    [self.navigationController pushViewController:cpv animated:YES];


}
-(void)viewDidAppear:(BOOL)animated
{
    [ShardApp leveyTabBarController].tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
