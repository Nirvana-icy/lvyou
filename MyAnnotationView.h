//
//  MyAnnotationView.h
//  GoogleMapDemo
//
//  Created by DuHaiFeng on 13-3-11.
//  Copyright (c) 2013年 dhf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MyAnnotationView : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D lc2d;
    NSString *title;
    NSString *subTitle;
}
-(id)init:(CLLocationCoordinate2D)newLocation title:(NSString*)newTitle subTitle:(NSString*)newSubTitle;







@end
