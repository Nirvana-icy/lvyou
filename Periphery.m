//
//  Periphery.m
//  百度旅游
//
//  Created by Lucky on 13-3-23.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "Periphery.h"
#import "MyCell_Periphery.h"
#import "PlatView.h"
#import "JingdianCell.h"
#import "OthersCell.h"
#import "HttpDownload.h"
#import "CONST.h"
#import "Database.h"
#import "UIImageView+WebCache.h"
#import "ShowView.h"
#import "PeripheryJingdianItem.h"
#import "PeripheryCanyinItem.h"
#import "PeripheryJingdianItem.h"
#import "PeripheryXiuxianItem.h"
#import "PeripheryJiudianItem.h"
#import "JingdianPushView.h"

#define MyDEBUG 1
#if MyDEBUG
#define MyLog(a...) NSLog(a)
#else
#define MyLog(a...)
#endif

@interface Periphery ()

@end

@implementation Periphery
@synthesize sidStr;
@synthesize buttonType;
@synthesize segmentedControl1;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // return [cateArray count];
    return [dataArray count];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataArray != nil) {
        //景点
        if ([[dataArray objectAtIndex:0] isKindOfClass:[PeripheryJingdianItem class]])
        {
            static NSString * cellID = @"Jingdian";
            JingdianCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (nil == cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"JingdianCell" owner:self options:nil] lastObject];
            }
            PeripheryJingdianItem * item = [dataArray objectAtIndex:indexPath.row];
            [cell.leftImageView setImageWithURL:[NSURL URLWithString:item.pic_url]];
            cell.titleLabel.text = item.sname;
            //字母
            cell.firstLabel.text = [zimuArray objectAtIndex:indexPath.row];
            cell.secondLabel.text = [NSString stringWithFormat:@"%@米",item.distance];
            cell.thirdLabel.text = [NSString stringWithFormat:@"%@人",item.going_count];
            [cell.secondeImageView setImage:[UIImage imageNamed:@"location"]];
            [cell.thirdImageView setImage:[UIImage imageNamed:@"love"]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            return  cell;
        }
        //餐饮
        if ([[dataArray objectAtIndex:0] isKindOfClass:[PeripheryCanyinItem class]])
        {
            static NSString * cellID = @"OthersCellID";
            OthersCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (nil == cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"OthersCell" owner:self options:nil] lastObject];
            }
            PeripheryCanyinItem * item = [dataArray objectAtIndex:indexPath.row];
            cell.titleLabel.text = item.name;
            cell.secondeLabel.text = [NSString stringWithFormat:@"¥%@",item.price];
            cell.thirdLabel.text = [NSString stringWithFormat:@"%@米",item.distance];
            cell.fourthLabel.text = [NSString stringWithFormat:@"%@条评论",item.comm_num];
           cell.firstLabel.text = [zimuArray objectAtIndex:indexPath.row];
           
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //星星
            if ([item.star floatValue]>0&&[item.star floatValue]<=2)
            {

                [cell.secondImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.thirdImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                
            }
            else if([item.star floatValue]>2&&[item.star floatValue]<=4)
            {
                [cell.secondImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                 [cell.thirdImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                 [cell.fourthImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.fiveImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                
            }
            else if([item.star floatValue]>4&&[item.star floatValue]<=6)
            {
                [cell.secondImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.thirdImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.fourthImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                 [cell.fiveImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
               
            }
            else if([item.star floatValue]>0&&[item.star floatValue]<=1)
            {
                [cell.secondImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                
            }
            else if([item.star floatValue]>4)
            {
                [cell.secondImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.thirdImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.fourthImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.fiveImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
               [cell.sixImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                
            }

            
            
            return  cell;
        }
        //酒店
        if ([[dataArray objectAtIndex:0] isKindOfClass:[PeripheryJiudianItem class]])
        {
            static NSString * cellID = @"OthersCellID";
            OthersCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (nil == cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"OthersCell" owner:self options:nil] lastObject];
            }
            PeripheryJiudianItem * item = [dataArray objectAtIndex:indexPath.row];
            cell.titleLabel.text = item.name;
            cell.secondeLabel.text = [NSString stringWithFormat:@"¥%@",item.price];
            cell.thirdLabel.text = [NSString stringWithFormat:@"%@米",item.distance];
            cell.fourthLabel.text = [NSString stringWithFormat:@"%@条评论",item.comm_num];
            cell.firstLabel.text = [zimuArray objectAtIndex:indexPath.row];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //星星
            if ([item.star floatValue]>0&&[item.star floatValue]<=2)
            {
                
                [cell.secondImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.thirdImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                
            }
            else if([item.star floatValue]>2&&[item.star floatValue]<=4)
            {
                [cell.secondImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.thirdImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.fourthImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.fiveImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                
            }
            else if([item.star floatValue]>4&&[item.star floatValue]<=6)
            {
                [cell.secondImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.thirdImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.fourthImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.fiveImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                
            }
            else if([item.star floatValue]>0&&[item.star floatValue]<=1)
            {
                [cell.secondImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                
            }
            else if([item.star floatValue]>4)
            {
                [cell.secondImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.thirdImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.fourthImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.fiveImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.sixImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                
            }
            else if([item.star floatValue]== 0)
            {
                [cell.secondImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
            }

            
            
            return  cell;
        }
        //休闲
        if ([[dataArray objectAtIndex:0] isKindOfClass:[PeripheryXiuxianItem class]])
        {
            static NSString * cellID = @"OthersCellID";
            OthersCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (nil == cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"OthersCell" owner:self options:nil] lastObject];
            }
            PeripheryXiuxianItem * item = [dataArray objectAtIndex:indexPath.row];
            cell.titleLabel.text = item.name;
            cell.secondeLabel.text = [NSString stringWithFormat:@"¥%@",item.price];
            cell.thirdLabel.text = [NSString stringWithFormat:@"%@米",item.distance];
            cell.fourthLabel.text = [NSString stringWithFormat:@"%@条评论",item.comm_num];
            cell.firstLabel.text = [zimuArray objectAtIndex:indexPath.row];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //星星
            if ([item.star floatValue]>0&&[item.star floatValue]<=2)
            {
                
                [cell.secondImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.thirdImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                
            }
            else if([item.star floatValue]>2&&[item.star floatValue]<=4)
            {
                [cell.secondImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.thirdImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.fourthImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.fiveImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                
            }
            else if([item.star floatValue]>4&&[item.star floatValue]<=6)
            {
                [cell.secondImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.thirdImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.fourthImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.fiveImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                
            }
            else if([item.star floatValue]>0&&[item.star floatValue]<=1)
            {
                [cell.secondImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                
            }
            else if([item.star floatValue]>4)
            {
                [cell.secondImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.thirdImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.fourthImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.fiveImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                [cell.sixImageview setImage:[UIImage imageNamed:@"lv_hotel_icon_full_star"]];
                
            }
          
 
            return  cell;
        }
    }
 
    
    
    
        static NSString * cellID = @"Periphery";
        MyCell_Periphery * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (nil == cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyCell_Periphery" owner:self options:nil] lastObject];
        }
        cell.titleLable.text = @"aaa";
        cell.critiqueLable.text =@"ff";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     return cell;
 
    
}

//做tableview脚视图——————————————————————————————————————————————————————————————
-(void)creatFootView
{
    footTableView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    footTableView.backgroundColor = [UIColor whiteColor];
    first = [[UILabel alloc]initWithFrame:CGRectMake(150, 20, 20, 10)];
    first.font = [UIFont systemFontOfSize:10];
    first.textAlignment = NSTextAlignmentRight;
    first.backgroundColor = [UIColor clearColor];
    UILabel * center = [[UILabel alloc] initWithFrame:CGRectMake(170, 20, 3, 10)];
    center.font = [UIFont systemFontOfSize:10];
    center.backgroundColor = [UIColor clearColor];
    second =[[UILabel alloc] initWithFrame:CGRectMake(173, 20, 20, 10)];
    second.font = [UIFont systemFontOfSize:10];
    second.textAlignment = NSTextAlignmentLeft;
    second.backgroundColor = [UIColor clearColor];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(280, 12.5, 25, 25);
    [button setImage:[UIImage imageNamed:@"nextPage"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"nextPage_hover"] forState:UIControlStateSelected];
    first.text= @"1";
    center.text = @"/";
    second.text = @"1";
    UIImageView * imv = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"image_periphery_scenemap_inputtextfield_background"]];
    [footTableView addSubview:imv];
    [footTableView addSubview:first];
    [footTableView addSubview:center];
    [footTableView addSubview:second];
    [footTableView addSubview:button];
    [first release];
    [center release];
    [second release];
   // footTableView.backgroundColor = [UIColor redColor];


}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
   // self.view.backgroundColor = [UIColor blueColor];
    dataArray2 = [[NSMutableArray alloc] init];
    dataArray3 = [[NSMutableArray alloc] init];
    dataArray4 = [[NSMutableArray alloc] init];
    self.navigationItem.title = @"周边";
    zimuArray  = [[NSMutableArray alloc] init];
    char vv = 'A';
    for (int i=0; i<26; i++) {
        [zimuArray addObject:[NSString stringWithFormat:@"%c",vv]];
        vv++;
    }
//    for (NSString * str in zimuArray) {
//        MyLog(@"%@",str);
//    }
    
    
    //设置右侧地图按钮————————————————————————————————————————————
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    btn.frame = CGRectMake(280, 7, 45, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"img_moresceneindex_titleButton_normal"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"img_moresceneindex_titleButton_press"] forState:UIControlStateHighlighted];
    [btn setTitle:@"地图" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn addTarget:self action:@selector(pressPlat:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
  //segment————————————————————————————————————————————————
    
    segmentedControl3 = [[AKSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 320.0, 37.0)];
    [segmentedControl3 setDelegate:self];
    //self.view.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:240.0/255.0 blue:243.0/255.0 alpha:1.0];
    [self setupSegmentedControl3];
   // [self creatTableview];
    [self creatFootView];
    //mTableView.tableFooterView = footTableView;
    
    
    //copy——————————————————————————————————————————————————————————
    dataArray = [[NSMutableArray alloc] init];
    //retain————————————————————————————————
   // tableName = [[NSString  stringWithFormat:@"scene%@",sidStr]retain];
    sidStr = @"795ac511463263cf7ae3def3";
    
    MyLog(@"初始化表名字%@",tableName);
    
    //下载
    mhttpdownload = [[HttpDownload alloc] init];
    mhttpdownload.delegate = self;
    mhttpdownload.downloadType = JINGDIAN;
    [mhttpdownload downloadFromUrl:PERIPHERY_JINGDIAN_URL];
    
    
	mTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 400) style:UITableViewStylePlain];
    mTableview.delegate = self;
    mTableview.dataSource = self;
    mTableView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:240.0/255.0 blue:243.0/255.0 alpha:1.0];
    mTableview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:mTableview];
    
    //菊花
    mOpaqueview = [[UIView alloc] initWithFrame:CGRectMake(110, 180, 100, 100)];
    mActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(110, 180, 100, 100)];
    mActivityIndicator.center = mOpaqueview.center;
    mActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [mOpaqueview setBackgroundColor:[UIColor blackColor]];
    mOpaqueview.alpha = 0.6 ;
    [self.view addSubview:mOpaqueview];
    [mOpaqueview addSubview:mActivityIndicator];
    UIApplication* app = [ UIApplication sharedApplication ];
    app.networkActivityIndicatorVisible = YES;
    [self.view addSubview:mActivityIndicator];
   // [mActivityIndicator startAnimating];


  }

//下载代理函数
//——————————————————————————————————————————————————————————————
-(void)downloadComplete:(HttpDownload *)hd
{
    [dataArray removeAllObjects];
    if (hd.mData)
    {
        NSDictionary * dictA = [NSJSONSerialization JSONObjectWithData:hd.mData options:NSJSONReadingMutableContainers error:nil];
        if (dictA)
        {
    //————————————————————————————————————————————————————————————————————
        //景点
            if (hd.downloadType == JINGDIAN)
            {
                NSString * msgStr = [dictA objectForKey:@"msg"];
                if ([msgStr isEqualToString:@"key overdue"])
                {
                    MyLog(@"————————————景点网址已失效——————————————");
                    MyLog(@"网址失效时候数组长度%d",[dataArray count]);
                    [self performSelectorInBackground:@selector(loadData:) withObject:hd];
                }
                else
                {
                    NSDictionary * dictBB = [dictA objectForKey:@"data"];
                    NSMutableArray * zongArray = [[NSMutableArray alloc] initWithArray:[dictBB objectForKey:@"scene_list"]];
                    MyLog(@"总数组个数=%d",[zongArray count]);
                    for (NSDictionary * dictB in zongArray)
                    {
                        PeripheryJingdianItem * item = [[PeripheryJingdianItem alloc] init];
                        
                        item.sid = [dictB objectForKey:@"sid"];
                        item.sname = [dictB objectForKey:@"sname"];
                        item.pic_url = [dictB objectForKey:@"pic_url"];
                        item.distance = [dictB objectForKey:@"distance"];
                        item.map_x = [dictB objectForKey:@"map_x"];
                        item.map_y = [dictB objectForKey:@"map_y"];
                        item.star = [dictB objectForKey:@"star"];
                        item.going_count = [dictB objectForKey:@"going_count"];
                        [dataArray addObject:item];
                        MyLog(@"dataArray 数量 =%d",[dataArray count]);
                        [item release];
                    }
                    [zongArray release];
                    //创建表
                    if (0 != [dataArray count])
                    {
                        tableName = [NSString stringWithFormat:@"jingdian%@",sidStr];
                        
                        NSString * sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (serial integer  PRIMARY KEY AUTOINCREMENT,sid TEXT(1024)  DEFAULT NULL,sname TEXT(1024)  DEFAULT NULL,pic_url TEXT(1024)  DEFAULT NULL,distance TEXT(1024)  DEFAULT NULL,map_x TEXT(1024) DEFAULT NULL,map_y TEXT(1024)  DEFAULT NULL,star TEXT(1024)  DEFAULT NULL,going_count TEXT(1024)  DEFAULT NULL)",tableName];
                        PeripheryJingdianItem * jingdianItem = [[PeripheryJingdianItem alloc] init];
                        [[Database sharedDatabase] buildTable:sqlString withTableType:jingdianItem];
                        [[Database sharedDatabase] insertArray:dataArray intable:tableName];
                        [jingdianItem release];
                        [mActivityIndicator stopAnimating];
                        mOpaqueview.hidden = YES;
                        [mTableview reloadData];
                    }
                    
                }
                //    NSString * str = [NSString stringWithFormat:@"select  train_id, train_number , sub_train_number  ,  to_station_name,  to_time, from_time, to_station_id,station_num  ,day, km   from train  where train_number = 'K287'"]
                //打印下看dataarry是否为空
                MyLog(@"下载完成dataarray数量=%d",[dataArray count]);
                //[self makeView];
                MyLog(@"running on %d", __LINE__);
            }
         //餐饮
            if (hd.downloadType == CANYIN)
            {
                NSString * msgStr = [dictA objectForKey:@"msg"];
                if ([msgStr isEqualToString:@"key overdue"])
                {
                    MyLog(@"————————————景点网址已失效——————————————");
                    MyLog(@"网址失效时候数组长度%d",[dataArray count]);
                    [self performSelectorInBackground:@selector(loadData:) withObject:hd];
                }
                else
                {
                    NSDictionary * dictBB = [dictA objectForKey:@"data"];
                    NSMutableArray * zongArray = [[NSMutableArray alloc] initWithArray:[dictBB objectForKey:@"list"]];
                    MyLog(@"总数组个数=%d",[zongArray count]);
                    for (NSDictionary * dictB in zongArray)
                    {
                        PeripheryCanyinItem * item = [[PeripheryCanyinItem alloc] init];
                        item.name = [dictB objectForKey:@"name"];
                        item.address = [dictB objectForKey:@"address"];
                        item.distance = [dictB objectForKey:@"distance"];
                        item.uid = [dictB objectForKey:@"uid"];
                        item.map_x = [dictB objectForKey:@"map_x"];
                        item.map_y = [dictB objectForKey:@"map_y"];
                        item.comm_num = [dictB objectForKey:@"comm_num"];
                        item.price = [dictB objectForKey:@"price"];
                        item.star = [dictB objectForKey:@"star"];
                        item.type = [dictB objectForKey:@"type"];
                       
                        [dataArray addObject:item];
                        MyLog(@"dataArray 数量 =%d",[dataArray count]);
                        [item release];
                    }
                    [zongArray release];
                    //创建表
                    if (0 != [dataArray count])
                    {
                        tableName = [NSString stringWithFormat:@"canyin%@",sidStr];
                        NSString * sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (serial integer  PRIMARY KEY AUTOINCREMENT,name TEXT(1024)  DEFAULT NULL,address TEXT(1024)  DEFAULT NULL,distance TEXT(1024)  DEFAULT NULL,uid TEXT(1024)  DEFAULT NULL,map_y TEXT(1024)  DEFAULT NULL,map_x TEXT(1024)  DEFAULT NULL,comm_num TEXT(1024)  DEFAULT NULL,price TEXT(1024)  DEFAULT NULL,star TEXT(1024)  DEFAULT NULL,type TEXT(1024)  DEFAULT NULL)",tableName];
                        
                        PeripheryCanyinItem * canyinItem = [[PeripheryCanyinItem alloc] init];
                        [[Database sharedDatabase] buildTable:sqlString withTableType:canyinItem];
                        [[Database sharedDatabase] insertArray:dataArray intable:tableName];
                        [canyinItem release];
                        [mActivityIndicator stopAnimating];
                        mOpaqueview.hidden = YES;
                        [mTableview reloadData];
                    }
                    
                }
                
                //打印下看dataarry是否为空
                MyLog(@"下载完成dataarray数量=%d",[dataArray count]);
                //[self makeView];
                MyLog(@"running on %d", __LINE__);
            }
        //酒店
            if (hd.downloadType == JIUDIAN)
            {
                NSString * msgStr = [dictA objectForKey:@"msg"];
                if ([msgStr isEqualToString:@"key overdue"])
                {
                    MyLog(@"————————————酒店网址已失效——————————————");
                    MyLog(@"网址失效时候数组长度%d",[dataArray count]);
                    [self performSelectorInBackground:@selector(loadData:) withObject:hd];
                }
                else
                {
                    NSDictionary * dictBB = [dictA objectForKey:@"data"];
                    NSMutableArray * zongArray = [[NSMutableArray alloc] initWithArray:[dictBB objectForKey:@"list"]];
                    MyLog(@"总数组个数=%d",[zongArray count]);
                    for (NSDictionary * dictB in zongArray)
                    {
                        PeripheryJiudianItem  * item = [[PeripheryJiudianItem alloc] init];
                        item.name = [dictB objectForKey:@"name"];
                        item.address = [dictB objectForKey:@"address"];
                        item.distance = [dictB objectForKey:@"distance"];
                        item.uid = [dictB objectForKey:@"uid"];
                        item.map_x = [dictB objectForKey:@"map_x"];
                        item.map_y = [dictB objectForKey:@"map_y"];
                        item.comm_num = [dictB objectForKey:@"comm_num"];
                        item.price = [dictB objectForKey:@"price"];
                        item.star = [dictB objectForKey:@"star"];
                        item.type = [dictB objectForKey:@"type"];
                        
                        [dataArray addObject:item];
                        MyLog(@"dataArray 数量 =%d",[dataArray count]);
                        [item release];
                    }
                    [zongArray release];
                    //创建表
                    if (0 != [dataArray count])
                    {
                        tableName = [NSString stringWithFormat:@"jiudian%@",sidStr];
                        NSString * sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (serial integer  PRIMARY KEY AUTOINCREMENT,name TEXT(1024)  DEFAULT NULL,address TEXT(1024)  DEFAULT NULL,distance TEXT(1024)  DEFAULT NULL,uid TEXT(1024)  DEFAULT NULL,map_y TEXT(1024)  DEFAULT NULL,map_x TEXT(1024)  DEFAULT NULL,comm_num TEXT(1024)  DEFAULT NULL,price TEXT(1024)  DEFAULT NULL,star TEXT(1024)  DEFAULT NULL,type TEXT(1024)  DEFAULT NULL)",tableName];
                        
                        PeripheryJiudianItem * jiudianItem = [[PeripheryJiudianItem alloc] init];
                        [[Database sharedDatabase] buildTable:sqlString withTableType:jiudianItem];
                        [[Database sharedDatabase] insertArray:dataArray intable:tableName];
                        [jiudianItem release];
                        [mActivityIndicator stopAnimating];
                        mOpaqueview.hidden = YES;
                        [mTableview reloadData];
                    }
                    
                }
                
                //打印下看dataarry是否为空
                MyLog(@"下载完成dataarray数量=%d",[dataArray count]);
                //[self makeView];
                MyLog(@"running on %d", __LINE__);
            }
        //休闲
            if (hd.downloadType == XIUXIAN)
            {
                NSString * msgStr = [dictA objectForKey:@"msg"];
                if ([msgStr isEqualToString:@"key overdue"])
                {
                    MyLog(@"————————————休闲网址已失效——————————————");
                    MyLog(@"网址失效时候数组长度%d",[dataArray count]);
                    [self performSelectorInBackground:@selector(loadData:) withObject:hd];
                }
                else
                {
                    NSDictionary * dictBB = [dictA objectForKey:@"data"];
                    NSMutableArray * zongArray = [[NSMutableArray alloc] initWithArray:[dictBB objectForKey:@"list"]];
                    MyLog(@"总数组个数=%d",[zongArray count]);
                    for (NSDictionary * dictB in zongArray)
                    {
                        PeripheryXiuxianItem  * item = [[PeripheryXiuxianItem alloc] init];
                        item.name = [dictB objectForKey:@"name"];
                        item.address = [dictB objectForKey:@"address"];
                        item.distance = [dictB objectForKey:@"distance"];
                        item.uid = [dictB objectForKey:@"uid"];
                        item.map_x = [dictB objectForKey:@"map_x"];
                        item.map_y = [dictB objectForKey:@"map_y"];
                        item.comm_num = [dictB objectForKey:@"comm_num"];
                        item.price = [dictB objectForKey:@"price"];
                        item.star = [dictB objectForKey:@"star"];
                        item.type = [dictB objectForKey:@"type"];
                        
                        [dataArray addObject:item];
                        MyLog(@"dataArray 数量 =%d",[dataArray count]);
                        [item release];
                    }
                    [zongArray release];
                    //创建表
                    if (0 != [dataArray count])
                    {
                        tableName = [NSString stringWithFormat:@"xiuxian%@",sidStr];
                        NSString * sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (serial integer  PRIMARY KEY AUTOINCREMENT,name TEXT(1024)  DEFAULT NULL,address TEXT(1024)  DEFAULT NULL,distance TEXT(1024)  DEFAULT NULL,uid TEXT(1024)  DEFAULT NULL,map_y TEXT(1024)  DEFAULT NULL,map_x TEXT(1024)  DEFAULT NULL,comm_num TEXT(1024)  DEFAULT NULL,price TEXT(1024)  DEFAULT NULL,star TEXT(1024)  DEFAULT NULL,type TEXT(1024)  DEFAULT NULL)",tableName];
                        
                        PeripheryXiuxianItem * xiuxianItem = [[PeripheryXiuxianItem alloc] init];
                        [[Database sharedDatabase] buildTable:sqlString withTableType:xiuxianItem];
                        [[Database sharedDatabase] insertArray:dataArray intable:tableName];
                        [xiuxianItem release];
                        [mActivityIndicator stopAnimating];
                        mOpaqueview.hidden = YES;
                        [mTableview reloadData];
                    }
                    
                }
                
                //打印下看dataarry是否为空
                MyLog(@"下载完成dataarray数量=%d",[dataArray count]);
                //[self makeView];
                MyLog(@"running on %d", __LINE__);
            }


         
            
  //——————————————————————————————————————————————————————————————————————
        }
    }
}
-(void)downloadFaild:(HttpDownload *)hd
{
    MyLog(@"http下载失败，准备读取数据库内容");
    [dataArray removeAllObjects];
    //景点
    if (hd.downloadType == JINGDIAN) {
        NSString * str = [[NSString stringWithFormat:@"jingdian%@",sidStr]retain];
        PeripheryJingdianItem * jingdianItem = [[PeripheryJingdianItem alloc] init];
        [str release];
        MyLog(@"%@",str);
        //从指定表读指定数据   
        NSArray * array = [[Database sharedDatabase] selectFrom:str readItem:0 count:20 withItemType:jingdianItem];
        [jingdianItem release];
        
        MyLog(@"景点的数组=%d",[array count]);
        if (0 == [array count] ) {
            MyLog(@"景点Views数据库第一次建立，数据还未存储");
            return;
        }
        if (array == nil) {
            MyLog(@"数组是空");
        }
        
        else
        {   
            dataArray  = [[NSMutableArray alloc] initWithArray:array];
            //通知主线程刷新界面
            [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:NO];
        }

    }
    //餐饮
    if (hd.downloadType == CANYIN) {
        NSString * str = [[NSString stringWithFormat:@"canyin%@",sidStr]retain];
        PeripheryCanyinItem * jingdianItem = [[PeripheryCanyinItem alloc] init];
        [str release];
        MyLog(@"%@",str);
        //从指定表读指定数据
        NSArray * array = [[Database sharedDatabase] selectFrom:str readItem:0 count:20 withItemType:jingdianItem];
        [jingdianItem release];
        
        MyLog(@"景点的数组=%d",[array count]);
        if (0 == [array count] ) {
            MyLog(@"餐饮Views数据库第一次建立，数据还未存储");
            return;
        }
        if (array == nil) {
            MyLog(@"数组是空");
        }
        
        else
        {
            dataArray  = [[NSMutableArray alloc] initWithArray:array];
            //通知主线程刷新界面
            [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:NO];
        }
        
    }
    //酒店
    if (hd.downloadType == JIUDIAN) {
        NSString * str = [[NSString stringWithFormat:@"jiudian%@",sidStr]retain];
        PeripheryJiudianItem * jiudianItem = [[PeripheryJiudianItem alloc] init];
        [str release];
        MyLog(@"%@",str);
        //从指定表读指定数据
        NSArray * array = [[Database sharedDatabase] selectFrom:str readItem:0 count:20 withItemType:jiudianItem];
        [jiudianItem release];
        
        MyLog(@"景点的数组=%d",[array count]);
        if (0 == [array count] ) {
            MyLog(@"酒店Views数据库第一次建立，数据还未存储");
            return;
        }
        if (array == nil) {
            MyLog(@"数组是空");
        }
        
        else
        {
            dataArray  = [[NSMutableArray alloc] initWithArray:array];
            //通知主线程刷新界面
            [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:NO];
        }
        
    }
    //休闲
    if (hd.downloadType == XIUXIAN) {
        NSString * str = [[NSString stringWithFormat:@"xiuxian%@",sidStr]retain];
        PeripheryXiuxianItem * xiuxianItem = [[PeripheryXiuxianItem alloc] init];
        [str release];
        MyLog(@"%@",str);
        //从指定表读指定数据
        NSArray * array = [[Database sharedDatabase] selectFrom:str readItem:0 count:20 withItemType:xiuxianItem];
        [xiuxianItem release];
        
        MyLog(@"景点的数组=%d",[array count]);
        if (0 == [array count] ) {
            MyLog(@"酒店Views数据库第一次建立，数据还未存储");
            return;
        }
        if (array == nil) {
            MyLog(@"数组是空");
        }
        
        else
        {
            dataArray  = [[NSMutableArray alloc] initWithArray:array];
            //通知主线程刷新界面
            [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:NO];
        }
        
    }
}
-(void)reloadTableView
{
    [mTableview reloadData];
    [mActivityIndicator stopAnimating];
    mOpaqueview.hidden = YES;
    
}
//接口失效调用
-(void)loadData:(HttpDownload *)hd
{
    //新线程一定要创建自已的自动释放池
    @autoreleasepool
    {   [dataArray removeAllObjects];
        //景点
        if (hd.downloadType == JINGDIAN) {
            NSString * str = [[NSString stringWithFormat:@"jingdian%@",sidStr]retain];
            PeripheryJingdianItem * jingdianItem = [[PeripheryJingdianItem alloc] init];
            [str release];
            MyLog(@"%@",str);
            //从指定表读指定数据
            NSArray * array = [[Database sharedDatabase] selectFrom:str readItem:0 count:20 withItemType:jingdianItem];
            [jingdianItem release];
            
            MyLog(@"景点的数组=%d",[array count]);
            if (0 == [array count] ) {
                MyLog(@"景点Views数据库第一次建立，数据还未存储");
                return;
            }
            if (array == nil) {
                MyLog(@"数组是空");
            }
            
            else
            {
                dataArray  = [[NSMutableArray alloc] initWithArray:array];
                //通知主线程刷新界面
                [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:NO];
            }
            
        }
        //餐饮
        if (hd.downloadType == CANYIN) {
            NSString * str = [[NSString stringWithFormat:@"canyin%@",sidStr]retain];
            PeripheryCanyinItem * jingdianItem = [[PeripheryCanyinItem alloc] init];
            [str release];
            MyLog(@"%@",str);
            //从指定表读指定数据
            NSArray * array = [[Database sharedDatabase] selectFrom:str readItem:0 count:20 withItemType:jingdianItem];
            [jingdianItem release];
            
            MyLog(@"景点的数组=%d",[array count]);
            if (0 == [array count] ) {
                MyLog(@"餐饮Views数据库第一次建立，数据还未存储");
                return;
            }
            if (array == nil) {
                MyLog(@"数组是空");
            }
            
            else
            {
                dataArray  = [[NSMutableArray alloc] initWithArray:array];
                //通知主线程刷新界面
                [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:NO];
            }
            
        }
        //酒店
        if (hd.downloadType == JIUDIAN) {
            NSString * str = [[NSString stringWithFormat:@"jiudian%@",sidStr]retain];
            PeripheryJiudianItem * jiudianItem = [[PeripheryJiudianItem alloc] init];
            [str release];
            MyLog(@"%@",str);
            //从指定表读指定数据
            NSArray * array = [[Database sharedDatabase] selectFrom:str readItem:0 count:20 withItemType:jiudianItem];
            [jiudianItem release];
            
            MyLog(@"景点的数组=%d",[array count]);
            if (0 == [array count] ) {
                MyLog(@"酒店Views数据库第一次建立，数据还未存储");
                return;
            }
            if (array == nil) {
                MyLog(@"数组是空");
            }
            
            else
            {
                dataArray  = [[NSMutableArray alloc] initWithArray:array];
                //通知主线程刷新界面
                [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:NO];
            }
            
        }
        //休闲
        if (hd.downloadType == XIUXIAN) {
            NSString * str = [[NSString stringWithFormat:@"xiuxian%@",sidStr]retain];
            PeripheryXiuxianItem * xiuxianItem = [[PeripheryXiuxianItem alloc] init];
            [str release];
            MyLog(@"%@",str);
            //从指定表读指定数据
            NSArray * array = [[Database sharedDatabase] selectFrom:str readItem:0 count:20 withItemType:xiuxianItem];
            [xiuxianItem release];
            
            MyLog(@"景点的数组=%d",[array count]);
            if (0 == [array count] ) {
                MyLog(@"酒店Views数据库第一次建立，数据还未存储");
                return;
            }
            if (array == nil) {
                MyLog(@"数组是空");
            }
            
            else
            {
                dataArray  = [[NSMutableArray alloc] initWithArray:array];
                //通知主线程刷新界面
                [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:NO];
            }
            
        }
     
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[dataArray objectAtIndex:0] isKindOfClass:[PeripheryJingdianItem class]]) {
         JingdianPushView * jpv = [[JingdianPushView alloc] init];
        if ([dataArray count] != 0) {
            PeripheryJingdianItem * item = [dataArray objectAtIndex:indexPath.row];
            jpv.receiveTitle = item.sname;
            jpv.sid = item.sid;
        }
//          jpv.sidStr = sidStr;
         [self.navigationController pushViewController:jpv animated:YES];
   
    }
    


}



//创建segment函数——————————————————————————————————————————————————————————————————
- (void)setupSegmentedControl3
{
    UIImage *backgroundImage = [[UIImage imageNamed:@"bar_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
    [segmentedControl3 setBackgroundImage:backgroundImage];
    [segmentedControl3 setContentEdgeInsets:UIEdgeInsetsMake(2.0, 2.0, 3.0, 2.0)];
    [segmentedControl3 setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
    
    [segmentedControl3 setSeparatorImage:[UIImage imageNamed:@"segmented-separator.png"]]; 
    // Button 1
    UIButton *buttonSocial = [[UIButton alloc] init];
   // UIButton * buttonSocial = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonSocial setTitle:@"景点" forState:UIControlStateNormal];
    [buttonSocial setTitleColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonSocial setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonSocial.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [buttonSocial.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    [buttonSocial setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    UIImage *buttonSocialImageNormal = [UIImage imageNamed:@"scene"];

    [buttonSocial setBackgroundImage:[UIImage imageNamed:@"bar_hover"] forState:UIControlStateHighlighted];
    [buttonSocial setBackgroundImage:[UIImage imageNamed:@"bar_hover"] forState:UIControlStateSelected];
    [buttonSocial setBackgroundImage:[UIImage imageNamed:@"bar_hover"] forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateNormal];
    //设置Button的三种状态
    [buttonSocial setImage:[UIImage imageNamed:@"scene_hover"] forState:UIControlStateSelected];
    [buttonSocial setImage:[UIImage imageNamed:@"scene_hover"] forState:UIControlStateHighlighted];
    [buttonSocial setImage:[UIImage imageNamed:@"scene_hover"] forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    // Button 2
    UIButton *buttonStar = [[UIButton alloc] init];
    //UIButton * buttonStar = [UIButton buttonWithType:UIButtonTypeCustom];

    
    [buttonStar setTitle:@"餐饮" forState:UIControlStateNormal];
    [buttonStar setTitleColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonStar setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonStar.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [buttonStar.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    [buttonStar setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    [buttonStar setBackgroundImage:[UIImage imageNamed:@"bar_hover"] forState:UIControlStateHighlighted];
    [buttonStar setBackgroundImage:[UIImage imageNamed:@"bar_hover"] forState:UIControlStateSelected];
    [buttonStar setBackgroundImage:[UIImage imageNamed:@"bar_hover"] forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonStar setImage:[UIImage imageNamed:@"cate"] forState:UIControlStateNormal];
    [buttonStar setImage:[UIImage imageNamed:@"cate_hover"] forState:UIControlStateSelected];
    [buttonStar setImage:[UIImage imageNamed:@"cate_hover"] forState:UIControlStateHighlighted];
    [buttonStar setImage:[UIImage imageNamed:@"cate_hover"] forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    // Button 3
    UIButton *buttonSettings = [[UIButton alloc] init];
     //UIButton * buttonSettings = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [buttonSettings setTitle:@"酒店" forState:UIControlStateNormal];
    [buttonSettings setTitleColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonSettings setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonSettings.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [buttonSettings.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    [buttonSettings setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    UIImage *buttonSettingsImageNormal = [UIImage imageNamed:@"drinkery"];
    [buttonSettings setBackgroundImage:[UIImage imageNamed:@"bar_hover"] forState:UIControlStateHighlighted];
    [buttonSettings setBackgroundImage:[UIImage imageNamed:@"bar_hover"] forState:UIControlStateSelected];
    [buttonSettings setBackgroundImage:[UIImage imageNamed:@"bar_hover"] forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateNormal];
    [buttonSettings setImage:[UIImage imageNamed:@"drinkery_hover"] forState:UIControlStateSelected];
    [buttonSettings setImage:[UIImage imageNamed:@"drinkery_hover"] forState:UIControlStateHighlighted];
    [buttonSettings setImage:[UIImage imageNamed:@"drinkery_hover"] forState:(UIControlStateHighlighted|UIControlStateSelected)];
     // Button 4
    UIButton * buttonlersure = [[UIButton alloc] init];
    
    [buttonlersure setTitle:@"休闲" forState:UIControlStateNormal];
    [buttonlersure setTitleColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonlersure setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonlersure.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [buttonlersure.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    [buttonlersure setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    UIImage * buttonlersureImageNormal = [UIImage imageNamed:@"cate"];
    [buttonlersure setBackgroundImage:[UIImage imageNamed:@"bar_hover"] forState:UIControlStateHighlighted];
    [buttonlersure setBackgroundImage:[UIImage imageNamed:@"bar_hover"] forState:UIControlStateSelected];
    [buttonlersure setBackgroundImage:[UIImage imageNamed:@"bar_hover"] forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonlersure setImage:buttonlersureImageNormal forState:UIControlStateNormal];
    [buttonlersure setImage:[UIImage imageNamed:@"cate_hover"] forState:UIControlStateSelected];
    [buttonlersure setImage:[UIImage imageNamed:@"cate_hover"] forState:UIControlStateHighlighted];
    [buttonlersure setImage:[UIImage imageNamed:@"cate_hover"] forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    [segmentedControl3 setButtonsArray:@[buttonSocial, buttonStar, buttonSettings,buttonlersure]];
    [self.view addSubview:segmentedControl3];

}


#pragma mark -
#pragma mark AKSegmentedControlDelegate

- (void)segmentedViewController:(AKSegmentedControl *)segmentedControl touchedAtIndex:(NSUInteger)index
{
    if (segmentedControl == segmentedControl3)
    {
        if (index == 0) {
//            mhttpdownload = [[HttpDownload alloc] init];
//            mhttpdownload.delegate = self;
            mhttpdownload.downloadType = JINGDIAN;
            [mhttpdownload downloadFromUrl:PERIPHERY_JINGDIAN_URL];
            [mTableView reloadData];
        }
        if (index == 1) {
//            mhttpdownload = [[HttpDownload alloc] init];
//            mhttpdownload.delegate = self;
            mhttpdownload.downloadType = CANYIN;
            [mhttpdownload downloadFromUrl:PERIPHERY_CANYIN_URL];
            [mTableView reloadData];
        }
        if (index == 2) {
//            mhttpdownload = [[HttpDownload alloc] init];
//            mhttpdownload.delegate = self;
            mhttpdownload.downloadType = JIUDIAN;
            [mhttpdownload downloadFromUrl:PERIPHERY_JIUDIAN_URL];
            [mTableView reloadData];
        }
        if (index == 3) {
//            mhttpdownload = [[HttpDownload alloc] init];
//            mhttpdownload.delegate = self;
            mhttpdownload.downloadType = XIUXIAN;
            [mhttpdownload downloadFromUrl:PERIPHERY_XIUXIAN_URL];
            [mTableView reloadData];
        }
        
    }
       
}

//地图按钮响应事件
-(void)pressPlat:(UIButton *)button
{
    PlatView * pv = [[PlatView alloc] init];
    pv.receiveSid = sidStr;
   // pv.modalPresentationStyle = UIModalTransitionStyleFlipHorizontal;
    pv.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:pv animated:YES completion:nil];



}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
 
    btn = nil;
    viewController = nil;
    segmentedControl3 = nil;
    mTableView = nil;
    cateArray = nil;
    footTableView = nil;
    [super dealloc];
    


}

@end
