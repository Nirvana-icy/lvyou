//
//  Scene.h
//  百度旅游
//
//  Created by Lucky on 13-4-7.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Scene : NSObject
@property (nonatomic,retain) NSString * sid;
@property (nonatomic,retain) NSString * sname;
@property (nonatomic,retain) NSString * scene_layer;
@property (nonatomic,retain) NSString * parent_sid;
@property (nonatomic,retain) NSString * going_count;
@property (nonatomic,retain) NSString * gone_count;
@property (nonatomic,retain) NSString * pic_url;
@property (nonatomic,retain) NSString * distance;
@property (nonatomic,retain) NSString * map_x;
@property (nonatomic,retain) NSString * map_y;
@property (nonatomic,retain) NSString * abstract;
@property (nonatomic,retain) NSString * desc;

@end
