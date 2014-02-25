//
//  Database.h
//  XmlDemo
//
//  Created by mac on 13-3-6.
//  Copyright (c) 2013年 dhf. All rights reserved.
//

#import <Foundation/Foundation.h>
//引入第三方库头文件
#import "FMDatabase.h"
@class TourismItem;
@interface Database : NSObject
{
    
    //第三方数据库操作类
    FMDatabase * mDb ;

}

//获得指定名称的文件的全路径
+(NSString *) filePath:(NSString *)fileName;

//获得当前类的实例
+(Database *)sharedDatabase;


-(id)init;

//插一个item
//-(void)insertItem:(TourismItem *)item withType:(NSString *)table;
-(void)insertItem:(id)item;
//插多个item
//-(void)insertArray:(NSArray*)array withType:(NSString *)table;
-(void)insertArray:(id)array ;

//向指定表中插入一个Item
-(void)insertItem:(id)item intable:(NSString *)tableName;

//向指定表中插入多个Item
-(void)insertArray:(id)array intable:(NSString *)tableName;

//读取从start条记录开始的count条记录
-(NSArray *) readItem:(NSInteger)start count:(NSInteger)count withTable:(id)item;

//查询当前有多少条记录
-(NSInteger)lookupItemCount:(id)item;

//创建新的表
-(void)creatTable:(NSString *)sqlStr;

//创建新的表，可判断不同类型
-(void)buildTable:(NSString *)sqlStr withTableType:(id)item;

//从指定表中读取指定内容
-(NSArray *)selectFrom:(NSString *)tableName withKey:(NSString *)keyStr andwithItemType:(id)item;

//从指定表读取多少条数据
-(NSArray *)selectFrom:(NSString *)tableName readItem:(NSInteger)start count:(NSInteger)count withItemType:(id)item;

@end
