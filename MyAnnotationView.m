//
//  MyAnnotationView.m
//  GoogleMapDemo
//
//  Created by DuHaiFeng on 13-3-11.
//  Copyright (c) 2013年 dhf. All rights reserved.
//

#import "MyAnnotationView.h"

@implementation MyAnnotationView

-(id)init:(CLLocationCoordinate2D)newLocation title:(NSString *)newTitle subTitle:(NSString *)newSubTitle
{
    if (self=[super init]) {
        title=[newTitle copy];
        subTitle=[newSubTitle copy];
        lc2d=newLocation;
    }
    return self;
}

//下面的函数有什么用
-(NSString*)title
{
    return title;
}
-(NSString*)subtitle
{
    return subTitle;
}
-(CLLocationCoordinate2D)coordinate
{
    return lc2d;
}
@end
