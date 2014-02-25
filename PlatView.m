//
//  PlatView.m
//  百度旅游
//
//  Created by Lucky on 13-3-27.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "PlatView.h"
#import "Periphery.h"
#import "MyAnnotationView.h"
#import "PeripheryJingdianItem.h"
#import "Database.h"
#import "JingdianCellFirstItem.h"
#import "PeripheryJingdianItem.h"

#define MyDEBUG 1
#if MyDEBUG
#define MyLog(a...) NSLog(a)
#else
#define MyLog(a...)
#endif

@interface PlatView ()

@end

@implementation PlatView
@synthesize receiveSid;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)creatLikeNavigationBar
{
    UIView * vc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIColor * cl = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"file_tital_bj"]];
    vc.backgroundColor = cl;
    [cl release];

    //设置右侧列表按钮————————————————————————————————————————————
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    btn.frame = CGRectMake(265, 7, 45, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"img_moresceneindex_titleButton_normal"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"img_moresceneindex_titleButton_press"] forState:UIControlStateHighlighted];
    [btn setTitle:@"列表" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn addTarget:self action:@selector(pressListButton:) forControlEvents:UIControlEventTouchUpInside];
    [vc addSubview:btn];
    //标题——————————————————————————————————————————————————————————————
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(140, 5, 40, 30)];
    titleLable.text = @"周边";
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textColor = [UIColor whiteColor];
    [vc addSubview:titleLable];
    
    [self.view addSubview:vc];
    
    //复位按钮
    UIButton * resetLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    resetLocation.frame = CGRectMake(10,380, 40, 40);
    [resetLocation setImage:[UIImage imageNamed:@"image_periphery_scenemap_mylocationbutton_normal"] forState:UIControlStateNormal];
    [resetLocation setImage:[UIImage imageNamed:@"image_periphery_scenemap_mylocationbutton_press"] forState:UIControlStateSelected];
    [resetLocation addTarget:self action:@selector(pressRestButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetLocation];
    
}
//列表按钮响应事件
-(void)pressListButton:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
//复位按钮响应事件
-(void)pressRestButton:(UIButton *)button
{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSString * tableName = [NSString stringWithFormat:@"jingdian%@",receiveSid];
    PeripheryJingdianItem * jingdianItem = [[PeripheryJingdianItem alloc] init];
    NSArray * array = [[Database sharedDatabase] selectFrom:tableName readItem:0 count:20 withItemType:jingdianItem];
    MyLog(@"%d",[array count]);
    mdataArray = [[NSMutableArray alloc] initWithArray:array];
    MyLog(@"!!!%d",[mdataArray count]);
    
    
    
    
    
    NSLog(@"是否接收到sid%@",receiveSid);
    mMapView =[[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    mMapView.delegate=self;
    //显示自已的位置
    mMapView.showsUserLocation=YES;
    
    //地图的经纬度
    //CLLocationCoordinate2D lc2d=CLLocationCoordinate2DMake(40.035139,116.311655);
    CLLocationCoordinate2D lc2d=CLLocationCoordinate2DMake(40.04,116.35);
    //设置地图的缩放比例
    MKCoordinateSpan span=MKCoordinateSpanMake(0.1, 0.1);
    
    MKCoordinateRegion region=MKCoordinateRegionMake(lc2d, span);
    [mMapView setRegion:region];
    [self.view addSubview:mMapView];
    [self creatLikeNavigationBar];
//        for (int i=0; i<10; i++) {
//            NSString *title=[NSString stringWithFormat:@"标题%d",i+1];
//            NSString *subtitle=[NSString stringWithFormat:@"副标题%d",i+1];
//            CLLocationCoordinate2D lc2d=CLLocationCoordinate2DMake(40.035139+0.01*i,116.311655+0.01*i);
//    
//            MyAnnotationView *view=[[MyAnnotationView alloc] init:lc2d title:title subTitle:subtitle];
//    
//            [mMapView addAnnotation:view];
//        }
    for (int i = 0; i<[mdataArray count]; i++) {
        PeripheryJingdianItem * item = [mdataArray objectAtIndex:i];
        NSString * title = item.sname;
        NSString * subtitle = [NSString stringWithFormat:@"距离现在位置：%@米",item.distance];
        CLLocationCoordinate2D lc2d = CLLocationCoordinate2DMake([item.map_y floatValue], [item.map_x floatValue]);
        MyLog(@"%@",item.map_x);
        MyAnnotationView * view = [[MyAnnotationView alloc] init:lc2d title:title subTitle:subtitle];
        [mMapView addAnnotation:view];
    }
    
    
            MyAnnotationView *view=[[MyAnnotationView alloc] init:lc2d title:@"我的位置" subTitle:@"北京"];
            [mMapView addAnnotation:view];
    
    UILongPressGestureRecognizer *recognizer=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [mMapView addGestureRecognizer:recognizer];
    
    //kCLLocationAccuracyBestForNavigation 隔多久更新一次，location,系统提供了枚举，有几个
    locationManager=[[CLLocationManager alloc] init];
    locationManager.distanceFilter=kCLLocationAccuracyBestForNavigation;

    
    
}
//05.23------------------------------
//- (void)startedReverseGeoderWithLatitude:(double)latitude longitude:(double)longitude{
//    CLLocationCoordinate2D coordinate2D;
//    coordinate2D.longitude = longitude;
//    coordinate2D.latitude = latitude;
//    
//    MKReverseGeocoder *geoCoder = [[MKReverseGeocoder alloc] initWithCoordinate:coordinate2D];
//    geoCoder.delegate = self;
//    [geoCoder start];
//}
//#pragma mark -
//- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
//{
//    //NSString *subthroung=placemark.subThoroughfare;
//    NSString *local=placemark.locality;
//    //NSLog(@"城市名:%@-%@-%@",placemark.locality,local,subthroung);
//    if (local) {
//        [cityLabel setText:local];
//    }
//}
//
//
//- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
//{
//    
//}


//------------------------------------
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
}
-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    //如果是用户的当前位置
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    MKPinAnnotationView *view=(MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"AnnotationName"];
    if (!view) {
        view=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationName"];
        view.canShowCallout=YES;
        UIView *leftview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        leftview.backgroundColor=[UIColor greenColor];
        view.leftCalloutAccessoryView=[leftview autorelease];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        view.rightCalloutAccessoryView=button;
    }
    return view;
}
-(void)longPress:(UIGestureRecognizer*)reconizer
{
    
    //如何不写判断，长按出第一个标记后，拖动鼠标会产生很多标记
    if ([reconizer state]==UIGestureRecognizerStateBegan)
    {
        //获得手势发生的位置（相对于地图）
        CGPoint point=[reconizer locationInView:mMapView];
        //将当前屏幕坐标点转换成地图坐标
        CLLocationCoordinate2D lc2d=[mMapView convertPoint:point toCoordinateFromView:mMapView];
        MyAnnotationView *view=[[MyAnnotationView alloc] init:lc2d title:@"测试" subTitle:@"测试2"];
        [mMapView addAnnotation:view];
        [view release];
        
        
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
