//
//  TourismStrategy.m
//  百度旅游
//
//  Created by Lucky on 13-3-23.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "TourismStrategy.h"
#import "AKSegmentedControl.h"
#import "MySearchBar.h"
#import "TourismSearch.h"
#import "TourismItem.h"
#import "UIImageView+WebCache.h"
#import "TourismLocationItem.h"
#import "Translucence.h"
#import "Database.h"
#import "ChinaProvinceView.h"
#import "AppDelegate.h"
#import "LeveyTabBarController.h"
#import "CONST.h"
#import "ShowView.h"
#import "MingShengJingDidanItem.h"


#define MyDEBUG 0
#if MyDEBUG
#define MyLog(a...) NSLog(a)
#else
#define MyLog(a...)
#endif

@interface TourismStrategy ()

@end

@implementation TourismStrategy

@synthesize mSegment = _mSegment;
@synthesize mSearchBar = _mSearchBar;
@synthesize mSearchDisplayCtrl = _mSearchDisplayCtrl,arrayData = _arrayData,arrayResultData = _arrayResultData;
@synthesize searchButton = _searchButton;
@synthesize mScrollView = _mScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)startDownload:(NSString *)urlStr downloadType:(NSInteger)type
{
    //   NSInteger rowCount = [[Database sharedDatabase] itemCount];
    
    //数据下载——————————————————————————————————————————————
    mhttpdownload = [[HttpDownload alloc] init];
    mhttpdownload.delegate = self;
    mhttpdownload.downloadType = type;
    [mhttpdownload downloadFromUrl:urlStr];
    
    //手势
    tapOne = [[UITapGestureRecognizer alloc] init];
    tapOne.numberOfTapsRequired = 1;
    [tapOne addTarget:self action:@selector(tapOnce:)];
    
}



-(void)buttonCreat
{
    //创建主画面
    _mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, 320, 322)];
    _mScrollView.contentSize = CGSizeMake(320, 450);
    _mScrollView.pagingEnabled = NO;
    _mScrollView .tag = 130;
    //一定要设置代理！！！！！！！！！！！！！！！!————————————————————————————————————————————————————
    _mScrollView.delegate = self;
    //view布局
    
    UITapGestureRecognizer * tapOne1 = [[UITapGestureRecognizer alloc] init];
    tapOne1.numberOfTapsRequired = 1;
    [tapOne1 addTarget:self action:@selector(tapOnce:)];
    
    imageViewA1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 115, 161)];
    imageViewA1.tag = 1000;
    [imageViewA1 addGestureRecognizer:tapOne1];
    imageViewA1.userInteractionEnabled = YES;
    [_mScrollView addSubview:imageViewA1];
    
    UITapGestureRecognizer * tapOne2 = [[UITapGestureRecognizer alloc] init];
    tapOne2.numberOfTapsRequired = 1;
    [tapOne2 addTarget:self action:@selector(tapOnce:)];
    imageViewA2 = [[UIImageView alloc] initWithFrame:CGRectMake(131, 20, 86, 76)];
    imageViewA2.userInteractionEnabled = YES;
    imageViewA2.tag = 1001;
    [imageViewA2 addGestureRecognizer:tapOne2];
    [_mScrollView addSubview:imageViewA2];
    
    
    UITapGestureRecognizer * tapOne3 = [[UITapGestureRecognizer alloc] init];
    tapOne3.numberOfTapsRequired = 1;
    [tapOne3 addTarget:self action:@selector(tapOnce:)];
    imageViewA3 = [[UIImageView alloc] initWithFrame:CGRectMake(223, 20, 86, 76)];
    imageViewA3.tag = 1002;
    [imageViewA3 addGestureRecognizer:tapOne3];
    imageViewA3.userInteractionEnabled = YES;
    [_mScrollView addSubview:imageViewA3];
    
    
    UITapGestureRecognizer * tapOne4 = [[UITapGestureRecognizer alloc] init];
    tapOne4.numberOfTapsRequired = 1;
    [tapOne4 addTarget:self action:@selector(tapOnce:)];
    imageViewA4 = [[UIImageView alloc] initWithFrame:CGRectMake(131, 105, 86, 76)];
    imageViewA4.tag = 1003;
    [imageViewA4 addGestureRecognizer:tapOne4];
    imageViewA4.userInteractionEnabled = YES;
    [_mScrollView addSubview:imageViewA4];
    
    
    UITapGestureRecognizer * tapOne5 = [[UITapGestureRecognizer alloc] init];
    tapOne5.numberOfTapsRequired = 1;
    [tapOne5 addTarget:self action:@selector(tapOnce:)];
    imageViewA5 = [[UIImageView alloc] initWithFrame:CGRectMake(223, 105, 86, 76)];
    imageViewA5.userInteractionEnabled = YES;
    imageViewA5.tag = 1004;
    [imageViewA5 addGestureRecognizer:tapOne];
