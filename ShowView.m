//
//  ShowView.m
//  百度旅游
//
//  Created by Lucky on 13-4-4.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

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


#define MyDEBUG 1
#if MyDEBUG
#define MyLog(a...) NSLog(a)
#else
#define MyLog(a...)
#endif
@interface ShowView ()

@end

@implementation ShowView
@synthesize sid,titleName;
@synthesize firstLabel,secondLabel,titleString,sname;

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
    btnArray = [[NSArray alloc] init];
    buttonImageArray = [[NSMutableArray alloc]initWithObjects:@"image_cityPage_jd",@"image_cityPage_ms",@"image_cityPage_zs",@"image_cityPage_jt",@"image_cityPage_yj",@"image_cityPage_lx",@"image_cityPage_gw",@"image_cityPage_syxx", nil];
    
    buttonTitleArray = [[NSMutableArray alloc] initWithObjects:@"景点",@"美食",@"住宿",@"交通",@"游记",@"线路",@"购物",@"指南", nil];
    
    buttonEnglish = [[NSMutableArray alloc] initWithObjects:@"top_scene",@"dining",@"accommodation",@"traffic",@"notes",@"new_line",@"shopping",@"abs", nil];

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
    
    //测试做按钮
    MingShengJingDidanItem * mingItem = [dataArray objectAtIndex:0];
    NSString * taglistStr = mingItem.tag_list;
    btnArray = [taglistStr componentsSeparatedByString:@","];
    MyLog(@"通过拆分得到的数组%d",[btnArray count]);
    for (NSString * ss in btnArray) {
        MyLog(@"打印拆分的字段%@",ss);
    }
    
    int i = 0;
    int j = 100;
    int x = 0;
    for (NSString * str in buttonEnglish) {
        for (NSString * xsr in btnArray) {
            if ([str isEqualToString:xsr]) {
                Mybutton * btn = [Mybutton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(0+80*(i%4), 216+100*(i/4), 80, 100);
                [btn setImage:[UIImage imageNamed:[buttonImageArray objectAtIndex:x]] withTitle:[buttonTitleArray objectAtIndex:x] forState:UIControlStateNormal];
                 [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
                btn.titleLabel.textColor = [UIColor blackColor];
                btn.tag = j++;
                btn.type = str;
                MyLog(@"打印按钮tag=%d",btn.tag);
                [mScrollview addSubview:btn];
                NSLog(@"xunhuan");
                 i++;
                break;
            }
        }
        x++;
    }
    

    [backgroundview addSubview:mScrollview];
    [self.view addSubview:backgroundview];
    [backgroundview release];
    [mActivityIndicator stopAnimating];


}

//可以在这给mscrollview做个回去的动画
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    mScrollview.frame = CGRectMake(0, 0, 320, 420);
//    
//}
-(void)startDownload:(NSString *)urlStr downloadType:(NSInteger)type
{
    //   NSInteger rowCount = [[Database sharedDatabase] itemCount];
    
    //数据下载——————————————————————————————————————————————
    mhttpdownload = [[HttpDownload alloc] init];
    mhttpdownload.delegate = self;
    mhttpdownload.downloadType = type;
    [mhttpdownload downloadFromUrl:urlStr];
  
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title= titleString;
    MyLog(@"标题%@",titleString);
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
    
    //下载数据
    [self startDownload:MINGSHENGJINGDIAN_URL downloadType:MINGSHENGJINGDIAN_DOWNLOAD_TYPE];
    
    //菊花
    mOpaqueview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    mActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    mActivityIndicator.center = mOpaqueview.center;
    mActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [mOpaqueview setBackgroundColor:[UIColor blackColor]];
    mOpaqueview.alpha = 0.6 ;
    [self.view addSubview:mOpaqueview];
    [mOpaqueview addSubview:mActivityIndicator];
    [mActivityIndicator startAnimating];

    

}
//八按钮响应事件
-(void)pressBtn:(Mybutton *)btn
{   
    Mybutton * button = btn;
    //scene
    if ([button.type isEqualToString:@"top_scene"] ) {
        SceneView * sv = [[SceneView alloc] init];
        sv.sidStr = sid;
        sv.buttonType = button.type;
        [self.navigationController pushViewController:sv animated:YES];
        [sv release];
    }
   //dining
   else if ([button.type isEqualToString:@"dining"] ) {
        DiningView * dv = [[DiningView alloc] init];
       MyLog(@"showview===%@",sid);
        dv.sidStr = sid;
        [self.navigationController pushViewController:dv animated:YES];
       [dv release];
    }
    //traffic
   else if ([button.type isEqualToString:@"traffic"] ) {
       TrafficView * tv = [[TrafficView alloc] init];
       MyLog(@"showview===%@",sid);
       tv.sidStr = sid;
       [self.navigationController pushViewController:tv animated:YES];
       [tv release];
   }
    //notes
    else if ([button.type isEqualToString:@"notes"] ) {
        NotesView * nv = [[NotesView alloc] init];
        MyLog(@"showview===%@",sid);
        nv.sidStr = sid;
        [self.navigationController pushViewController:nv animated:YES];
        [nv release];
    }
    //shopping
    else if ([button.type isEqualToString:@"shopping"] ) {
        ShoppingView * sv = [[ShoppingView alloc] init];
        MyLog(@"showview===%@",sid);
        sv.sidStr = sid;
        [self.navigationController pushViewController:sv animated:YES];
        [sv release];
    }
    //line
    else if ([button.type isEqualToString:@"new_line"] ) {
        LineView * lv = [[LineView alloc] init];
        MyLog(@"showview===%@",sid);
        lv.sidStr = sid;
        [self.navigationController pushViewController:lv animated:YES];
        [lv release];
    }




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
    
    //做遮盖层
    UIView * vw = [[UIView alloc] initWithFrame:CGRectMake(0, 170, 320, 44)];
    vw.backgroundColor = [UIColor blackColor];
    //只改变背景的透明度
    vw.backgroundColor = [vw.backgroundColor colorWithAlphaComponent:0.5];
   // vw.alpha = 0.6;
    firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 23)];
    firstLabel.backgroundColor = [UIColor clearColor];
    firstLabel.textColor = [UIColor whiteColor];
    secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 22, 320, 24)];
    secondLabel.backgroundColor = [UIColor clearColor];
    secondLabel.textColor = [UIColor whiteColor];
    //firstLabel.font = [UIFont systemFontOfSize:14];
    firstLabel.font = [UIFont boldSystemFontOfSize:14];
   // secondLabel.font = [UIFont systemFontOfSize:12];
    secondLabel.font = [UIFont boldSystemFontOfSize:12];

    firstLabel.text = item.title;
    secondLabel.text = item.desc;
    [vw addSubview:firstLabel];
    [vw addSubview:secondLabel];
    [vc addSubview:vw];

      return vc;
    
}
//点击图片触发
- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"当前点击第%d个页面",index] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(void)downloadComplete:(HttpDownload *)hd
{
    if (hd.mData) {
        NSDictionary * dictA = [NSJSONSerialization JSONObjectWithData:hd.mData options:NSJSONReadingMutableContainers error:nil];
        if (dictA) {
            if (MINGSHENGJINGDIAN_DOWNLOAD_TYPE == hd.downloadType) {
                NSString * msgStr = [dictA objectForKey:@"msg"];
                if ([msgStr isEqualToString:@"key overdue"]) {
                    MyLog(@"————————————风景名胜网址已失效——————————————");
                    //在新线程中执行loadData方法
                    MyLog(@"网址失效时候数组长度%d",[dataArray count]);
                    [self performSelectorInBackground:@selector(loadData) withObject:nil];
                }
                else
                {
                    NSDictionary * dictB = [[NSDictionary alloc] initWithDictionary:[dictA objectForKey:@"data"]];
                    MyLog(@"%d",[dictB count]);
                    MingShengJingDidanItem * item = [[MingShengJingDidanItem alloc] init];
                    item.sid = [dictB objectForKey:@"sid"];
                    item.sname = [dictB objectForKey:@"sname"];
                    item.scene_layer = [dictB objectForKey:@"scene_layer"];
                    item.parent_sid = [dictB objectForKey:@"parent_sid"];
                    item.is_china = [dictB objectForKey:@"is_china"];
                    item.x = [[dictB objectForKey:@"map_info"] objectForKey:@"x"];
                    item.y = [[dictB objectForKey:@"map_info"] objectForKey:@"y"];
                    item.pic_url = [dictB objectForKey:@"pic_url"];
                    item.level = [dictB objectForKey:@"level"];
                    item.is_newest = [[dictB objectForKey:@"package_info"] objectForKey:@"is_newest"];
                    item.package_exist = [[dictB objectForKey:@"package_info"] objectForKey:@"package_exist"];
                    item.package_url = [[dictB objectForKey:@"package_info"] objectForKey:@"package_url"];
                    item.package_size = [[dictB objectForKey:@"package_info"] objectForKey:@"package_size"];
                    item.aid = [[dictB objectForKey:@"high_light_album"] objectForKey:@"aid"];
                    item.pics_count = [[dictB objectForKey:@"high_light_album"] objectForKey:@"pics_count"];
                    NSArray * tempArray = [[NSArray alloc] initWithArray:[dictB objectForKey:@"tag_list"]];
                    NSString * taglistString = [tempArray componentsJoinedByString:@","];
                    item.tag_list = taglistString;
                    MyLog(@"++++打印拼接字符串%@",taglistString);
                    
                    [dataArray addObject:item];
                    [item release];
//                    //按钮取值
//                   
//                    MingShengJingDidanItem * mingItem = [dataArray objectAtIndex:0];
//                    NSString * taglistStr = mingItem.tag_list;
//                    btnArray = [taglistStr componentsSeparatedByString:@","];
//                    MyLog(@"通过拆分得到的数组%d",[btnArray count]);
//                    [mScrollview reloadInputViews];
                    
                    [self makeView];
                    
                    
                    
                    //创建数据库，存入数据
                    if (0 != [dataArray count]) {
                        [[Database sharedDatabase] insertArray:dataArray];
                        //创建pagecontrol图片表
                        NSString * tableName = [NSString stringWithFormat:@"A%@",item.sid];
                        NSString * sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (serial integer  PRIMARY KEY AUTOINCREMENT,pic_url TEXT(1024)  DEFAULT NULL,is_cover TEXT(1024)  DEFAULT NULL,title TEXT(1024)  DEFAULT NULL,'desc' TEXT(1024)  DEFAULT NULL)",tableName];
                        [[Database sharedDatabase] creatTable:sqlString];
                       
                        //解析pagecontrol
                        NSArray * pageImageArray = [[NSArray alloc] initWithArray:[[dictB objectForKey:@"high_light_album"] objectForKey:@"pic_list"]];
                        //NSMutableArray * cunchuArray = [[NSMutableArray alloc] init];
                        for (int i = 0; i<[pageImageArray count]; i++) {
                             PagecontrollerImageItem * pageimageItem = [[PagecontrollerImageItem alloc] init];
                            NSDictionary * dicA = [pageImageArray objectAtIndex:i];
                            pageimageItem.pic_url = [dicA objectForKey:@"pic_url"];
                            pageimageItem.is_cover = [dicA objectForKey:@"is_cover"];
                            pageimageItem.title = [[dicA objectForKey:@"ext"] objectForKey:@"title"];
                            pageimageItem.desc = [[dicA objectForKey:@"ext"] objectForKey:@"desc"];
                            
                            [pageControllImageArray addObject:pageimageItem];
                            [pageimageItem release];
                        }
                        MyLog(@"下载成功running on %d", __LINE__);
                        //存储pagecontrol图片地址到pagecontrol图片表
                        [[Database sharedDatabase] insertArray:pageControllImageArray intable:tableName];
                    }
                    
                }
              
                MyLog(@"准备刷新滚动图片running on %d", __LINE__);
                [csView reloadData];
            }
             MyLog(@"$$$$$$$$$$$$$$%d",[dataArray count]);
            MyLog(@"running on %d", __LINE__);

        }
        
        else
        {
            MyLog(@"running on %d", __LINE__);
            
            MyLog(@"请查看您的网络状态");
        }
    }
}

