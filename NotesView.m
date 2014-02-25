//
//  NotesView.m
//  百度旅游
//
//  Created by Lucky on 13-4-7.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

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

#define MyDEBUG 1
#if MyDEBUG
#define MyLog(a...) NSLog(a)
#else
#define MyLog(a...)
#endif
@interface NotesView ()

@end

@implementation NotesView
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
    self.title = @"精彩游记";
    //retain————————————————————————————————
    tableName = [[NSString  stringWithFormat:@"notes%@",sidStr]retain];
    
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
    [mhttpdownload downloadFromUrl:EIGHTBTN_NOTES_URL];
    
    
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
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"NotesView";
    NotesCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NotesCell" owner:self options:nil] lastObject];
    }
    
    MyLog(@"在cell中dataarray数量 =%d",[dataArray count]);
    /* @property (nonatomic,retain) IBOutlet UIImageView * bigImageview;
     @property (nonatomic,retain) IBOutlet UIImageView * samllImageview;
     @property (nonatomic,retain) IBOutlet UILabel * titleLabel;
     @property (nonatomic,retain) IBOutlet UILabel * authorLabel;
     @property (nonatomic,retain) IBOutlet UILabel * dateLabel;
     @property (nonatomic,retain) IBOutlet UILabel * runLabel;*/
    NotesViewItem * item = [dataArray objectAtIndex:indexPath.row];
   // [cell.bigImageview setImageWithURL:[NSURL URLWithString:item.pic_url]];
    [cell.bigImageview setImageWithURL:[NSURL URLWithString:item.pic_url] placeholderImage:[UIImage imageNamed:@"image_default"]];
//    if ([item.is_set_guide isEqualToString:@"0"]) {
//        [cell.samllImageview setImage:[UIImage imageNamed:@"lv_note_icon_best"]];
//    }
    if ([item.is_set_guide intValue] == 0) {
        [cell.samllImageview setImage:[UIImage imageNamed:@"lv_note_icon_best"]];
    }
//    if ([item.is_set_guide isEqualToString:@"1"]) {
//       [cell.samllImageview setImage:[UIImage imageNamed:@"lv_note_icon_helpful"]];
//    }
    if ([item.is_set_guide intValue] == 1) {
        [cell.samllImageview setImage:[UIImage imageNamed:@"lv_note_icon_helpful"]];
    }
    
    cell.titleLabel.text = item.title;
    cell.authorLabel.text = [NSString stringWithFormat:@"作者：%@",item.user_nickname];
    cell.dateLabel.text = [NSString stringWithFormat:@"2013.%@出发",item.start_month];
    cell.runLabel.text = [NSString stringWithFormat:@"行程：%@天",item.time];
    
//    [cell.leftImageview setImageWithURL:[NSURL URLWithString:item.pic_url]];
//    cell.topLabel.text = item.sname;
//    NSString * str = [NSString stringWithFormat:@"%@人",item.going_count];
//    cell.bottomLabel.text = str;
//    [cell.bottomImageview setImage:[UIImage imageNamed:@"image-hotscene-visiting"]];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
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
                NSMutableArray * zongArray = [[NSMutableArray alloc] initWithArray:[dictBB objectForKey:@"notes_list"]];
                MyLog(@"总数组个数=%d",[zongArray count]);
                for (NSDictionary * dictB in zongArray)
                {
                    NotesViewItem * item = [[NotesViewItem alloc] init];
                    /* @property (nonatomic,retain) NSString * nid;
                     @property (nonatomic,retain) NSString * title;
                     @property (nonatomic,retain) NSString * departure;
                     @property (nonatomic,retain) NSString * time;
                     @property (nonatomic,retain) NSString * time_unit;
                     @property (nonatomic,retain) NSString * start_month;
                     @property (nonatomic,retain) NSString * start_time;
                     @property (nonatomic,retain) NSString * is_praised;
                     @property (nonatomic,retain) NSString * is_good;
                     @property (nonatomic,retain) NSString * is_set_guide;
                     @property (nonatomic,retain) NSString * pic_url;
                     @property (nonatomic,retain) NSString * user_nickname;*/
                    
                    item.nid = [dictB objectForKey:@"nid"];
                    item.title = [dictB objectForKey:@"title"];
                    item.departure = [dictB objectForKey:@"departure"];
                    item.time = [dictB objectForKey:@"time"];
                    item.time_unit = [dictB objectForKey:@"time_unit"];
                    item.start_month = [dictB objectForKey:@"start_month"];
                    item.start_time = [dictB objectForKey:@"start_time"];
                    item.is_praised = [dictB objectForKey:@"is_praised"];
                    item.is_good = [dictB objectForKey:@"is_good"];
                    item.is_set_guide = [dictB objectForKey:@"is_set_guide"];
                    item.pic_url = [dictB objectForKey:@"pic_url"];
                    item.user_nickname = [dictB objectForKey:@"user_nickname"];
                    [dataArray addObject:item];
                    MyLog(@"dataArray 数量 =%d",[dataArray count]);
                    [item release];
                }
                [zongArray release];
                //创建表
                if (0 != [dataArray count])
                {
                    NSString * sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (serial integer  PRIMARY KEY AUTOINCREMENT,nid TEXT(1024)  DEFAULT NULL,title TEXT(1024)  DEFAULT NULL,departure TEXT(1024)  DEFAULT NULL,time TEXT(1024) DEFAULT NULL,time_unit TEXT(1024)  DEFAULT NULL,start_month TEXT(1024)  DEFAULT NULL,start_time TEXT(1024)  DEFAULT NULL,is_praised TEXT(1024)  DEFAULT NULL,is_good TEXT(1024)  DEFAULT NULL,is_set_guide TEXT(1024)  DEFAULT NULL,pic_url TEXT(1024)  DEFAULT NULL,user_nickname TEXT(1024)  DEFAULT NULL)",tableName];
                    NotesViewItem * noteItem = [[NotesViewItem alloc] init];
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
    NotesViewItem * noteItem = [[NotesViewItem alloc] init];
    //从指定表读指定数据
    
    NSArray * array = [[Database sharedDatabase] selectFrom:tableName readItem:0 count:20 withItemType:noteItem];
    [noteItem release];
    
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
        NotesViewItem * noteItem = [[NotesViewItem alloc] init];
        //从指定表读指定数据
        
        NSArray * array = [[Database sharedDatabase] selectFrom:tableName readItem:0 count:20 withItemType:noteItem];
        [noteItem release];
        
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