//    [imageViewA5 setBackgroundColor:[UIColor blueColor]];
    [imageViewA5 setBackgroundColor:[UIColor colorWithRed:70/255 green:192/255 blue:255/255 alpha:1.0]];
    UIImageView * vcA5 = [[UIImageView alloc]initWithFrame:CGRectMake(60, 30, 20, 20)];
    [vcA5 setImage:[UIImage imageNamed:@"image_cell_access_button"]];
    [imageViewA5 addSubview:vcA5];
    [vcA5 release];
    labelA5 = [[UILabel alloc]initWithFrame:CGRectMake(27, 20, 40, 40)];
    labelA5.text = @"国内全部";
    labelA5.font = [UIFont systemFontOfSize:14];
    labelA5.textColor = [UIColor whiteColor];
    labelA5.backgroundColor = [UIColor clearColor];
    labelA5.numberOfLines = 2;
    [imageViewA5 addSubview:labelA5];
    
    
    
    [_mScrollView addSubview:imageViewA5];
    
    
    UITapGestureRecognizer * tapOne6 = [[UITapGestureRecognizer alloc] init];
    tapOne6.numberOfTapsRequired = 1;
    [tapOne6 addTarget:self action:@selector(tapOnce:)];
    imageViewB1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 188, 115, 161)];
    imageViewB1.tag = 1005;
    [imageViewB1 addGestureRecognizer:tapOne6];
    imageViewB1.userInteractionEnabled = YES;
    [_mScrollView addSubview:imageViewB1];
    
    UITapGestureRecognizer * tapOne7 = [[UITapGestureRecognizer alloc] init];
    tapOne7.numberOfTapsRequired = 1;
    [tapOne7 addTarget:self action:@selector(tapOnce:)];
    imageViewB2 = [[UIImageView alloc] initWithFrame:CGRectMake(131, 188, 86, 76)];
    imageViewB2.tag = 1006;
    [imageViewB2 addGestureRecognizer:tapOne7];
    imageViewB2.userInteractionEnabled = YES;
    
    [_mScrollView addSubview:imageViewB2];
    
    UITapGestureRecognizer * tapOne8 = [[UITapGestureRecognizer alloc] init];
    tapOne8.numberOfTapsRequired = 1;
    [tapOne8 addTarget:self action:@selector(tapOnce:)];
    imageViewB3 = [[UIImageView alloc] initWithFrame:CGRectMake(223, 188, 86, 76)];
    imageViewB3.tag = 1007;
    [imageViewB3 addGestureRecognizer:tapOne8];
    imageViewB3.userInteractionEnabled = YES;
    [_mScrollView addSubview:imageViewB3];
    
    
    UITapGestureRecognizer * tapOne9 = [[UITapGestureRecognizer alloc] init];
    tapOne9.numberOfTapsRequired = 1;
    [tapOne9 addTarget:self action:@selector(tapOnce:)];
    imageViewB4 = [[UIImageView alloc] initWithFrame:CGRectMake(131, 273, 86, 76)];
    imageViewB4.tag = 1008;
    [imageViewB4 addGestureRecognizer:tapOne9];
    imageViewB4.userInteractionEnabled = YES;
    [_mScrollView addSubview:imageViewB4];
    
    UITapGestureRecognizer * tapOne10 = [[UITapGestureRecognizer alloc] init];
    tapOne10.numberOfTapsRequired = 1;
    [tapOne10 addTarget:self action:@selector(tapOnce:)];
    imageViewB5 = [[UIImageView alloc] initWithFrame:CGRectMake(223, 273, 86, 76)];
    imageViewB5.tag = 1009;
    [imageViewB5 addGestureRecognizer:tapOne10];
    imageViewB5.userInteractionEnabled = YES;
    [imageViewB5 setBackgroundColor:[UIColor blueColor]];
    //字样图片
    UIImageView * vcB5 = [[UIImageView alloc]initWithFrame:CGRectMake(60, 30, 20, 20)];
    [vcB5 setImage:[UIImage imageNamed:@"image_cell_access_button"]];
    [imageViewB5 addSubview:vcB5];
    [vcB5 release];
    labelB5 = [[UILabel alloc]initWithFrame:CGRectMake(27, 20, 40, 40)];
    labelB5.text = @"国外全部";
    labelB5.font = [UIFont systemFontOfSize:14];
    labelB5.textColor = [UIColor whiteColor];
    labelB5.backgroundColor = [UIColor clearColor];
    labelB5.numberOfLines = 2;
    [imageViewB5 addSubview:labelB5];
    [_mScrollView addSubview:imageViewB5];
    
    
    imageViewC1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 358, 86, 76)];
    imageViewC1.backgroundColor = [UIColor blueColor];
    UILabel * labelC1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 18, 40, 40)];
    labelC1.text = @"最近浏览";
    labelC1.font = [UIFont systemFontOfSize:14];
    labelC1.textColor = [UIColor whiteColor];
    labelC1.backgroundColor = [UIColor clearColor];
    labelC1.numberOfLines = 2;
    [imageViewC1 addSubview:labelC1];
    [labelC1 release];
    [_mScrollView addSubview:imageViewC1];
    
    viewC2 = [[UIView alloc] initWithFrame:CGRectMake(107, 358, 98, 35)];
    viewC2.backgroundColor = [UIColor whiteColor];
    UILabel * lableC2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 58, 25)];
    lableC2.text = @"巴厘岛";
    lableC2.font = [UIFont systemFontOfSize:13];
    lableC2.textAlignment = NSTextAlignmentCenter;
    [viewC2 addSubview:lableC2];
    [_mScrollView addSubview:viewC2];
    
    
    viewC3 = [[UIView alloc] initWithFrame:CGRectMake(211, 358, 98, 35)];
    viewC3.backgroundColor = [UIColor whiteColor];
    UILabel * lableC3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 58, 25)];
    lableC3.text = @"土耳其";
    lableC3.font = [UIFont systemFontOfSize:13];
    lableC3.textAlignment = NSTextAlignmentCenter;
    [viewC3 addSubview:lableC3];
    [_mScrollView addSubview:viewC3];
    
    viewC4 = [[UIView alloc] initWithFrame:CGRectMake(107, 399, 98, 35)];
    viewC4.backgroundColor = [UIColor whiteColor];
    UILabel * lableC4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 58, 25)];
    lableC4.text = @"尼泊尔";
    lableC4.font = [UIFont systemFontOfSize:13];
    lableC4.textAlignment = NSTextAlignmentCenter;
    [viewC4 addSubview:lableC4];
    [_mScrollView addSubview:viewC4];
    
    viewC5 = [[UIView alloc] initWithFrame:CGRectMake(211, 399, 98, 35)];
    viewC5.backgroundColor = [UIColor whiteColor];
    UILabel * lableC5 = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 58, 25)];
    lableC5.text = @"西塘";
    lableC5.font = [UIFont systemFontOfSize:13];
    lableC5.textAlignment = NSTextAlignmentCenter;
    [viewC5 addSubview:lableC5];
    
    [_mScrollView addSubview:viewC5];
    
    //原北京页面遮罩层
