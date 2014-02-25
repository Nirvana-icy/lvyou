//
//  SettingView.m
//  百度旅游
//
//  Created by Lucky on 13-3-30.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "SettingView.h"
#import "SettingViewCell.h"
#import "In_phaseView.h"
#import "MessagePushView.h"
#import "RealMessagePushView.h"
#import "AttitudeView.h"
#import "ServeItemView.h"

@interface SettingView ()

@end

@implementation SettingView

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
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    UIColor * color = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"image_share_bg"]];
    self.view.backgroundColor = color;
    self.title = @"设置";
    
    UIButton * lftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    lftButton.frame = CGRectMake(10, 7, 51, 30);
    [lftButton setBackgroundImage:[UIImage imageNamed:@"image_titlebar_back_button"] forState:UIControlStateNormal];
    [lftButton setBackgroundImage:[UIImage imageNamed:@"image_titlebar_back_button_pressed"] forState:UIControlStateSelected];
    [lftButton setTitle:@"个人" forState:UIControlStateNormal];
    lftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [lftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lftButton addTarget:self action:@selector(pressLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;

    
    firstArray = [NSArray arrayWithObjects:@"同步设置",@"消息推送",@"图片上传质量",@"退出账号", nil] ;
    secondArray = [NSArray arrayWithObjects:@"意见反馈",@"关于",@"去AppStore评价",@"百度旅游服务条款", nil] ;
    thirdArray = [NSArray arrayWithObjects:@"自动保存地理位置",@"关注",@"粉丝", nil];
    dataArray = [[NSMutableArray arrayWithObjects:firstArray,secondArray,thirdArray, nil] retain];
    
    
    //tableview
    mTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:mTableView];
    

    //rightbutton
//    rightButton = [[UIButton alloc] init];
//    isopen = YES;
//   // rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    rightButton.frame = CGRectMake(240, 5, 70, 30);
//    [rightButton setImage:[UIImage imageNamed:@"image_switch_on"] forState:UIControlStateNormal];
//    [rightButton setImage:[UIImage imageNamed:@"image_switch_off"] forState:UIControlStateSelected];
//    [rightButton addTarget:self action:@selector(pressRithtBtn:) forControlEvents:UIControlEventTouchUpInside];
    isopen = YES;
    rightButton = [[UISwitch alloc]initWithFrame:CGRectMake(240, 5, 70, 30)];
    rightButton.on = YES;
    [rightButton setOffImage:[UIImage imageNamed:@"image_switch_off"]];
    [rightButton setOnImage:[UIImage imageNamed:@"image_switch_on"]];
    rightButton .backgroundColor = [UIColor clearColor];
    [rightButton addTarget:self action:@selector(pressRithtBtn:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.on = YES;
    
    
}
//-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
//{
//
//}

-(void)pressRithtBtn:(UIButton *)btn
{
    
if (isopen) {
//    isopen = NO;
////          [rightButton setImage:[UIImage imageNamed:@"image_switch_off"] ];forState:UIControlEventValueChanged];
////    rightButton setOffImage:<#(UIImage *)#>
//    
//    }
//if (!isopen) {
//    isopen = YES;
//   [ rightButton setImage:[UIImage imageNamed:@"image_switch_on"] forState:UIControlEventValueChanged];

}


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;

}
//-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    return [dataArray count];
//
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dataArray count];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[dataArray objectAtIndex:section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString * cellID = @"settingViewID";
    SettingViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingViewCell" owner:self options:nil] lastObject];
    }
    cell.titleLabel.text = [[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] ;
    if (0 == indexPath.section && 2 == indexPath.row) {
        cell.subLabel.text = @"高清";
    }
    if (2 == indexPath.section && 0 == indexPath.row) {
        [cell addSubview : rightButton ];
    }
    
    //交集运算——————————————————————————————————
    if ((2 != indexPath.section) || (0 != indexPath.row)) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    }
    
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    In_phaseView * ipv = [[In_phaseView alloc] init];
    MessagePushView * mpv = [[MessagePushView alloc] init];
    RealMessagePushView * rmp = [[RealMessagePushView alloc] init];
    AttitudeView * atv = [[AttitudeView alloc] init];
    ServeItemView * siv = [[ServeItemView alloc] init];
    NSString * str =[NSString stringWithFormat:@"http://www.baidu.com"];
    NSURL * url = [NSURL URLWithString:str];
    
    if (0 == indexPath.section) {
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:ipv animated:YES];
                [ipv release];
                break;
            case 1:
                [self.navigationController pushViewController:rmp animated:YES];
                [rmp release];
                break;
            case 2:
                [self.navigationController pushViewController:mpv animated:YES];
                [mpv release];
                break;
            default:
                break;
        }
    }
    if (1 == indexPath.section) {
        switch (indexPath.row) {
                case 0:
                [self.navigationController pushViewController:atv animated:YES];
                [atv release];
                break;
            case 1:
                [self.navigationController pushViewController:rmp animated:YES];
                break;
            case 2:
                 [[UIApplication sharedApplication] openURL:url];
                break;
            case 3:
                [self.navigationController pushViewController:siv animated:YES];
                [siv release];
                break;

            default:
                break;
        }

    }
   
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

-(void)dealloc
{
    mTableView = nil;
    rightButton = nil;
    secondArray = nil;
    thirdArray = nil;
    dataArray = nil;
    [super dealloc];
    

}

@end
