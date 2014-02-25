//
//  SceneView.m
//  百度旅游
//
//  Created by Lucky on 13-4-7.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "SceneView.h"
#import "SceneCell.h"
#import "SceneItem.h"
#import "HttpDownload.h"
#import "CONST.h"
#import "Database.h"
#import "UIImageView+WebCache.h"
#import "ShowView.h"
#define MyDEBUG 1
#if MyDEBUG
#define MyLog(a...) NSLog(a)
#else
#define MyLog(a...)
#endif


@interface SceneView ()

@end

@implementation SceneView
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
    dataArray = [[NSMutableArray alloc] init];
    self.title = @"热门景点";
    //retain————————————————————————————————
    tableName = [[NSString  stringWithFormat:@"scene%@",sidStr]retain];
    
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
    [mhttpdownload downloadFromUrl:EIGHTBTN_SCENE_URL];


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
    static NSString * cellID = @"SceneView";
    SceneCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SceneCell" owner:self options:nil] lastObject];
    }
    
    MyLog(@"在cell中dataarray数量 =%d",[dataArray count]);
    
    SceneItem * item = [dataArray objectAtIndex:indexPath.row];
    
    [cell.leftImageview setImageWithURL:[NSURL URLWithString:item.pic_url]];
    cell.topLabel.text = item.sname;
    NSString * str = [NSString stringWithFormat:@"%@人",item.going_count];
    cell.bottomLabel.text = str;
    [cell.bottomImageview setImage:[UIImage imageNamed:@"image-hotscene-visiting"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
    return cell;

}
//点击cell跳到相应的showview
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowView * sv = [[ShowView alloc] init];
   // SceneItem * item = [dataArray objectAtIndex:indexPath.row];
//    sv.sid = item.sid;
    sv.sid = @"239d1cc84836d6f3c8212bd6";
    [self.navigationController pushViewController:sv animated:YES];

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
                    MyLog(@"————————————景点网址已失效——————————————");
                    MyLog(@"网址失效时候数组长度%d",[dataArray count]);
                    [self performSelectorInBackground:@selector(loadData) withObject:nil];
                }
                else
                {
                    NSDictionary * dictBB = [dictA objectForKey:@"data"];
                    NSMutableArray * zongArray = [[NSMutableArray alloc] initWithArray:[dictBB objectForKey:@"scene_list"]];
                    MyLog(@"总数组个数=%d",[zongArray count]);
                    for (NSDictionary * dictB in zongArray)
                    {
                        SceneItem * item = [[SceneItem alloc] init];
                        item.sid = [dictB objectForKey:@"sid"];
                        item.sname = [dictB objectForKey:@"sname"];
                        item.scene_layer = [dictB objectForKey:@"scene_layer"];
                        item.parent_sid = [dictB objectForKey:@"parent_sid"];
                        item.going_count = [dictB objectForKey:@"going_count"];
                        item.gone_count = [dictB objectForKey:@"gone_count"];
                        item.pic_url = [dictB objectForKey:@"pic_url"];
                        item.distance = [dictB objectForKey:@"distance"];
                        item.map_x = [dictB objectForKey:@"map_x"];
                        item.map_y = [dictB objectForKey:@"map_y"];
                        item.abstract = [dictB objectForKey:@"abstract"];
                        item.desc = [dictB objectForKey:@"desc"];
                        
                        [dataArray addObject:item];
                        MyLog(@"dataArray 数量 =%d",[dataArray count]);
                        [item release];
                    }
                        [zongArray release];
                        //创建表
                        if (0 != [dataArray count])
                        {
                          //  tableName = [NSString  stringWithFormat:@"scene%@",sidStr];
                            NSString * sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (serial integer  PRIMARY KEY AUTOINCREMENT,sid TEXT(1024)  DEFAULT NULL,sname TEXT(1024)  DEFAULT NULL,scene_layer TEXT(1024)  DEFAULT NULL,parent_sid TEXT(1024)  DEFAULT NULL,going_count TEXT(1024)  DEFAULT NULL,gone_count TEXT(1024)  DEFAULT NULL,pic_url TEXT(1024)  DEFAULT NULL,distance TEXT(1024)  DEFAULT NULL,map_x TEXT(1024)  DEFAULT NULL,map_y TEXT(1024) DEFAULT NULL,abstract TEXT(1024)  DEFAULT NULL,'desc' TEXT(1024) DEFAULT NULL)",tableName];
                            SceneItem * scenitem = [[SceneItem alloc] init];
                            [[Database sharedDatabase] buildTable:sqlString withTableType:scenitem];
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
    SceneItem * sceneItem = [[SceneItem alloc] init];
        //从指定表读指定数据
    
    NSArray * array = [[Database sharedDatabase] selectFrom:tableName readItem:0 count:20 withItemType:sceneItem];
    [sceneItem release];

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
        SceneItem * sceneItem = [[SceneItem alloc] init];
        //从指定表读指定数据
        MyLog(@"表名字--%@",tableName);
        NSArray * array = [[Database sharedDatabase] selectFrom:tableName readItem:0 count:20 withItemType:sceneItem];
        [sceneItem release];
        
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