//    tsA1.backgroundColor = [UIColor blackColor];
//    tsA1.frame = CGRectMake(0, imageViewA1.frame.size.height-22, imageViewA1.frame.size.width , 22);
//    tsA1.alpha =0.3;
//    tsA1.textColor = [UIColor whiteColor];
//    tsA1.font = [UIFont systemFontOfSize:14];
//    [imageViewA1 addSubview:tsA1];
    
    NSArray * viewsArray = [[NSArray arrayWithObjects:imageViewA2,imageViewA3,imageViewA4,imageViewB1,imageViewB2,imageViewB3,imageViewB4,nil] retain];
    //原首页画面遮罩层
//    int i = 0;
//    for(UIImageView * object in viewsArray)
//    {
//        
//        UILabel * label =[labelsArray objectAtIndex:i];
//        label = [[UILabel alloc] initWithFrame: CGRectMake(0, object.frame.size.height-22, object.frame.size.width , 22)];
//        label.backgroundColor = [UIColor blackColor];
//        label.alpha = 0.3;
//        label.textColor = [UIColor whiteColor];
//        MyLog(@"!!!!!!!!!!%d",[dataArray count]);
//        [object addSubview:label];
//        [label release];
//        
//        i++;
//    }
    
    [viewsArray release];
    
    [self.view addSubview: _mScrollView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //创建searchbutton
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchButton.backgroundColor = [UIColor whiteColor];
    _searchButton.frame = CGRectMake(10, 10, 300, 30);
    [_searchButton setImage:[UIImage imageNamed:@"image_search_button"] forState:UIControlStateNormal];
    [_searchButton setTitle:@"请输入目的地，景点                                              " forState:UIControlStateNormal];
    _searchButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _searchButton.titleLabel.textColor = [UIColor grayColor];
    [_searchButton addTarget:self action:@selector(pressSearchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_searchButton];
    
    CGRect  frame = CGRectMake(0, 416, 320, 49);
    [ShardApp leveyTabBarController].tabBar.frame = frame;
    [ShardApp leveyTabBarController].tabBar.hidden = NO;
    
}

-(void)tapOnce:(UIGestureRecognizer *)gesture
{
    // UIImageView * iv = (UIImageView *)gesture.view;
//    if (gesture.view!=nil && gesture.view.tag == 1000) {
//        NSString * str = [NSString stringWithFormat:@"http://www.baidu.com"];
//        NSURL * url = [NSURL URLWithString:str];
//        [[UIApplication sharedApplication] openURL:url];
//        MyLog(@"aaa");
//        
//    }
    if (gesture.view != nil && gesture.view.tag == 1000) {
        ShowView * sv = [[ShowView alloc] init];
        TourismLocationItem * item = [locationArray objectAtIndex:0];
        sv.sid = item.sid;
        sv.titleString = item.sname;
        [self.navigationController pushViewController:sv animated:YES];
        [sv release];
    }
    if (gesture.view != nil && gesture.view.tag == 1004) {
        ChinaProvinceView * cp =[[ChinaProvinceView alloc] init];
        [self.navigationController pushViewController:cp animated:YES];
    }
    if (gesture.view != nil && gesture.view.tag == 1001) {
        ShowView * sv = [[ShowView alloc] init];
        TourismItem * item = [dataArray objectAtIndex:0];
        sv.sid = item.sid;
        sv.titleString = item.sname;
        for (TourismItem * item in dataArray) {
            MyLog(@"@@@%@",item.sname);
        }
        [self.navigationController pushViewController:sv animated:YES];
        [sv release];
    }
    if (gesture.view != nil && gesture.view.tag == 1002) {
        ShowView * sv = [[ShowView alloc] init];
        TourismItem * item = [dataArray objectAtIndex:1];
        sv.sid = item.sid;
        sv.titleString = item.sname;
        [self.navigationController pushViewController:sv animated:YES];
        [sv release];
    }
    if (gesture.view != nil && gesture.view.tag == 1003) {
        ShowView * sv = [[ShowView alloc] init];
        TourismItem * item = [dataArray objectAtIndex:2];
        sv.sid = item.sid;
        
        [self.navigationController pushViewController:sv animated:YES];
        sv.titleString = item.sname;
        [sv release];
    }
    if (gesture.view != nil && gesture.view.tag == 1005) {
        ShowView * sv = [[ShowView alloc] init];
        TourismItem * item = [dataArray objectAtIndex:5];
        sv.sid = item.sid;
        [self.navigationController pushViewController:sv animated:YES];
        sv.titleString = item.sname;
        [sv release];
    }
    if (gesture.view != nil && gesture.view.tag == 1006) {
        ShowView * sv = [[ShowView alloc] init];
        TourismItem * item = [dataArray objectAtIndex:6];
        sv.sid = item.sid;
        
        [self.navigationController pushViewController:sv animated:YES];
        sv.titleString = item.sname;
        [sv release];
    }
    if (gesture.view != nil && gesture.view.tag == 1007) {
        ShowView * sv = [[ShowView alloc] init];
        TourismItem * item = [dataArray objectAtIndex:7];
        sv.sid = item.sid;
        sv.titleString = item.sname;
        [self.navigationController pushViewController:sv animated:YES];
        [sv release];
    }
    if (gesture.view != nil && gesture.view.tag == 1008) {
        ShowView * sv = [[ShowView alloc] init];
        TourismItem * item = [dataArray objectAtIndex:8];
        sv.sid = item.sid;
        sv.titleString = item.sname;
        [self.navigationController pushViewController:sv animated:YES];
        [sv release];
    }
   


}



-(NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<-80) {
        //canUpdate=YES;
        MyLog(@"松开可以刷新");
    }
    else{
        MyLog(@"下拉可以刷新");
    }
    [refreshView egoRefreshScrollViewDidScroll:_mScrollView];
    UIApplication* app = [ UIApplication sharedApplication ];
    app.networkActivityIndicatorVisible = YES;

}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //告诉下拉刷新视图停止拖拽
    [refreshView egoRefreshScrollViewDidEndDragging:scrollView];
    
}
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    if (isLoading==NO) {
        isLoading=YES;
        [self startDownload:LOCATION_IMAGE_URL downloadType:LOCATION_IMAGE_TYPE];
        [self startDownload:TOURISM_FIRST_VIEW downloadType:TOURISM_FIRST_TYPE];
        
    }
}
-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    
    return isLoading;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    dataArray = [[NSMutableArray alloc] init];
    locationArray = [[NSMutableArray alloc] init];
