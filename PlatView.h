//
//  PlatView.h
//  百度旅游
//
//  Created by Lucky on 13-3-27.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface PlatView : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
    UIButton * btn;
    //地图视图
    MKMapView *mMapView;
    //位置服务管理类
    CLLocationManager *locationManager;
    NSString * receiveSid;
    NSMutableArray * mdataArray;
}
@property (nonatomic,retain) NSString * receiveSid;
@end