-(void)downloadFaild:(HttpDownload *)hd
{
    MyLog(@"http下载失败，准备读取数据库内容");
    if (hd.downloadType == MINGSHENGJINGDIAN_DOWNLOAD_TYPE) {
        MingShengJingDidanItem * item = [[MingShengJingDidanItem alloc]init];
        PagecontrollerImageItem * pageCtrollerImageItem = [[PagecontrollerImageItem alloc] init];
        //从指定表读指定数据
        MyLog(@"传过去的sid%@",sid);
        NSArray * array = [[Database sharedDatabase] selectFrom:@"mingshengjingdian" withKey:sid andwithItemType:item];
        NSLog(@"名胜风景的数组=%d",[array count]);
        MingShengJingDidanItem * it = [array objectAtIndex:0];
        NSLog(@"%@",it.pic_url);
        
        NSArray * imageArray = [[Database sharedDatabase] selectFrom:[NSString stringWithFormat:@"A%@",sid] readItem:0 count:10 withItemType:pageCtrollerImageItem];

        if (0 == [array count] ) {
            MyLog(@"Views数据库第一次建立，数据还未存储");
            return;
        }
        if (array == nil) {
            MyLog(@"数组是空");
        }

        else{
            //[dataArray removeAllObjects];
            //[dataArray addObjectsFromArray:array];
            dataArray  = [[NSMutableArray alloc] initWithArray:array];
            [pageControllImageArray removeAllObjects];
            [pageControllImageArray addObjectsFromArray:imageArray];
            MyLog(@"~~~~~~~~dataArray数量%d",[dataArray count]);
            MyLog(@"~~~~~~~pagecontrolArray数量%d",[dataArray count]);
 
            //通知主线程刷新界面
           // [self reloadShowView];
            [self performSelectorOnMainThread:@selector(reloadShowView) withObject:nil waitUntilDone:NO];

            [csView reloadData];
        }
    }
    MyLog(@"running on %d", __LINE__);
   
}