//    labelsArray = [[NSMutableArray alloc] init];
    //设置页数
    curPage = 1;
    perPageCount = 10;
    
    tsA1 = [[UILabel alloc] init];
    tsA2 = [[UILabel alloc] init];
    tsA3 = [[UILabel alloc] init];
    tsA4 = [[UILabel alloc] init];
    tsB1 = [[UILabel alloc] init];
    tsB2 = [[UILabel alloc] init];
    tsB3 = [[UILabel alloc] init];
    tsB4 = [[UILabel alloc] init];
    labelsArray = [[NSMutableArray arrayWithObjects:tsA2,tsA3,tsA4,tsB1,tsB2,tsB3,tsB4, nil] retain];
    
    //设置页面背景——————————————————————————————————————————
    UIImage *img = [UIImage imageNamed:@"image_introbg"];
    UIColor *color = [[UIColor alloc] initWithPatternImage:img];
    self.view.backgroundColor = color;
    [color release];
    
    //生成segment————————————————————————————————————————
    _mSegment = [[[NSBundle mainBundle] loadNibNamed:@"SegmentCell" owner:self options:nil]lastObject];
    self.navigationItem.titleView = _mSegment;
    
    //数据下载——————————————————————————————————————————————
    [self startDownload:LOCATION_IMAGE_URL downloadType:LOCATION_IMAGE_TYPE];
    [self startDownload:TOURISM_FIRST_VIEW downloadType:TOURISM_FIRST_TYPE];
    
    //生成图片布局——————————————————————————————————————————
    [self buttonCreat];
    
    //下拉刷新——————————————————————————————————————————————
    refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -_mScrollView.frame.size.height, 320, _mScrollView.frame.size.height)];
    refreshView.delegate =self;
    [_mScrollView addSubview:refreshView];
    //[refreshView refreshLastUpdatedDate];
    
}

