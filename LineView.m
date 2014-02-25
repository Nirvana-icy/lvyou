//
//  LineView.m
//  百度旅游
//
//  Created by Lucky on 13-4-8.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "LineView.h"
#import "NotesView.h"
#import "SceneCell.h"
#import "SceneItem.h"
#import "HttpDownload.h"
#import "CONST.h"
#import "Database.h"
#import "UIImageView+WebCache.h"
#import "ShowView.h"
#import "NotesCell.h"
#import "NotesViewItem.h"
#import "LineItem.h"
#import "LineCell.h"
#import "PagecontrollerImageItem.h"
#import "LineNextView.h"

#define MyDEBUG 1
#if MyDEBUG
#define MyLog(a...) NSLog(a)
#else
#define MyLog(a...)
#endif
@interface LineView ()

@end

@implementation LineView
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
   // imageArray = [[NSMutableArray alloc] init];
    self.title = @"路线推荐";
    //retain————————————————————————————————
    tableName = [[NSString  stringWithFormat:@"line%@",sidStr]retain];
    
    //从数据库里读图片
    imageTablename = [[NSString stringWithFormat:@"A%@",sidStr]retain];
    PagecontrollerImageItem * pageImageItem = [[PagecontrollerImageItem alloc] init];
//    NSArray * tempArray = [[Database sharedDatabase] selectFrom:imageTablename readItem:0 count:10 withItemType:pageImageItem];
//    imageArray = [NSMutableArray arrayWithArray:tempArray];
    imageArray = [[NSMutableArray alloc] initWithArray:[[Database sharedDatabase] selectFrom:imageTablename readItem:0 count:10 withItemType:pageImageItem]];
    MyLog(@"打印看看imageArray里面是否有内容--%d",[imageArray count]);
    [pageImageItem release];
    
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
    [mhttpdownload downloadFromUrl:EIGHT_LINE_URL];
    
    
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
    return 150;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"LineView";
    LineCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LineCell" owner:self options:nil] lastObject];
    }
     MyLog(@"在cell中打印图片数组--%d",[imageArray count]);
    LineItem * item = [dataArray objectAtIndex:indexPath.row];
    MyLog(@"UUUUUUU%d",[imageArray count]);
    PagecontrollerImageItem * pgImageItem = [imageArray objectAtIndex:indexPath.row];
   
    [cell.topImageView setImage:[UIImage imageNamed:@"image-routeitem-icon"]];
    cell.titleLabel.text = item.key;
    cell.bottomLabel.text = item.desc;
    [cell.midImageView setImageWithURL:[NSURL URLWithString:pgImageItem.pic_url]];
    cell.midLabel.text = item.keyword;
    MyLog(@"在cell中dataarray数量 =%d",[dataArray count]);
    

    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LineNextView * lnv = [[LineNextView alloc] init];
    lnv.sid = sidStr;
    lnv.count = indexPath.row;
    [self.navigationController pushViewController:lnv animated:YES];
    [lnv release];

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
                MyLog(@"————————————游记网址已失效——————————————");
                MyLog(@"网址失效时候数组长度%d",[dataArray count]);
                [self performSelectorInBackground:@selector(loadData) withObject:nil];
            }
            else
            {
                NSDictionary * dictBB = [dictA objectForKey:@"data"];
                NSMutableArray * zongArray = [[NSMutableArray alloc] initWithArray:[dictBB objectForKey:@"list"]];
                MyLog(@"总数组个数=%d",[zongArray count]);
                for (NSDictionary * dictB in zongArray)
                {
                    NSArray * pathArray = [dictB objectForKey:@"path"];
                    NSDictionary * lastDict = [pathArray objectAtIndex:0];
                    
                    LineItem * item = [[LineItem alloc]init];
                    item.key = [dictB objectForKey:@"key"];
                    item.keyword = [dictB objectForKey:@"keyword"];
                    item.desc = [lastDict objectForKey:@"desc"];
                    item.dinning = [lastDict objectForKey:@"dinning"];
                    item.accordination = [lastDict objectForKey:@"accordination"];
                    [dataArray addObject:item];
                    MyLog(@"dataArray 数量 =%d",[dataArray count]);
                    [item release];
                }
                [zongArray release];
                //创建表
                if (0 != [dataArray count])
                {
                    NSString * sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (serial integer  PRIMARY KEY AUTOINCREMENT,'key' TEXT(1024)  DEFAULT NULL,keyword TEXT(2000)  DEFAULT NULL,'desc' TEXT(3000) DEFAULT NULL,dinning TEXT(1024)  DEFAULT NULL,accordination TEXT(2000)  DEFAULT NULL)",tableName];
                    LineItem * noteItem = [[LineItem alloc] init];
                    [[Database sharedDatabase] buildTable:sqlString withTableType:noteItem];
                    [[Database sharedDatabase] insertArray:dataArray intable:tableName];
                    [noteItem release];
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
    
    LineItem * lnItem = [[LineItem alloc] init];
    //从指定表读指定数据
    
    NSArray * array = [[Database sharedDatabase] selectFrom:tableName readItem:0 count:20 withItemType:lnItem];
    [lnItem release];
    
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
        LineItem * lnItem = [[LineItem alloc] init];
        //从指定表读指定数据
        
        NSArray * array = [[Database sharedDatabase] selectFrom:tableName readItem:0 count:20 withItemType:lnItem];
        [lnItem release];
        
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