-(void)reloadShowView
{
    [self makeView];
    [csView reloadData];
    [mActivityIndicator stopAnimating];
}


-(void)loadData
{
    //新线程一定要创建自已的自动释放池
    @autoreleasepool {
        MingShengJingDidanItem * item = [[MingShengJingDidanItem alloc]init];
        PagecontrollerImageItem * pageCtrollerImageItem = [[PagecontrollerImageItem alloc] init];
        //从指定表读指定数据
        MyLog(@"传过去的sid%@",sid);
        NSArray * array = [[Database sharedDatabase] selectFrom:@"mingshengjingdian" withKey:sid andwithItemType:item];
        NSLog(@"名胜风景的数组=%d",[array count]);
        if (0 == [array count]) {
            MyLog(@"景点接口失效，且数据库中也无此景点数据——————-");
            return;
        }
        MingShengJingDidanItem * it = [array objectAtIndex:0];
        NSLog(@"名胜风景表中的图片%@",it.pic_url);
        
        NSArray * imageArray = [[Database sharedDatabase] selectFrom:[NSString stringWithFormat:@"A%@",sid] readItem:0 count:10 withItemType:pageCtrollerImageItem];
        
        if (0 == [array count] ) {
            MyLog(@"Views数据库第一次建立，数据还未存储");
            return;
        }
        if (array == nil) {
            MyLog(@"数组是空");
        }
        
        else{
            //[dataArray removeAllObjects];
            //[dataArray addObjectsFromArray:array];
            dataArray  = [[NSMutableArray alloc] initWithArray:array];
            [pageControllImageArray removeAllObjects];
            [pageControllImageArray addObjectsFromArray:imageArray];
            MyLog(@"~~~~~~~~dataArray数量%d",[dataArray count]);
            MyLog(@"~~~~~~~pagecontrolArray数量%d",[dataArray count]);
            
            //通知主线程刷新界面
            // [self reloadShowView];
            [self performSelectorOnMainThread:@selector(reloadShowView) withObject:nil waitUntilDone:NO];
            
           // [csView reloadData];
        }
        
    }
}


    
    

    



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