-(void)pressSearchButton:(UIButton *) scButton
{
    TourismSearch * ts = [[TourismSearch alloc]init];
    [self.navigationController pushViewController:ts animated:YES];
    [ts release];
    
    
}
-(void)reloadScrollView
{
    NSArray * viewsArray = [[NSArray arrayWithObjects:imageViewA2,imageViewA3,imageViewA4,imageViewB1,imageViewB2,imageViewB3,imageViewB4,nil] retain];
    if (dataArray != nil) {
        for (int i = 0; i<[viewsArray count]; i++) {
            UIImageView * object = [viewsArray objectAtIndex:i];
            UILabel * label = [labelsArray objectAtIndex:i];
            label.frame = CGRectMake(0, object.frame.size.height-22, object.frame.size.width , 22);
            label.backgroundColor = [UIColor blackColor];
            label.backgroundColor = [label.backgroundColor colorWithAlphaComponent:0.7];
            label.textColor = [UIColor whiteColor];
            
            TourismItem * item;
            if (i<3) {
                item = [dataArray objectAtIndex:i];
                
            }
            else if(i>=3&&i<7)
            {
                item = [dataArray objectAtIndex:i+2];
            }
            
            label.text = item.sname;
            label.font = [UIFont boldSystemFontOfSize:14];
            MyLog(@"%@",label.text);
            [object setImageWithURL:[NSURL URLWithString:item.pic_url]];
//            [label removeFromSuperview];
            [object addSubview:label];
//            [object reloadInputViews];
            
        }
    }    
}

