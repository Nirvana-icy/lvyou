//
//  JingdianPushView.m
//  百度旅游
//
//  Created by Lucky on 13-4-9.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "JingdianPushView.h"

#import "ShowView.h"
#import "XLCycleScrollView.h"
#import "Mybutton.h"
#import "QuartzCore/QuartzCore.h"
#import "ChinaProvinceSecondView.h"
#import "CONST.h"
#import "MingShengJingDidanItem.h"
#import "Database.h"
#import "FMDatabase.h"
#import "PagecontrollerImageItem.h"
#import "UIImageView+WebCache.h"
#import "SceneView.h"
#import "DiningView.h"
#import "TrafficView.h"
#import "NotesView.h"
#import "ShoppingView.h"
#import "LineView.h"
#import "JingdianCellFirstItem.h"
#import "JingdianCellImageItem.h"

#define MyDEBUG 1
#if MyDEBUG
#define MyLog(a...) NSLog(a)
#else
#define MyLog(a...)
#endif
@interface JingdianPushView ()

@end

@implementation JingdianPushView
@synthesize sid,titleName;
@synthesize firstLabel,secondLabel,titleString,sname;
@synthesize sidStr;
@synthesize buttonType,receiveTitle;
@synthesize menpiaoLabel,kaifangshijianLabel,didianLabel;
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
    dataArray = [[NSMutableArray alloc] init];
    pageControllImageArray = [[NSMutableArray alloc] init];
}
-(void)makeView
{
    UIView * backgroundview = [[UIView alloc] initWithFrame:self.view.bounds];
    backgroundview.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:240.0/255.0 blue:243.0/255.0 alpha:1.0];
    UIImageView * imageviewTop = [[UIImageView alloc] initWithFrame:CGRectMake(130, 10, 60, 30)];
    imageviewTop.image = [UIImage imageNamed:@"image-baidutravel-logo"];
    UIImageView * imageviewBottom = [[UIImageView alloc] initWithFrame:CGRectMake(130,370, 60, 30)];
    imageviewBottom.image = [UIImage imageNamed:@"image-baidutravel-logo"];
    [backgroundview addSubview:imageviewTop];
    [backgroundview addSubview:imageviewBottom];
    [imageviewBottom release];
    [imageviewTop release];
    
    
    //图片展示层
    csView = [[XLCycleScrollView alloc] initWithFrame:self.view.bounds];
    csView.delegate = self;
    csView.datasource = self;
    //[self.view addSubview:csView];
    
    //scrollview
    mScrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    mScrollview.contentSize = CGSizeMake(320, 420);
    mScrollview.delegate = self;
    mScrollview.showsVerticalScrollIndicator = NO;
    mScrollview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    mScrollview.pagingEnabled = YES;
    mScrollview.bounces = YES;
    //    mScrollview.contentSize
    [mScrollview addSubview:csView];
    
    if ([dataArray count]) {
        JingdianCellFirstItem * item = [dataArray objectAtIndex:0];
        menpiaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 230, 200, 20)];
        menpiaoLabel.backgroundColor = [UIColor clearColor];
        menpiaoLabel.text = [NSString stringWithFormat:@"门票：%@",item.price];
        kaifangshijianLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 270, 200, 20)];
        kaifangshijianLabel.text = [NSString stringWithFormat:@"开放时间：%@",item.opening_hours];
        kaifangshijianLabel.backgroundColor = [UIColor clearColor];
        didianLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 310, 260, 20)];
        didianLabel.text = item.address;
        didianLabel.backgroundColor = [UIColor clearColor];
        [mScrollview addSubview:menpiaoLabel];
        [mScrollview addSubview:kaifangshijianLabel];
        [mScrollview addSubview:didianLabel];
    }
    

    
    
    [backgroundview addSubview:mScrollview];
    [self.view addSubview:backgroundview];
    [backgroundview release];
    [mActivityIndicator stopAnimating];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = receiveTitle;
    MyLog(@"标题!!%@",sid);
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
    self.navigationItem.title = titleName;
    MyLog(@"!!!!%@",sid);
    
    //数据下载——————————————————————————————————————————————
    mhttpdownload = [[HttpDownload alloc] init];
    mhttpdownload.delegate = self;
    [mhttpdownload downloadFromUrl:PERIPHERY_CELL_URL];
    
    //菊花
    mOpaqueview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    mActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    mActivityIndicator.center = mOpaqueview.center;
    mActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [mOpaqueview setBackgroundColor:[UIColor blackColor]];
    mOpaqueview.alpha = 0.6 ;
  //  [self.view addSubview:mOpaqueview];
   // [mOpaqueview addSubview:mActivityIndicator];
    //[mActivityIndicator startAnimating];

}
-(void)pressLeftButton:(UIButton *)btn
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfPages
{
    //return 5;
    MyLog(@"%d",[pageControllImageArray count]);
    return [pageControllImageArray count];
}
- (UIView *)pageAtIndex:(NSInteger)index
{
    UIImageView * vc = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    PagecontrollerImageItem * item = [pageControllImageArray objectAtIndex:index];
    // [vc setImageWithURL:[NSURL URLWithString:item.pic_url]];
    [vc setImageWithURL:[NSURL URLWithString:item.pic_url] placeholderImage:[UIImage imageNamed:@"image_default_big"]];
    
    
    return vc;
    
}
//点击图片触发
- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"当前点击第%d个页面",index] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [alert release];
}
//下载代理函数
//——————————————————————————————————————————————————————————————
-(void)downloadComplete:(HttpDownload *)hd
{
    if (hd.mData)
    {
        NSDictionary * dictA = [NSJSONSerialization JSONObjectWithData:hd.mData options:NSJSONReadingMutableContainers error:nil];
        if (dictA)
        {
            NSString * msgStr = [dictA objectForKey:@"msg"];
            if ([msgStr isEqualToString:@"key overdue"])
            {
                MyLog(@"————————————cell网址已失效——————————————");
                MyLog(@"网址失效时候数组长度%d",[dataArray count]);
                [self performSelectorInBackground:@selector(loadData) withObject:nil];
            }
            else
            {
                NSDictionary * dictB = [[NSDictionary alloc] initWithDictionary:[dictA objectForKey:@"data"]];
                MyLog(@"%d",[dictB count]);
                JingdianCellFirstItem * item = [[JingdianCellFirstItem alloc] init];
                item.sid = [dictB objectForKey:@"sid"];
                item.sname = [dictB objectForKey:@"sname"];
                item.scene_layer = [dictB objectForKey:@"scene_layer"];
                item.parent_sid = [dictB objectForKey:@"parent_sid"];
                item.x = [[dictB objectForKey:@"map_info"] objectForKey:@"x"];
                item.y = [[dictB objectForKey:@"map_info"] objectForKey:@"y"];
                item.desc = [[dictB objectForKey:@"abs"] objectForKey:@"desc"];
                item.opening_hours = [[[dictB objectForKey:@"abs"] objectForKey:@"info"] objectForKey:@"opening_hours"];
                item.price =  [[[dictB objectForKey:@"abs"] objectForKey:@"info"] objectForKey:@"price"];
                item.address = [[[dictB objectForKey:@"abs"] objectForKey:@"info"] objectForKey:@"address"];
                
                [dataArray addObject:item];
                MyLog(@"%@",item.sid);
                [item release];
                
                NSDictionary *dictCC = [[NSDictionary alloc] initWithDictionary:[dictB objectForKey:@"scene_album"]];
                NSArray * arrayCC = [[NSArray alloc] initWithArray:[dictCC objectForKey:@"pic_list"]];
               
                for (int i = 0; i<[arrayCC count]; i++) {
                     JingdianCellImageItem * jdimageItem = [[JingdianCellImageItem alloc] init];
                    NSDictionary * dictDD = [arrayCC objectAtIndex:i];
                    jdimageItem.pic_url = [dictDD objectForKey:@"pic_url"];
                    jdimageItem.is_cover = [dictDD objectForKey:@"is_cover"];
                    [pageControllImageArray addObject:jdimageItem];
                    [jdimageItem release];
                }
                
                
                
                //[self makeView];
                //创建表
                if (0 != [dataArray count])
                {
//                    NSString * str = [NSString stringWithFormat:@"cell%@",sidStr
//                                      ];
                    JingdianCellFirstItem * item = [dataArray objectAtIndex:0];
                    NSString * str = [NSString stringWithFormat:@"cell%@",item.sid];
                    NSString * sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (serial integer  PRIMARY KEY AUTOINCREMENT,sid TEXT(1024)  DEFAULT NULL,sname TEXT(1024)  DEFAULT NULL,scene_layer TEXT(1024)  DEFAULT NULL,parent_sid TEXT(1024)  DEFAULT NULL,x TEXT(1024)  DEFAULT NULL,y TEXT(1024)  DEFAULT NULL,'desc' TEXT(1024)  DEFAULT NULL,opening_hours TEXT(1024)  DEFAULT NULL,price TEXT(1024)  DEFAULT NULL,address TEXT(1024)  DEFAULT NULL)",str];
                    JingdianCellFirstItem * cellFirstItem = [[JingdianCellFirstItem alloc] init];
                    [[Database sharedDatabase] buildTable:sqlString withTableType:cellFirstItem];
                    [[Database sharedDatabase] insertArray:dataArray intable:str];
                    [cellFirstItem release];
                     
                }
                
                if ([pageControllImageArray count] !=0) {
                    JingdianCellFirstItem * item = [dataArray objectAtIndex:0];
                    NSString * str = [NSString stringWithFormat:@"cellimage%@",item.sid];
//                    NSString * str = [NSString stringWithFormat:@"cellimage%@",sidStr];
                    NSString * sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (serial integer  PRIMARY KEY AUTOINCREMENT,pic_url TEXT(1024)  DEFAULT NULL,is_cover TEXT(1024)  DEFAULT NULL)",str];
                    JingdianCellImageItem * cellImageItem = [[JingdianCellImageItem alloc] init];
                    [[Database sharedDatabase] buildTable:sqlString withTableType:cellImageItem];
                    [[Database sharedDatabase] insertArray:pageControllImageArray intable:str];
                    [cellImageItem release];
                    
                }   
                
            }
            //打印下看dataarry是否为空
            MyLog(@"下载完成dataarray数量=%d",[dataArray count]);
           // JingdianCellFirstItem * aa = [dataArray objectAtIndex:0];
            //MyLog(@"%@",aa.sname);
             MyLog(@"下载完成imagedata数量=%d",[pageControllImageArray count]);
            [self makeView];
            [csView reloadData];
            MyLog(@"running on %d", __LINE__);

        }
    }
}
-(void)downloadFaild:(HttpDownload *)hd
{
    MyLog(@"http下载失败，准备读取数据库内容");
    NSString * str = [NSString stringWithFormat:@"cell%@",sid];
    NSString * imageStr = [NSString stringWithFormat:@"cellimage%@",sid];
    
    JingdianCellFirstItem * jcItem = [[JingdianCellFirstItem alloc] init];
    //从指定表读指定数据
    
    NSArray * array = [[Database sharedDatabase] selectFrom:str readItem:0 count:20 withItemType:jcItem];
    [jcItem release];
    JingdianCellImageItem * jcIItem = [[JingdianCellImageItem alloc] init];
    NSArray * imageArray = [[Database sharedDatabase] selectFrom:imageStr readItem:0 count:20 withItemType:jcIItem];
    
    
    MyLog(@"景点的数组=%d",[array count]);
    if (0 == [array count] ) {
        MyLog(@"Views数据库第一次建立，数据还未存储");
        return;
    }
    if (array == nil) {
        MyLog(@"数组是空");
    }
    
    else
    {
        dataArray  = [[NSMutableArray alloc] initWithArray:array];
        pageControllImageArray = [[NSMutableArray alloc] initWithArray:imageArray];
        //通知主线程刷新界面
        [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:NO];
        [self makeView];
    }
    
}
-(void)reloadTableView
{
    [csView reloadData];
    [mActivityIndicator stopAnimating];
    mOpaqueview.hidden = YES;
    
}
//接口失效调用
-(void)loadData
{
    //新线程一定要创建自已的自动释放池
    @autoreleasepool
    {
        MyLog(@"接口失效，准备读取数据库数据");
        NSString * str = [NSString stringWithFormat:@"cell%@",sid];
        NSString * imageStr = [NSString stringWithFormat:@"cellimage%@",sid];
        
        JingdianCellFirstItem * jcItem = [[JingdianCellFirstItem alloc] init];
        //从指定表读指定数据
        MyLog(@"str===%@",str);
        MyLog(@"imagestr===%@",imageStr);
        NSArray * array = [[Database sharedDatabase] selectFrom:str readItem:0 count:20 withItemType:jcItem];
        [jcItem release];
        JingdianCellImageItem * jcIItem = [[JingdianCellImageItem alloc] init];
        NSArray * imageArray = [[Database sharedDatabase] selectFrom:imageStr readItem:0 count:20 withItemType:jcIItem];
        MyLog(@"^^^cell%d",[array count]);
         MyLog(@"^^^cellimage%d",[imageArray count]);
        
        MyLog(@"景点的数组=%d",[array count]);
        if (0 == [array count] ) {
            MyLog(@"Views数据库第一次建立，数据还未存储");
            return;
        }
        if (array == nil) {
            MyLog(@"数组是空");
        }
        
        else
        {
            dataArray  = [[NSMutableArray alloc] initWithArray:array];
            pageControllImageArray = [[NSMutableArray alloc] initWithArray:imageArray];
            MyLog(@"~~~%d",[dataArray count]);
            MyLog(@"~~~%d",[pageControllImageArray count]);
            //通知主线程刷新界面
            [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:NO];
            [self makeView];
            //[csView reloadData];
        }
        
    }
}



//————————————————————————————————————————————————————————————






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
