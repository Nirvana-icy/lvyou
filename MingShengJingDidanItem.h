//
//  MingShengJingDidanItem.h
//  百度旅游
//
//  Created by Lucky on 13-4-5.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MingShengJingDidanItem : NSObject

/*CREATE TABLE mingshengjingdian (
 serial integer  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,
 sid TEXT(1024) DEFAULT NULL,
 sname TEXT(1024) DEFAULT NULL,
 scene_layer TEXT(1024) DEFAULT NULL,
 parent_sid TEXT(1024) DEFAULT NULL,
 is_china TEXT(1024) DEFAULT NULL,
 x TEXT(1024) DEFAULT NULL,
 y TEXT(1024) DEFAULT NULL,
 pic_url TEXT(1024) DEFAULT NULL,
 level TEXT(1024) DEFAULT NULL,
 is_newest TEXT(1024) DEFAULT NULL,
 package_exist TEXT(1024) DEFAULT NULL,
 package_url TEXT(1024) DEFAULT NULL,
 package_size TEXT(1024) DEFAULT NULL,
 aid TEXT(1024) DEFAULT NULL,
 pics_count TEXT(1024) DEFAULT NULL)*/

@property (nonatomic,retain) NSString * sid;
@property (nonatomic,retain) NSString * sname;
@property (nonatomic,retain) NSString * scene_layer;
@property (nonatomic,retain) NSString * parent_sid;
@property (nonatomic,retain) NSString * is_china;
@property (nonatomic,retain) NSString * x;
@property (nonatomic,retain) NSString * y;
@property (nonatomic,retain) NSString * pic_url;
@property (nonatomic,retain) NSString * level;
@property (nonatomic,retain) NSString * is_newest;
@property (nonatomic,retain) NSString * package_exist;
@property (nonatomic,retain) NSString * package_url;
@property (nonatomic,retain) NSString * package_size;
@property (nonatomic,retain) NSString * aid;
@property (nonatomic,retain) NSString * pics_count;
@property (nonatomic,retain) NSString * tag_list;

@end