-(void)downloadComplete:(HttpDownload *)hd
{
    
    //[dataArray removeAllObjects];
    MyLog(@"%d",[dataArray count]);
   // [locationArray removeAllObjects];
    MyLog(@"%d",[locationArray count]);
    if (hd.mData) {
        NSDictionary * dictA = [NSJSONSerialization JSONObjectWithData:hd.mData options:NSJSONReadingMutableContainers error:nil];  
        if (dictA) {
            if (TOURISM_FIRST_TYPE == hd.downloadType) {
                NSString * msgStr = [dictA objectForKey:@"msg"];
                if ([msgStr isEqualToString:@"key overdue"]) {
                    MyLog(@"AAAAAAAAAAAAAAAAA");
                    //可以加个alert—————————————***********—————————————
                    MyLog(@"————————————网址1已失效——————————————");
                    //在新线程中执行loadData方法
                    MyLog(@"%d",[dataArray count]);
                    MyLog(@"%d",[locationArray count]);
                     [self performSelectorInBackground:@selector(loadData) withObject:nil];
                    
                }
                else{
                    MyLog(@"BBBBBBBBBBBBBBB");
                    NSDictionary * dictB =[dictA objectForKey:@"data"];
                    NSArray * dictC =[dictB objectForKey:@"scene_list"];
                    for (NSDictionary * dictD in dictC) {
                        TourismItem * tsItem = [[TourismItem alloc] init];
                        tsItem.sid = [dictD objectForKey:@"sid"];
                        tsItem.sname = [dictD objectForKey:@"sname"];
                        tsItem.pic_url = [dictD objectForKey:@"pic_url"];
                        tsItem.scene_layer = [dictD objectForKey:@"scene_layer"];
                        tsItem.parent_sid = [dictD objectForKey:@"parent_sid"];
                        [dataArray  addObject:tsItem];
                        [tsItem release];
                        
                    }
                    //创建数据库，存入数据
                    [[Database sharedDatabase] insertArray:dataArray];
                    [self reloadScrollView];
                }
                MyLog(@"$$$$$$$$$$$$$$%d",[dataArray count]);                
            }
            
            else if (LOCATION_IMAGE_TYPE == hd.downloadType)
            {
                MyLog(@"running on %d", __LINE__);
                NSString * msgStr = [dictA objectForKey:@"msg"];
                if ([msgStr isEqualToString:@"key overdue"]) {
                    //可以加个alert—————————————***********—————————————
                    MyLog(@"————————————网址2已失效——————————————");
                    [self performSelectorInBackground:@selector(loadLocationData) withObject:nil];
//                    MyLog(@"%d",[dataArray count]);
//                    MyLog(@"%d",[locationArray count]);
//                    MyLog(@"running on %d", __LINE__);
                }
                else{
                    MyLog(@"running on %d", __LINE__);

                    NSDictionary * dictB =[dictA objectForKey:@"data"];
                    NSDictionary * locationDict =[dictB objectForKey:@"location"];
                    NSDictionary * addressDIct = [locationDict objectForKey:@"address"];
                    MyLog(@"running on %d", __LINE__);

                    TourismLocationItem * locationItem = [[TourismLocationItem alloc] init];
                    locationItem.sid = [locationDict objectForKey:@"sid"];
                    locationItem.sname = [locationDict objectForKey:@"sname"];
                    locationItem.pic_url = [locationDict objectForKey:@"pic_url"];
                    locationItem.top_count = [locationDict objectForKey:@"top_count"];
                    locationItem.city = [addressDIct objectForKey:@"city"];
                    locationItem.district = [addressDIct objectForKey:@"district"];
                    locationItem.province = [addressDIct objectForKey:@"province"];
                    locationItem.street = [addressDIct objectForKey:@"street"];
                    locationItem.street_number = [addressDIct objectForKey:@"street_number"];
                    MyLog(@"running on %d", __LINE__);

                    [locationArray addObject:locationItem];
                    //130401  20:46
                    [locationItem release];
                    if ( 0 != [locationArray count]) {
                        [[Database sharedDatabase] insertArray:locationArray];
                        [self reloadLocationData];
                    }
                    
                }
                
            }

        }
        
        else
        {
            MyLog(@"running on %d", __LINE__);

            MyLog(@"请查看是否已连接网络");
            isLoading = NO;
//            [refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:_mScrollView];
        }
    }
    isLoading=NO;
    [refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:_mScrollView];
    //状态栏中菊花
    UIApplication* app = [ UIApplication sharedApplication ];
    app.networkActivityIndicatorVisible = NO;
    MyLog(@"running on %d", __LINE__);
 
}

