//
//  DiningView.m
//  百度旅游
//
//  Created by Lucky on 13-4-7.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "DiningView.h"
#import "SceneView.h"
#import "SceneCell.h"
#import "SceneItem.h"
#import "HttpDownload.h"
#import "CONST.h"
#import "Database.h"
#import "UIImageView+WebCache.h"
#import "ShowView.h"
#import "DiningItem.h"
#import "DiningCell.h"
#define MyDEBUG 1
#if MyDEBUG
#define MyLog(a...) NSLog(a)
#else
#define MyLog(a...)
#endif

@interface DiningView ()

@end

@implementation DiningView
@synthesize sidStr;
@synthesize buttonType;

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
    dataArray = [[NSMutableArray alloc] init];
    self.title = @"小吃";
    MyLog(@"~~~一进来打印sidstr==%@",sidStr);
    //retain————————————————————————————————
    tableName = [[NSString  stringWithFormat:@"dining%@",sidStr]retain];
    
    MyLog(@"初始化表名字%@",tableName);
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
    
    //下载
    mhttpdownload = [[HttpDownload alloc] init];
    mhttpdownload.delegate = self;
    [mhttpdownload downloadFromUrl:EIGHTBTN_DINING_URL];
    
    
	mTableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    mTableview.delegate = self;
    mTableview.dataSource = self;
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
    [mActivityIndicator startAnimating];

}
//返回响应
-(void)pressLeftButton:(UIButton *)btn
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//tableview代理函数
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"DiningView";
    DiningCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DiningCell" owner:self options:nil] lastObject];
    }
    
    MyLog(@"在cell中dataArray数量 =%d",[dataArray count]);
    
    DiningItem * item = [dataArray objectAtIndex:indexPath.row];
    [cell.leftImageView  setImageWithURL:[NSURL URLWithString:item.pic_url]];
    cell.topLabel.text = item.key;
    cell.bottomLabel.text = item.desc;  
    return cell;
    
}
//下载代理函数
//__________————————————————————————————————————————————————
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
                MyLog(@"————————————美食网址已失效——————————————");
                MyLog(@"网址失效时候数组长度%d",[dataArray count]);
                [self performSelectorInBackground:@selector(loadData) withObject:nil];
            }
            else
            {
                NSDictionary * dictBB = [dictA objectForKey:@"data"];
                NSMutableArray * zongArray = [[NSMutableArray alloc] initWithArray:[dictBB objectForKey:@"food"]];
                MyLog(@"总数组个数=%d",[zongArray count]);
                for (NSDictionary * dictB in zongArray)
                {
                    DiningItem * item = [[DiningItem alloc] init];
                    item.key = [dictB objectForKey:@"key"];
                    item.desc = [dictB objectForKey:@"desc"];
                    item.pic_url = [dictB objectForKey:@"pic_url"]; 
                    [dataArray addObject:item];
                    MyLog(@"dataArray 数量 =%d",[dataArray count]);
                    [item release];
                }
                [zongArray release];
                //创建表
                if (0 != [dataArray count])
                {
                    MyLog(@"打印tableName%@",tableName);
                    NSString * sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (serial integer  PRIMARY KEY AUTOINCREMENT,'key' TEXT(1024)  DEFAULT NULL,'desc' TEXT(1024)  DEFAULT NULL,pic_url TEXT(1024) DEFAULT NULL)",tableName];
                    
                    DiningItem * diningItem = [[DiningItem alloc] init];
                    [[Database sharedDatabase] buildTable:sqlString withTableType:diningItem];
                    [[Database sharedDatabase] insertArray:dataArray intable:tableName];
                    
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
    }
}
-(void)downloadFaild:(HttpDownload *)hd
{
    MyLog(@"http下载失败，准备读取数据库内容");
    DiningItem * diningTtem = [[DiningItem alloc] init];
    //从指定表读指定数据
    NSArray * array = [[Database sharedDatabase] selectFrom:tableName readItem:0 count:20 withItemType:diningTtem];
    [diningTtem release];
    
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
        //通知主线程刷新界面
        [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:NO];
    }
    
}
-(void)reloadTableView
{
    [mTableview reloadData];
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
        DiningItem * dinintItem = [[DiningItem alloc] init];
        //从指定表读指定数据
        MyLog(@"表名字--%@",tableName);
        NSArray * array = [[Database sharedDatabase] selectFrom:tableName readItem:0 count:20 withItemType:dinintItem];
        [dinintItem release];
        
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
            //通知主线程刷新界面
            [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:NO];
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
