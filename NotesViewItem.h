//
//  NotesViewItem.h
//  百度旅游
//
//  Created by Lucky on 13-4-7.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotesViewItem : NSObject
@property (nonatomic,retain) NSString * nid;
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
@property (nonatomic,retain) NSString * user_nickname;


@end