-(void)updateData
{
    MyLog(@"running on %d", __LINE__);
    [self reloadScrollView];
    //完成刷新
    isLoading=NO;
    MyLog(@"running on %d", __LINE__);

    [refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:_mScrollView];
}

-(void)downloadFaild:(HttpDownload *)hd
{
    MyLog(@"2222下载失败");
    MyLog(@"running on %d", __LINE__);

    if (hd.downloadType == TOURISM_FIRST_TYPE) {
        TourismItem * item = [[TourismItem alloc]init];
        NSArray * array = [[[Database sharedDatabase] readItem:(curPage -1)*perPageCount count:perPageCount withTable:item] retain];
        if (0 == [array count]) {
            MyLog(@"Views数据库第一次建立，数据还未存储");
            return;
        }
        else{
            [dataArray removeAllObjects];
            [dataArray addObjectsFromArray:array];
            MyLog(@"~~~~~~~~~~~~~~~~~%d",[dataArray count]);
            //子线程（工作线程）不能操作界面
            //通知主线程刷新界面
            [self updateData];
        }
    }
    if (hd.downloadType == LOCATION_IMAGE_TYPE) {
        TourismLocationItem * item = [[TourismLocationItem alloc]init];
        
        NSArray * array = [[NSArray alloc] initWithArray:[[Database sharedDatabase] readItem:(curPage -1)*perPageCount count:perPageCount withTable:item]];
        if (0 == [array count]) {
            MyLog(@"Location数据库第一次建立，数据还未建立");
            return;
            MyLog(@"running on %d", __LINE__);
            
        }
        else{
            [locationArray removeAllObjects];
            [locationArray addObjectsFromArray:array];
            MyLog(@"~~~~~~~~~~~~~~~~~%d",[locationArray count]);
            //子线程（工作线程）不能操作界面
            //通知主线程刷新界面
            [self performSelectorOnMainThread:@selector(reloadLocationData) withObject:nil waitUntilDone:NO];
        }

        
    }
    isLoading=NO;
    MyLog(@"running on %d", __LINE__);
    
    [refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:_mScrollView];

    
}
-(void)loadData
{
    //新线程一定要创建自已的自动释放池
    @autoreleasepool {
        TourismItem * item = [[TourismItem alloc]init];
        
        NSArray * array = [[NSArray alloc] initWithArray:[[Database sharedDatabase] readItem:(curPage -1)*perPageCount count:perPageCount withTable:item]];
        if (0 == [array count]) {
            MyLog(@"第一次建立，数据还未建立");
            return;
            MyLog(@"running on %d", __LINE__);

        }
        else{
            [dataArray removeAllObjects];
            [dataArray addObjectsFromArray:array];
            MyLog(@"~~~~~~~~~~~~~~~~~%d",[dataArray count]);
            //子线程（工作线程）不能操作界面
            //通知主线程刷新界面
            [self performSelectorOnMainThread:@selector(updateData) withObject:nil waitUntilDone:NO];
        }
    }
}
-(void)loadLocationData
{
    //新线程一定要创建自已的自动释放池
    @autoreleasepool {
        TourismLocationItem * item = [[TourismLocationItem alloc]init];
        
        NSArray * array = [[NSArray alloc] initWithArray:[[Database sharedDatabase] readItem:(curPage -1)*perPageCount count:perPageCount withTable:item]];
        if (0 == [array count]) {
            MyLog(@"Location数据库第一次建立，数据还未建立");
            return;
            MyLog(@"running on %d", __LINE__);
            
        }
        else{
            [locationArray removeAllObjects];
            [locationArray addObjectsFromArray:array];
            MyLog(@"~~~~~~~~~~~~~~~~~%d",[locationArray count]);
            //子线程（工作线程）不能操作界面
            //通知主线程刷新界面
            [self performSelectorOnMainThread:@selector(reloadLocationData) withObject:nil waitUntilDone:NO];
        }
    }
    isLoading=NO;
    MyLog(@"running on %d", __LINE__);
    
    [refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:_mScrollView];

}
-(void)reloadLocationData
{
    
    if (locationArray != nil) {
        TourismLocationItem * locationItem = [locationArray objectAtIndex:0];
        tsA1.frame = CGRectMake(0, imageViewA1.frame.size.height-22, imageViewA1.frame.size.width , 22);
        tsA1.text = locationItem.sname;
        tsA1.font = [UIFont boldSystemFontOfSize:14];
        tsA1.backgroundColor = [UIColor blackColor];
        tsA1.backgroundColor =[tsA1.backgroundColor colorWithAlphaComponent:0.7];
        tsA1.textColor = [UIColor whiteColor];
        
        tsA1.textColor = [UIColor whiteColor];
        MyLog(@"running on %d", __LINE__);
        
        [imageViewA1 setImageWithURL:[NSURL URLWithString:locationItem.pic_url]];
        [imageViewA1 addSubview:tsA1];
    }
    else
    {
        MyLog(@"!!!!!~~~~`是否进入Location数据");
    }
    isLoading=NO;
    MyLog(@"running on %d", __LINE__);
    
    [refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:_mScrollView];
}
-(void)viewDidDisappear:(BOOL)animated
{
    CGRect frame = CGRectMake(-320, 426, 320, 49);
    [ShardApp leveyTabBarController].tabBar.frame = frame;


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [imageViewA1 release];
    imageViewA1 = nil;
    [imageViewA2 release];
    imageViewA2 = nil;
    [imageViewA3 release];
    imageViewA3 = nil;
    [imageViewA4 release];
    imageViewA4 = nil;
    [imageViewA5 release];
    imageViewA5 = nil;
    [imageViewB1 release];
    imageViewB1 = nil;
    [imageViewB2 release];
    imageViewB2 = nil;
    [imageViewB3 release];
    imageViewB3 = nil;
    [imageViewB4 release];
    imageViewB4 = nil;
    [imageViewB5 release];
    imageViewB5 = nil;
    [imageViewC1 release];
    imageViewC1 = nil;
    [viewC2 release];
    viewC2 = nil;
    [viewC3 release];
    viewC3 = nil;
    [viewC4 release];
    viewC4 = nil;
    [labelA5 release];
    labelA5 = nil;
    [labelB5 release];
    labelB5 = nil;
    
    _mSegment = nil;
    _mSearchDisplayCtrl = nil;
    locationArray = nil;
    dataArray = nil;
    tempData = nil;
    refreshView = nil;
    taskListDict = nil;
    [super dealloc];
    
}

@end
