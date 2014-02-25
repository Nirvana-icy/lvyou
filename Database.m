//
//  Database.m
//  XmlDemo
//
//  Created by mac on 13-3-6.
//  Copyright (c) 2013年 dhf. All rights reserved.
//

#import "Database.h"
#import "TourismItem.h"
#import "TourismLocationItem.h"
#import "CONST.h"
#import "MingShengJingDidanItem.h"
#import "PagecontrollerImageItem.h"
#import "SceneItem.h"
#import "DiningItem.h"
#import "TrafficRemoteItem.h"
#import "NotesView.h"
#import "NotesViewItem.h"
#import "ShoppingSpecialItem.h"
#import "LineItem.h"
#import "PeripheryCanyinItem.h"
#import "PeripheryJingdianItem.h"
#import "PeripheryJiudianItem.h"
#import "PeripheryXiuxianItem.h"
#import "JingdianCellFirstItem.h"
#import "JingdianCellImageItem.h"

//数据库是个功能类，没必要谁用谁实例化一个，只要初始化一个就行，大家都访问这个，公共资源，接口只有一个，我们叫单例
static Database * gl_database=nil;


@implementation Database


+(Database * )sharedDatabase
{
    if (!gl_database) {
        gl_database = [[Database alloc] init];
    }
    
    return gl_database;
}

+(NSString *)filePath:(NSString *)fileName
{
    //获取当前应用程序所在目录
    NSString * rootPath = NSHomeDirectory();
    rootPath = [rootPath stringByAppendingPathComponent:@"Library/Caches"];
    if (fileName&&[fileName length]!=0) {
        rootPath = [rootPath stringByAppendingPathComponent:fileName];
    }
    NSFileManager * fm  = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:rootPath]) {
        NSLog(@"指定文件不存在：%@",rootPath);
    }
    return rootPath;
}
-(void)creatTable:(NSString *)sqlStr
{
    if ([mDb executeUpdate:sqlStr]) {
        
    }
    else
    {
        NSLog(@"创建攻略首页面表失败");
        
    }

    

}
-(void)buildTable:(NSString *)sqlStr withTableType:(id)item
{
    //scene
    if ([item isKindOfClass:[SceneItem class]]) {
        if ([mDb executeUpdate:sqlStr]) {
            NSLog(@"创建八按钮---scene成功");
        }
        else
        {
            NSLog(@"%@-类型表创建失败",[item class]);
            
        }

    }
        //dining
    if ([item isKindOfClass:[DiningItem class]])
    {
        if ([mDb executeUpdate:sqlStr])
        {
            NSLog(@"创建八按钮---dining成功");
        }
        else
        {
            NSLog(@"%@-类型表创建失败",[item class]);     
        }     
    }
    //traffic
    if ([item isKindOfClass:[TrafficRemoteItem class]])
    {
        if ([mDb executeUpdate:sqlStr])
        {
            NSLog(@"创建八按钮---trafficRemote成功");
        }
        else
        {
            NSLog(@"%@-类型表创建失败",[item class]);
        }
    }
    //notes
    if ([item isKindOfClass:[NotesViewItem class]])
    {
        if ([mDb executeUpdate:sqlStr])
        {
            NSLog(@"创建八按钮---notesview成功");
        }
        else
        {
            NSLog(@"%@-类型表创建失败",[item class]);
        }
    }
    //shopping
    if ([item isKindOfClass:[ShoppingSpecialItem class]])
    {
        if ([mDb executeUpdate:sqlStr])
        {
            NSLog(@"创建八按钮---shopping成功");
        }
        else
        {
            NSLog(@"%@-类型表创建失败",[item class]);
        }
    }
    //line
    if ([item isKindOfClass:[LineItem class]])
    {
        if ([mDb executeUpdate:sqlStr])
        {
            NSLog(@"创建八按钮---line成功");
        }
        else
        {
            NSLog(@"%@-类型表创建失败",[item class]);
        }
    }
    //periphery --- jingdian
    if ([item isKindOfClass:[PeripheryJingdianItem class]])
    {
        if ([mDb executeUpdate:sqlStr])
        {
            NSLog(@"创建jingdian表成功");
        }
        else
        {
            NSLog(@"%@-类型表创建失败",[item class]);
        }
    }
    //periphery --- canyin
    if ([item isKindOfClass:[PeripheryCanyinItem class]])
    {
        if ([mDb executeUpdate:sqlStr])
        {
            NSLog(@"创建canyin表成功");
        }
        else
        {
            NSLog(@"%@-类型表创建失败",[item class]);
        }
    }
    //periphery --- jiudian
    if ([item isKindOfClass:[PeripheryJiudianItem class]])
    {
        if ([mDb executeUpdate:sqlStr])
        {
            NSLog(@"创建jiudian表成功");
        }
        else
        {
            NSLog(@"%@-类型表创建失败",[item class]);
        }
    }
    //periphery ---xiuxian
    if ([item isKindOfClass:[PeripheryXiuxianItem class]])
    {
        if ([mDb executeUpdate:sqlStr])
        {
            NSLog(@"创建xiuxian表成功");
        }
        else
        {
            NSLog(@"%@-类型表创建失败",[item class]);
        }
    }
    //周边--景点 ---cellArray
    if ([item isKindOfClass:[JingdianCellFirstItem class]])
    {
        if ([mDb executeUpdate:sqlStr])
        {
            NSLog(@"创建cell表成功");
        }
        else
        {
            NSLog(@"%@-类型表创建失败",[item class]);
        }
    }
    //周边--景点 ---cellImageArray
    if ([item isKindOfClass:[JingdianCellImageItem class]])
    {
        if ([mDb executeUpdate:sqlStr])
        {
            NSLog(@"创建cellimage表成功");
        }
        else
        {
            NSLog(@"%@-类型表创建失败",[item class]);
        }
    }
    
    

}


-(void)creatDatabase
{
    
    NSString * filepath = [Database filePath:@"user.db"];
    
    //实例化，retain不要忘记
    mDb = [[FMDatabase databaseWithPath:filepath] retain];
    
    //打开数据库
    if ([mDb open]) {
        //打开数据库选表，点带笔的那个，复制创建表的代码,添加IF NOT EXISTS
       // NSString * sql = @"CREATE TABLE  IF NOT EXISTS user (serial integer  PRIMARY KEY AUTOINCREMENT,uid TEXT(1024) DEFAULT NULL,username TEXT(1024) DEFAULT NULL,realname TEXT(1024),headimage TEXT(1024) DEFAULT NULL)";
        
        
        NSString * sql = @"CREATE TABLE IF NOT EXISTS FirstViewTable (serial integer  PRIMARY KEY AUTOINCREMENT,sid TEXT(1024) DEFAULT NULL,sname TEXT(1024)  DEFAULT NULL,pic_url TEXT(1024)  DEFAULT NULL,scene_layer TEXT(1024)  DEFAULT NULL,parent_sid TEXT(1024)  DEFAULT NULL)";
        
        NSString * sql2 = @"CREATE TABLE IF NOT EXISTS LocationTable (serial integer  PRIMARY KEY AUTOINCREMENT,sid TEXT(1024) DEFAULT NULL,sname TEXT(1024),pic_url TEXT(1024),top_count TEXT(1024),city TEXT(1024) DEFAULT NULL,district TEXT(1024) DEFAULT NULL,province TEXT(1024) DEFAULT NULL,street TEXT(1024) DEFAULT NULL,street_number TEXT(1024))";
        
        NSString * sql3 = @"CREATE TABLE IF NOT EXISTS mingshengjingdian (serial integer  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,sid TEXT(1024) DEFAULT NULL,sname TEXT(1024) DEFAULT NULL,scene_layer TEXT(1024) DEFAULT NULL,parent_sid TEXT(1024) DEFAULT NULL,is_china TEXT(1024) DEFAULT NULL,x TEXT(1024) DEFAULT NULL,y TEXT(1024) DEFAULT NULL,pic_url TEXT(1024) DEFAULT NULL,level TEXT(1024) DEFAULT NULL,is_newest TEXT(1024) DEFAULT NULL,package_exist TEXT(1024) DEFAULT NULL,package_url TEXT(1024) DEFAULT NULL,package_size TEXT(1024) DEFAULT NULL,aid TEXT(1024) DEFAULT NULL,pics_count TEXT(1024) DEFAULT NULL,tag_list TEXT(1024) DEFAULT NULL)";
        
        if ([mDb executeUpdate:sql]) {
            
        }
        else
        {
            NSLog(@"创建攻略首页面表失败");
        
        }
        if ([mDb executeUpdate:sql2]) {
            
        }
        else
        {
            NSLog(@"创建攻略当前位置表失败");
        }
        
        if ([mDb executeUpdate:sql3]) {
            
        }
        else
        {
            NSLog(@"创建名胜景点表失败");
        }

        
        
        
    }

}


-(BOOL)isExistItem:(id)item
{
    if ([item isKindOfClass:[TourismItem class]])
    {
        TourismItem * itm = item;
        NSString * sql = [NSString stringWithFormat:@"select sid from FirstViewTable where sid = ?"];
        FMResultSet * rs = [mDb executeQuery:sql,itm.sid];
        while ([rs next]) {
            return YES;
        }
    }
    if ([item isKindOfClass:[TourismLocationItem class]]) {
        TourismLocationItem * itmLocation = item;
        NSString * sql = [NSString stringWithFormat:@"select sid from LocationTable where sid = ?"];
        FMResultSet * rs = [mDb executeQuery:sql,itmLocation.sid];
        while ([rs next]) {
            return YES;
        }
    }
    
    if ([item isKindOfClass:[MingShengJingDidanItem class]]) {
        MingShengJingDidanItem * itmMingsheng = item;
        NSString * sql = [NSString stringWithFormat:@"select sid from mingshengjingdian where sid = ?"];
        FMResultSet * rs = [mDb executeQuery:sql,itmMingsheng.sid];
        while ([rs next]) {
            return YES;
        }
    }

    
    
    return NO;
}

-(BOOL)isExistItem:(id)item intable:(NSString *)tableName
{
    if ([item isKindOfClass:[PagecontrollerImageItem class]]) {
        PagecontrollerImageItem * pcImageitem = item;
        NSString * sql = [NSString stringWithFormat:@"select pic_url from %@ where pic_url = ?",tableName];
        FMResultSet * rs = [mDb executeQuery:sql,pcImageitem.pic_url];
        while ([rs next]) {
            return YES;
        }
    }
    //scene
    if ([item isKindOfClass:[SceneItem class]]) {
        SceneItem * sceneItem = item;
        NSString * sql = [NSString stringWithFormat:@"select sid from %@ where sid = ?",tableName];
        FMResultSet * rs = [mDb executeQuery:sql,sceneItem.sid];
        while ([rs next]) {
            return YES;
        }
    }
    //dining
    if ([item isKindOfClass:[DiningItem class]]) {
        DiningItem * diningItem = item;
        NSString * sql = [NSString stringWithFormat:@"select key from %@ where key = ?",tableName];
        FMResultSet * rs = [mDb executeQuery:sql,diningItem.key];
        while ([rs next]) {
            return YES;
        }
    }
    //traffic
    if ([item isKindOfClass:[TrafficRemoteItem class]]) {
        TrafficRemoteItem * diningItem = item;
        NSString * sql = [NSString stringWithFormat:@"select key from %@ where key = ?",tableName];
        FMResultSet * rs = [mDb executeQuery:sql,diningItem.key];
        while ([rs next]) {
            return YES;
        }
    }
    //notes
    if ([item isKindOfClass:[NotesViewItem class]]) {
        NotesViewItem * notesItem = item;
        NSString * sql = [NSString stringWithFormat:@"select nid from %@ where nid = ?",tableName];
        FMResultSet * rs = [mDb executeQuery:sql,notesItem.nid];
        while ([rs next]) {
            return YES;
        }
    }
    //shopping
    if ([item isKindOfClass:[ShoppingSpecialItem class]]) {
        ShoppingSpecialItem * shopItem = item;
        NSString * sql = [NSString stringWithFormat:@"select key from %@ where key = ?",tableName];
        FMResultSet * rs = [mDb executeQuery:sql,shopItem.key];
        while ([rs next]) {
            return YES;
        }
    }
    //line
    if ([item isKindOfClass:[LineItem class]]) {
        LineItem * lineItem = item;
        NSString * sql = [NSString stringWithFormat:@"select key from %@ where key = ?",tableName];
        FMResultSet * rs = [mDb executeQuery:sql,lineItem.key];
        while ([rs next]) {
            return YES;
        }
    }
    //————————————————periphery——————————————————————
    //景点
    if ([item isKindOfClass:[PeripheryJingdianItem class]]) {
        PeripheryJingdianItem * jingdianItem = item;
        NSString * sql = [NSString stringWithFormat:@"select sid from %@ where sid = ?",tableName];
        FMResultSet * rs = [mDb executeQuery:sql,jingdianItem.sid];
        while ([rs next]) {
            return YES;
        }
    }
    //餐饮
    if ([item isKindOfClass:[PeripheryCanyinItem class]]) {
        PeripheryCanyinItem * canyinItem = item;
        NSString * sql = [NSString stringWithFormat:@"select uid from %@ where uid = ?",tableName];
        FMResultSet * rs = [mDb executeQuery:sql,canyinItem.uid];
        while ([rs next]) {
            return YES;
        }
    }
    //酒店
    if ([item isKindOfClass:[PeripheryJiudianItem class]]) {
        PeripheryJiudianItem * canyinItem = item;
        NSString * sql = [NSString stringWithFormat:@"select uid from %@ where uid = ?",tableName];
        FMResultSet * rs = [mDb executeQuery:sql,canyinItem.uid];
        while ([rs next]) {
            return YES;
        }
    }
    //休闲
    if ([item isKindOfClass:[PeripheryXiuxianItem class]]) {
        PeripheryXiuxianItem * xiuxianItem = item;
        NSString * sql = [NSString stringWithFormat:@"select uid from %@ where uid = ?",tableName];
        FMResultSet * rs = [mDb executeQuery:sql,xiuxianItem.uid];
        while ([rs next]) {
            return YES;
        }
    }
    //cell
    if ([item isKindOfClass:[JingdianCellFirstItem class]]) {
        JingdianCellFirstItem * jdcItem = item;
        NSString * sql = [NSString stringWithFormat:@"select sid from %@ where sid = ?",tableName];
        FMResultSet * rs = [mDb executeQuery:sql,jdcItem.sid];
        while ([rs next]) {
            return YES;
        }
    }
    //cellImage
    if ([item isKindOfClass:[JingdianCellImageItem class]]) {
        JingdianCellImageItem * jciItem = item;
        NSString * sql = [NSString stringWithFormat:@"select pic_url from %@ where pic_url = ?",tableName];
        FMResultSet * rs = [mDb executeQuery:sql,jciItem.pic_url];
        while ([rs next]) {
            return YES;
        }
    }
    
    
    
    return NO;
}


-(void)insertItem:(id)item
{
    
    
    if ([self isExistItem:item]) {
        return;
    }
    if ([item isKindOfClass:[TourismItem class]]) {
        //避免有的字符串应该有符号
        TourismItem * itm = item;
        NSString * sql = [NSString stringWithFormat:@"insert into FirstViewTable(sid,sname,pic_url,scene_layer,parent_sid)  values (?,?,?,?,?)     "];
        
        //传的4个必须是对象，不能是一个类型
        if ([mDb executeUpdate:sql,itm.sid,itm.sname,itm.pic_url,itm.scene_layer,itm.parent_sid]) {
            
        }
        else
        {
            
            NSLog(@"插入攻略主页表失败:%@",[mDb lastErrorMessage]);
            
        }
    }
    if ([item isKindOfClass:[TourismLocationItem class]]) {
        TourismLocationItem * itmLocation = item;
        NSString * sql = [NSString stringWithFormat:@"insert into LocationTable(sid,sname,pic_url,top_count,city,district,province,street,street_number)  values (?,?,?,?,?,?,?,?,?)     "];
        
        //传的4个必须是对象，不能是一个类型
        if ([mDb executeUpdate:sql,itmLocation.sid,itmLocation.sname,itmLocation.pic_url,itmLocation.top_count,itmLocation.city,itmLocation.district,itmLocation.province,itmLocation.street,itmLocation.street_number]) {
            
        }
        else
        {
            
            NSLog(@"插入攻略当前位置表失败:%@",[mDb lastErrorMessage]);
            
        }

    }

    
    if ([item isKindOfClass:[MingShengJingDidanItem class]]) {
        //避免有的字符串应该有符号
        MingShengJingDidanItem * itm = item;
        NSString * sql = [NSString stringWithFormat:@"insert into mingshengjingdian(sid,sname,scene_layer,parent_sid,is_china,x,y,pic_url,level,is_newest,package_exist,package_url,package_size,aid,pics_count,tag_list)  values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)     "];
        
        //传的4个必须是对象，不能是一个类型
        if ([mDb executeUpdate:sql,itm.sid,itm.sname,itm.scene_layer,itm.parent_sid,itm.is_china,itm.x,itm.y,itm.pic_url,itm.level,itm.is_newest,itm.package_exist,itm.package_url,itm.package_size,itm.aid,itm.pics_count,itm.tag_list]) {
            
        }
        else
        {
            
            NSLog(@"插入名胜景点表失败:%@",[mDb lastErrorMessage]);
            
        }
    }

    
}
-(void)insertItem:(id)item intable:(NSString *)tableName
{
    if ([self isExistItem:item intable:tableName]) {
        return;
    }
    
    if ([item isKindOfClass:[PagecontrollerImageItem class]]) {
        //避免有的字符串应该有符号
        PagecontrollerImageItem * itm = item;
        NSString * sql = [NSString stringWithFormat:@"insert into %@(pic_url,is_cover,title,desc)  values (?,?,?,?)     ",tableName];
        
        //传的4个必须是对象，不能是一个类型
        if ([mDb executeUpdate:sql,itm.pic_url,itm.is_cover,itm.title,itm.desc]) {
            
        }
        else
        {
            NSLog(@"插入PagecontrollerImage表失败:%@",[mDb lastErrorMessage]);
        }
    }
    //八按钮scene
    if ([item isKindOfClass:[SceneItem class]]) {
        //避免有的字符串应该有符号
        SceneItem * itm = item;
        NSString * sql = [NSString stringWithFormat:@"insert into %@(sid,sname,scene_layer,parent_sid,going_count,gone_count,pic_url,distance,map_x,map_y,abstract,desc)  values (?,?,?,?,?,?,?,?,?,?,?,?)     ",tableName];
        //传的4个必须是对象，不能是一个类型
        if ([mDb executeUpdate:sql,itm.sid,itm.sname,itm.scene_layer,itm.parent_sid,itm.going_count,itm.gone_count,itm.pic_url,itm.distance,itm.map_x,itm.map_y,itm.abstract,itm.desc]) {
            NSLog(@"数据插入到scene表成功");
        }
        else
        {
            NSLog(@"插入八按钮---scene表失败:%@",[mDb lastErrorMessage]);
        }
    }
    //八按钮dining
    if ([item isKindOfClass:[DiningItem class]])
    {
        //避免有的字符串应该有符号
        DiningItem * itm = item;
        NSString * sql = [NSString stringWithFormat:@"insert into %@(key,desc,pic_url)  values (?,?,?)     ",tableName];
        //传的4个必须是对象，不能是一个类型
        if ([mDb executeUpdate:sql,itm.key,itm.desc,itm.pic_url]) {
            NSLog(@"数据插入到dining表成功");
        }
        else
        { 
            NSLog(@"插入八按钮---dining表失败:%@",[mDb lastErrorMessage]); 
        }
    }
    //八按钮traffic
    if ([item isKindOfClass:[TrafficRemoteItem class]])
    {
        //避免有的字符串应该有符号
        TrafficRemoteItem * itm = item;
        NSString * sql = [NSString stringWithFormat:@"insert into %@(key,desc,pic_url)  values (?,?,?)     ",tableName];
        //传的4个必须是对象，不能是一个类型
        if ([mDb executeUpdate:sql,itm.key,itm.desc,itm.pic_url]) {
            NSLog(@"数据插入到trafficremote表成功");
        }
        else
        {
            NSLog(@"插入八按钮---trafficremote表失败:%@",[mDb lastErrorMessage]);
        }
    }
    //八按钮notes
    if ([item isKindOfClass:[NotesViewItem class]])
    {
        //避免有的字符串应该有符号
        NotesViewItem * itm = item;
        NSString * sql = [NSString stringWithFormat:@"insert into %@(nid,title,departure,time,time_unit,start_month,start_time,is_praised,is_good,is_set_guide,pic_url,user_nickname)  values (?,?,?,?,?,?,?,?,?,?,?,?)     ",tableName];
        //传的4个必须是对象，不能是一个类型
        if ([mDb executeUpdate:sql,itm.nid,itm.title,itm.departure,itm.time,itm.time_unit,itm.start_month,itm.start_time,itm.is_praised,itm.is_good,itm.is_set_guide,itm.pic_url,itm.user_nickname]) {
            NSLog(@"数据插入到trafficremote表成功");
        }
        else
        {
            NSLog(@"插入八按钮---trafficremote表失败:%@",[mDb lastErrorMessage]);
        }
    }
    //八按钮shopping
    if ([item isKindOfClass:[ShoppingSpecialItem class]])
    {
        //避免有的字符串应该有符号
        ShoppingSpecialItem * itm = item;
        NSString * sql = [NSString stringWithFormat:@"insert into %@(key,desc,pic_url)  values (?,?,?)     ",tableName];
        //传的4个必须是对象，不能是一个类型
        if ([mDb executeUpdate:sql,itm.key,itm.desc,itm.pic_url]) {
            NSLog(@"数据插入到shopping表成功");
        }
        else
        {
            NSLog(@"插入八按钮---shopping表失败:%@",[mDb lastErrorMessage]);
        }
    }
    //八按钮line
    if ([item isKindOfClass:[LineItem class]])
    {
        //避免有的字符串应该有符号
        LineItem * itm = item;
        NSString * sql = [NSString stringWithFormat:@"insert into %@(key,keyword,desc,dinning,accordination)  values (?,?,?,?,?)     ",tableName];
        //传的4个必须是对象，不能是一个类型
        if ([mDb executeUpdate:sql,itm.key,itm.keyword,itm.desc,itm.dinning,itm.accordination]) {
            NSLog(@"数据插入到line表成功");
        }
        else
        {
            NSLog(@"插入八按钮---line表失败:%@",[mDb lastErrorMessage]);
        }
    }
    //————————————————————————————periphery——————————————————————————————————
    //景点
    if ([item isKindOfClass:[PeripheryJingdianItem class]])
    {
        //避免有的字符串应该有符号
        PeripheryJingdianItem * itm = item;
        NSString * sql = [NSString stringWithFormat:@"insert into %@(sid,sname,pic_url,distance,map_x,map_y,star,going_count)  values (?,?,?,?,?,?,?,?)     ",tableName];
        //传的4个必须是对象，不能是一个类型
        if ([mDb executeUpdate:sql,itm.sid,itm.sname,itm.pic_url,itm.distance,itm.map_x,itm.map_y,itm.star,itm.going_count]) {
            NSLog(@"数据插入到景点表成功");
        }
        else
        {
            NSLog(@"插入---景点表失败:%@",[mDb lastErrorMessage]);
        }
    }
    //餐饮
    if ([item isKindOfClass:[PeripheryCanyinItem class]])
    {
        //避免有的字符串应该有符号
        PeripheryCanyinItem * itm = item;
        NSString * sql = [NSString stringWithFormat:@"insert into %@(name,address,distance,uid,map_y,map_x,comm_num,price,star,type)  values (?,?,?,?,?,?,?,?,?,?)     ",tableName];
        //传的4个必须是对象，不能是一个类型
        if ([mDb executeUpdate:sql,itm.name,itm.address,itm.distance,itm.uid,itm.map_y,itm.map_x,itm.comm_num,itm.price,itm.star,itm.type]) {
            NSLog(@"数据插入到餐饮表成功");
        }
        else
        {
            NSLog(@"插入---餐饮表失败:%@",[mDb lastErrorMessage]);
        }
    }
    //酒店
    if ([item isKindOfClass:[PeripheryJiudianItem class]])
    {
        //避免有的字符串应该有符号
        PeripheryJiudianItem * itm = item;
        NSString * sql = [NSString stringWithFormat:@"insert into %@(name,address,distance,uid,map_y,map_x,comm_num,price,star,type)  values (?,?,?,?,?,?,?,?,?,?)     ",tableName];
        //传的4个必须是对象，不能是一个类型
        if ([mDb executeUpdate:sql,itm.name,itm.address,itm.distance,itm.uid,itm.map_y,itm.map_x,itm.comm_num,itm.price,itm.star,itm.type]) {
            NSLog(@"数据插入到酒店表成功");
        }
        else
        {
            NSLog(@"插入---酒店表失败:%@",[mDb lastErrorMessage]);
        }
    }
    //休闲
    if ([item isKindOfClass:[PeripheryXiuxianItem class]])
    {
        //避免有的字符串应该有符号
        PeripheryXiuxianItem * itm = item;
        NSString * sql = [NSString stringWithFormat:@"insert into %@(name,address,distance,uid,map_y,map_x,comm_num,price,star,type)  values (?,?,?,?,?,?,?,?,?,?)     ",tableName];
        //传的4个必须是对象，不能是一个类型
        if ([mDb executeUpdate:sql,itm.name,itm.address,itm.distance,itm.uid,itm.map_y,itm.map_x,itm.comm_num,itm.price,itm.star,itm.type]) {
            NSLog(@"数据插入到休闲表成功");
        }
        else
        {
            NSLog(@"插入---休闲表失败:%@",[mDb lastErrorMessage]);
        }
    }
    //——————————————————————————cell————————————————
    //cell
    if ([item isKindOfClass:[JingdianCellFirstItem class]])
    {
        //避免有的字符串应该有符号
        JingdianCellFirstItem * itm = item;
        NSString * sql = [NSString stringWithFormat:@"insert into %@(sid,sname,scene_layer,parent_sid,x,y,desc,opening_hours,price,address)  values (?,?,?,?,?,?,?,?,?,?)     ",tableName];
        //传的4个必须是对象，不能是一个类型
        if ([mDb executeUpdate:sql,itm.sid,itm.sname,itm.scene_layer,itm.parent_sid,itm.x,itm.y,itm.desc,itm.opening_hours,itm.price,itm.address]) {
            NSLog(@"数据插入到cell表成功");
        }
        else
        {
            NSLog(@"插入---cell表失败:%@",[mDb lastErrorMessage]);
        }
    }
    //cellimage
    if ([item isKindOfClass:[JingdianCellImageItem class]])
    {
        //避免有的字符串应该有符号
        JingdianCellImageItem * itm = item;
        NSString * sql = [NSString stringWithFormat:@"insert into %@(pic_url,is_cover)  values (?,?)     ",tableName];
        //传的4个必须是对象，不能是一个类型
        if ([mDb executeUpdate:sql,itm.pic_url,itm.is_cover]) {
            NSLog(@"数据插入到cellIamge表成功");
        }
        else
        {
            NSLog(@"插入---cellImage表失败:%@",[mDb lastErrorMessage]);
        }
    }
    
    

}


-(void)insertArray:(NSArray *)array
{
//不是频繁的操作磁盘，等所有插入语句准备好啦，一次性提交磁盘，提高效率
    if ([[array objectAtIndex:0] isKindOfClass:[TourismItem class]]) {
        [mDb beginTransaction];
        for(TourismItem * item  in array  )
        {
            [self insertItem:item];
            
        }
        [mDb commit];
    }
    if ([[array objectAtIndex:0] isKindOfClass:[TourismLocationItem class]]) {
        [mDb beginTransaction];
        for(TourismLocationItem * item  in array  )
        {
            [self insertItem:item];
            
        }
        [mDb commit];
    }
    
    if ([[array objectAtIndex:0] isKindOfClass:[MingShengJingDidanItem class]]) {
        [mDb beginTransaction];
        for(MingShengJingDidanItem * item  in array  )
        {
            [self insertItem:item];
            
        }
        [mDb commit];
    }
}
-(void)insertArray:(id)array intable:(NSString *)tableName
{
    if ([[array objectAtIndex:0] isKindOfClass:[PagecontrollerImageItem class]]) {
        [mDb beginTransaction];
        for (PagecontrollerImageItem * item in array)
        {
            [self insertItem:item intable:tableName];
        }
        [mDb commit];
    }
    //scene
    if ([[array objectAtIndex:0] isKindOfClass:[SceneItem class]]) {
        [mDb beginTransaction];
        for (SceneItem * item in array)
        {
            [self insertItem:item intable:tableName];
        }
        [mDb commit];
    }
    //dining
    if ([[array objectAtIndex:0] isKindOfClass:[DiningItem class]]) {
        [mDb beginTransaction];
        for (DiningItem * item in array)
        {
            [self insertItem:item intable:tableName];
        }
        [mDb commit];
    }
    //traffic
    if ([[array objectAtIndex:0] isKindOfClass:[TrafficRemoteItem class]]) {
        [mDb beginTransaction];
        for (TrafficRemoteItem * item in array)
        {
            [self insertItem:item intable:tableName];
        }
        [mDb commit];
    }
    //notes
    if ([[array objectAtIndex:0] isKindOfClass:[NotesViewItem class]]) {
        [mDb beginTransaction];
        for (NotesViewItem * item in array)
        {
            [self insertItem:item intable:tableName];
        }
        [mDb commit];
    }
    //shopping
    if ([[array objectAtIndex:0] isKindOfClass:[ShoppingSpecialItem class]]) {
        [mDb beginTransaction];
        for (ShoppingSpecialItem * item in array)
        {
            [self insertItem:item intable:tableName];
        }
        [mDb commit];
    }
    //line
    if ([[array objectAtIndex:0] isKindOfClass:[LineItem class]]) {
        [mDb beginTransaction];
        for (LineItem * item in array)
        {
            [self insertItem:item intable:tableName];
        }
        [mDb commit];
    }
    //______periphery___________________
    //景点
    if ([[array objectAtIndex:0] isKindOfClass:[PeripheryJingdianItem class]]) {
        [mDb beginTransaction];
        for (PeripheryJingdianItem * item in array)
        {
            [self insertItem:item intable:tableName];
        }
        [mDb commit];
    }
    //餐饮
    if ([[array objectAtIndex:0] isKindOfClass:[PeripheryCanyinItem class]]) {
        [mDb beginTransaction];
        for (PeripheryCanyinItem * item in array)
        {
            [self insertItem:item intable:tableName];
        }
        [mDb commit];
    }
    //酒店
    if ([[array objectAtIndex:0] isKindOfClass:[PeripheryJiudianItem class]]) {
        [mDb beginTransaction];
        for (PeripheryJiudianItem * item in array)
        {
            [self insertItem:item intable:tableName];
        }
        [mDb commit];
    }
    //休闲
    if ([[array objectAtIndex:0] isKindOfClass:[PeripheryXiuxianItem class]]) {
        [mDb beginTransaction];
        for (PeripheryXiuxianItem * item in array)
        {
            [self insertItem:item intable:tableName];
        }
        [mDb commit];
    }
    //cell
    if ([[array objectAtIndex:0] isKindOfClass:[JingdianCellFirstItem class]]) {
        [mDb beginTransaction];
        for (JingdianCellFirstItem * item in array)
        {
            [self insertItem:item intable:tableName];
        }
        [mDb commit];
    }
    //cellImage
    if ([[array objectAtIndex:0] isKindOfClass:[JingdianCellImageItem class]]) {
        [mDb beginTransaction];
        for (JingdianCellImageItem * item in array)
        {
            [self insertItem:item intable:tableName];
        }
        [mDb commit];
    }

}


//14:22
-(NSArray *)readItem:(NSInteger)start count:(NSInteger)count withTable:(id)item
{
//     NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray * array = [[NSMutableArray alloc] init];
    if ([item isKindOfClass:[TourismItem class]]) {
        NSString * sql = [NSString stringWithFormat:@"select sid,sname,pic_url,scene_layer,parent_sid from FirstViewTable limit %d,%d",start,count];
        
        FMResultSet * rs = [mDb executeQuery:sql];
//        NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
        
        
        while ([rs next]) {
            TourismItem * item = [[[TourismItem alloc] init]autorelease];
            //根据@"uid"的类型确定用哪个函数，还有doubleForcolumn,datafor
            item.sid = [rs stringForColumn:@"sid"];
            item.sname = [rs stringForColumn:@"sname"];
            item.pic_url = [rs stringForColumn:@"pic_url"];
            item.scene_layer = [rs stringForColumn:@"scene_layer"];
            item.parent_sid = [rs stringForColumn:@"parent_sid"];
            [array addObject:item];
            
            
        }
    }
    if ([item isKindOfClass:[TourismLocationItem class]]) {
        NSString * sql = [NSString stringWithFormat:@"select sid,sname,pic_url,top_count,city,district,province,street,street_number from LocationTable limit %d,%d",start,count];
        
        FMResultSet * rs = [mDb executeQuery:sql];
//        NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];

        NSLog(@"%d",[self lookupItemCount:item]);
        
        while ([rs next]) {
            TourismLocationItem * item = [[[TourismLocationItem alloc] init]autorelease];
            //根据@"uid"的类型确定用哪个函数，还有doubleForcolumn,datafor
            item.sid = [rs stringForColumn:@"sid"];
            item.sname = [rs stringForColumn:@"sname"];
            item.pic_url = [rs stringForColumn:@"pic_url"];
            item.top_count = [rs stringForColumn:@"top_count"];
            item.city = [rs stringForColumn:@"city"];
            item.district = [rs stringForColumn:@"district"];
            item.province = [rs stringForColumn:@"province"];
            item.street = [rs stringForColumn:@"street"];
            item.street_number = [rs stringForColumn:@"street_number"];
            [array addObject:item];
    }
     NSLog(@"----------------===%d",[array count]);
}
    
    if ([item isKindOfClass:[MingShengJingDidanItem class]]) {
        NSString * sql = [NSString stringWithFormat:@"select sid,sname,scene_layer,parent_sid,is_china,x,y,pic_url,level,is_newest,package_exist,package_url,package_size,aid,pics_count,tag_list from mingshengjingdian limit %d,%d",start,count];
        
        FMResultSet * rs = [mDb executeQuery:sql];
        //        NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
        
        
        while ([rs next]) {
            MingShengJingDidanItem * item = [[MingShengJingDidanItem alloc] init];
            //根据@"uid"的类型确定用哪个函数，还有doubleForcolumn,datafor
            item.sid = [rs stringForColumn:@"sid"];
            item.sname = [rs stringForColumn:@"sname"];
            item.scene_layer = [rs stringForColumn:@"scene_layer"];
            item.parent_sid = [rs stringForColumn:@"parent_sid"];
            item.is_china = [rs stringForColumn:@"is_china"];
            item.x = [rs stringForColumn:@"x"];
            item.y = [rs stringForColumn:@"y"];
            item.pic_url = [rs stringForColumn:@"pic_url"];
            item.level = [rs stringForColumn:@"level"];
            item.is_newest = [rs stringForColumn:@"is_newest"];
            item.package_exist = [rs stringForColumn:@"package_exist"];
            item.package_url = [rs stringForColumn:@"package_url"];
            item.package_size = [rs stringForColumn:@"package_size"];
            item.aid = [rs stringForColumn:@"aid"];
            item.pics_count = [rs stringForColumn:@"pics_count"];
            item.tag_list = [rs stringForColumn:@"tag_list"];
            
            [array addObject:item];
            [item release];
            
            
        }
    }

    
    
    
    
    return array;
    [array release];


}
//查询当前有多少条记录
-(NSInteger)lookupItemCount:(id)item
{
    if ([item isKindOfClass: [TourismItem class]]) {
        NSString *sql = @"select count(*) from FirstViewTable";
        FMResultSet * rs = [mDb executeQuery:sql];
        while ([rs next]) {
            
            //获得当前记录的第一个字段值
            NSInteger count = [rs intForColumnIndex:0];
            return count;
        }

    }
    if ([item isKindOfClass:[TourismLocationItem class]]) {
        NSString *sql = @"select count(*) from LocationTable";
        FMResultSet * rs = [mDb executeQuery:sql];
        while ([rs next]) {
            
            //获得当前记录的第一个字段值
            NSInteger count = [rs intForColumnIndex:0];
            return count;
        }

    }
    
    if ([item isKindOfClass:[MingShengJingDidanItem class]]) {
        NSString *sql = @"select count(*) from mingshengjingdian";
        FMResultSet * rs = [mDb executeQuery:sql];
        while ([rs next]) {
            
            //获得当前记录的第一个字段值
            NSInteger count = [rs intForColumnIndex:0];
            return count;
        }
        
    }
    
    
       return 0;
}
-(NSArray *)selectFrom:(NSString *)tableName withKey:(NSString *)keyStr andwithItemType:(id)item
{
     NSMutableArray * array = [[NSMutableArray alloc] init];
    if ([item isKindOfClass:[MingShengJingDidanItem class]]) {
        NSString * sql = [NSString stringWithFormat:@"select sid,sname,scene_layer,parent_sid,is_china,x,y,pic_url,level,is_newest,package_exist,package_url,package_size,aid,pics_count,tag_list from %@ where sid = ?",tableName];

        FMResultSet * rs = [mDb executeQuery:sql,keyStr];
        //select  tran_id, train_number , sub_train_number  ,  to_station_name,  to_time, from_time, to_station_id,station_num  ,day, km   from train
        while ([rs next]) {
            MingShengJingDidanItem * item = [[MingShengJingDidanItem alloc] init];
            //根据@"uid"的类型确定用哪个函数，还有doubleForcolumn,datafor
            //item.sid = [rs stringForColumn:@"sid"];
            item.sname = [rs stringForColumn:@"sname"];
            item.scene_layer = [rs stringForColumn:@"scene_layer"];
            item.parent_sid = [rs stringForColumn:@"parent_sid"];
            item.is_china = [rs stringForColumn:@"is_china"];
            item.x = [rs stringForColumn:@"x"];
            item.y = [rs stringForColumn:@"y"];
            item.pic_url = [rs stringForColumn:@"pic_url"];
            item.level = [rs stringForColumn:@"level"];
            item.is_newest = [rs stringForColumn:@"is_newest"];
            item.package_exist = [rs stringForColumn:@"package_exist"];
            item.package_url = [rs stringForColumn:@"package_url"];
            item.package_size = [rs stringForColumn:@"package_size"];
            item.aid = [rs stringForColumn:@"aid"];
            item.pics_count = [rs stringForColumn:@"pics_count"];
            item.tag_list = [rs stringForColumn:@"tag_list"];
            
            [array addObject:item];
            [item release];
        }
    }
    return array;
}

-(NSArray *)selectFrom:(NSString *)tableName readItem:(NSInteger)start count:(NSInteger)count withItemType:(id)item
{
    NSMutableArray * array = [[NSMutableArray alloc] init];
        
        if ([item isKindOfClass:[MingShengJingDidanItem class]]) {
            NSString * sql = [NSString stringWithFormat:@"select sid,sname,scene_layer,parent_sid,is_china,x,y,pic_url,level,is_newest,package_exist,package_url,package_size,aid,pics_count,tag_list from %@ limit %d,%d",tableName,start,count];
            
            FMResultSet * rs = [mDb executeQuery:sql];

            while ([rs next]) {
                MingShengJingDidanItem * item = [[MingShengJingDidanItem alloc] init];
                //根据@"uid"的类型确定用哪个函数，还有doubleForcolumn,datafor
                item.sid = [rs stringForColumn:@"sid"];
                item.sname = [rs stringForColumn:@"sname"];
                item.scene_layer = [rs stringForColumn:@"scene_layer"];
                item.parent_sid = [rs stringForColumn:@"parent_sid"];
                item.is_china = [rs stringForColumn:@"is_china"];
                item.x = [rs stringForColumn:@"x"];
                item.y = [rs stringForColumn:@"y"];
                item.pic_url = [rs stringForColumn:@"pic_url"];
                item.level = [rs stringForColumn:@"level"];
                item.is_newest = [rs stringForColumn:@"is_newest"];
                item.package_exist = [rs stringForColumn:@"package_exist"];
                item.package_url = [rs stringForColumn:@"package_url"];
                item.package_size = [rs stringForColumn:@"package_size"];
                item.aid = [rs stringForColumn:@"aid"];
                item.pics_count = [rs stringForColumn:@"pics_count"];
                item.tag_list = [rs stringForColumn:@"tag_list"];
                
                [array addObject:item];
                [item release];
                
                
            }
        }
    
    if ([item isKindOfClass:[PagecontrollerImageItem class]]) {
         NSString * sql = [NSString stringWithFormat:@"select pic_url,is_cover,title,desc from %@ limit %d,%d",tableName,start,count];
        FMResultSet * rs = [mDb executeQuery:sql];
        while ([rs next]) {
            PagecontrollerImageItem * item = [[PagecontrollerImageItem alloc] init];
            item.pic_url = [rs stringForColumn:@"pic_url"];
            item.is_cover = [rs stringForColumn:@"is_cover"];
            item.title = [rs stringForColumn:@"title"];
            item.desc = [rs stringForColumn:@"desc"];
            
            [array addObject:item];
            [item release];
            
        }
    }
    //查询八按钮--scene
    if ([item isKindOfClass:[SceneItem class]]) {
        NSString * sql = [NSString stringWithFormat:@"select sid,sname,scene_layer,parent_sid,going_count,gone_count,pic_url,distance,map_x,map_y,abstract,desc from %@ limit %d,%d",tableName,start,count];
        FMResultSet * rs = [mDb executeQuery:sql];
        while ([rs next]) {
            SceneItem * item = [[SceneItem alloc] init];
            item.sid = [rs stringForColumn:@"sid"];
            item.sname = [rs stringForColumn:@"sname"];
            item.scene_layer = [rs stringForColumn:@"scene_layer"];
            item.parent_sid = [rs stringForColumn:@"parent_sid"];
            item.going_count = [rs stringForColumn:@"going_count"];
            item.gone_count = [rs stringForColumn:@"gone_count"];
            item.pic_url = [rs stringForColumn:@"pic_url"];
            item.distance = [rs stringForColumn:@"distance"];
            item.map_x = [rs stringForColumn:@"map_x"];
            item.map_y = [rs stringForColumn:@"map_y"];
            item.abstract = [rs stringForColumn:@"abstract"];
            item.desc = [rs stringForColumn:@"desc"];
            
            [array addObject:item];
            [item release];
            
        }
    }
    //查询八按钮--dining
    if ([item isKindOfClass:[DiningItem class]]) {
        NSString * sql = [NSString stringWithFormat:@"select key,desc,pic_url from %@ limit %d,%d",tableName,start,count];
        FMResultSet * rs = [mDb executeQuery:sql];
        while ([rs next]) {
            DiningItem * item = [[DiningItem alloc] init];
            item.key = [rs stringForColumn:@"key"];
            item.desc = [rs stringForColumn:@"desc"];
            item.pic_url = [rs stringForColumn:@"pic_url"];
            [array addObject:item];
            [item release]; 
        }
    }

    //查询八按钮--trafficRemote
    if ([item isKindOfClass:[TrafficRemoteItem class]]) {
        NSString * sql = [NSString stringWithFormat:@"select key,desc,pic_url from %@ limit %d,%d",tableName,start,count];
        FMResultSet * rs = [mDb executeQuery:sql];
        while ([rs next]) {
            TrafficRemoteItem * item = [[TrafficRemoteItem alloc] init];
            item.key = [rs stringForColumn:@"key"];
            item.desc = [rs stringForColumn:@"desc"];
            item.pic_url = [rs stringForColumn:@"pic_url"];
            [array addObject:item];
            [item release];
        }
    }
    
    //查询按钮八按钮---notes
    if ([item isKindOfClass:[NotesViewItem class]]) {
        NSString * sql = [NSString stringWithFormat:@"select nid,title,departure,time,time_unit,start_month,start_time,is_praised,is_good,is_set_guide,pic_url,user_nickname from %@ limit %d,%d",tableName,start,count];
        FMResultSet * rs = [mDb executeQuery:sql];
        while ([rs next]) {
            NotesViewItem * item = [[NotesViewItem alloc] init];
            item.nid = [rs stringForColumn:@"nid"];
            item.title = [rs stringForColumn:@"title"];
            item.departure = [rs stringForColumn:@"departure"];
            item.time = [rs stringForColumn:@"time"];
            item.time_unit = [rs stringForColumn:@"time_unit"];
            item.start_month = [rs stringForColumn:@"start_month"];
            item.start_time = [rs stringForColumn:@"start_time"];
            item.is_praised = [rs stringForColumn:@"is_praise"];
            item.is_good = [rs stringForColumn:@"is_good"];
            item.is_set_guide = [rs stringForColumn:@"is_set_guide"];
            item.pic_url = [rs stringForColumn:@"pic_url"];
            item.user_nickname = [rs stringForColumn:@"user_nickname"];
 
            [array addObject:item];
            [item release];
        }
    }
    //查询八按钮--shopping
    if ([item isKindOfClass:[ShoppingSpecialItem class]]) {
        NSString * sql = [NSString stringWithFormat:@"select key,desc,pic_url from %@ limit %d,%d",tableName,start,count];
        FMResultSet * rs = [mDb executeQuery:sql];
        while ([rs next]) {
            ShoppingSpecialItem * item = [[ShoppingSpecialItem alloc] init];
            item.key = [rs stringForColumn:@"key"];
            item.desc = [rs stringForColumn:@"desc"];
            item.pic_url = [rs stringForColumn:@"pic_url"];
            [array addObject:item];
            [item release];
        }
    }
    
    //查询按钮八按钮---line
    if ([item isKindOfClass:[LineItem class]]) {
        NSString * sql = [NSString stringWithFormat:@"select key,keyword,desc,dinning,accordination from %@ limit %d,%d",tableName,start,count];
        FMResultSet * rs = [mDb executeQuery:sql];
        while ([rs next]) {
            LineItem * item = [[LineItem alloc] init];
            item.key = [rs stringForColumn:@"key"];
            item.keyword = [rs stringForColumn:@"keyword"];
            item.desc = [rs stringForColumn:@"desc"];
            item.dinning = [rs stringForColumn:@"dinning"];
            item.accordination = [rs stringForColumn:@"accordination"];
            
            [array addObject:item];
            [item release];
        }
    }
    //————————————————————periphery——————————————————————————
    //景点
    if ([item isKindOfClass:[PeripheryJingdianItem class]]) {
        NSString * sql = [NSString stringWithFormat:@"select sid,sname,pic_url,distance,map_x,map_y,star,going_count from %@ limit %d,%d",tableName,start,count];
        FMResultSet * rs = [mDb executeQuery:sql];
        while ([rs next]) {
            PeripheryJingdianItem * item = [[PeripheryJingdianItem alloc] init];
            item.sid = [rs stringForColumn:@"sid"];
            item.sname = [rs stringForColumn:@"sname"];
            item.pic_url = [rs stringForColumn:@"pic_url"];
            item.distance = [rs stringForColumn:@"distance"];
            item.map_x = [rs stringForColumn:@"map_x"];
            item.map_y = [rs stringForColumn:@"map_y"];
            item.star = [rs stringForColumn:@"star"];
            item.going_count = [rs stringForColumn:@"going_count"];
            
            [array addObject:item];
            [item release];
        }
    }
    //餐饮
    if ([item isKindOfClass:[PeripheryCanyinItem class]]) {
        NSString * sql = [NSString stringWithFormat:@"select name,address,distance,uid,map_y,map_x,comm_num,price,star,type from %@ limit %d,%d",tableName,start,count];
        FMResultSet * rs = [mDb executeQuery:sql];
        while ([rs next]) {
            PeripheryCanyinItem * item = [[PeripheryCanyinItem alloc] init];
            item.name = [rs stringForColumn:@"name"];
            item.address = [rs stringForColumn:@"address"];
            item.distance = [rs stringForColumn:@"distance"];
            item.uid = [rs stringForColumn:@"uid"];
            item.map_x = [rs stringForColumn:@"map_x"];
            item.map_y = [rs stringForColumn:@"map_y"];
            item.comm_num = [rs stringForColumn:@"comm_num"];
            item.price = [rs stringForColumn:@"price"];
            item.star = [rs stringForColumn:@"star"];
            item.type = [rs stringForColumn:@"type"];
            
            [array addObject:item];
            [item release];
        }
    }
    //酒店
    if ([item isKindOfClass:[PeripheryJiudianItem class]]) {
        NSString * sql = [NSString stringWithFormat:@"select name,address,distance,uid,map_y,map_x,comm_num,price,star,type from %@ limit %d,%d",tableName,start,count];
        FMResultSet * rs = [mDb executeQuery:sql];
        while ([rs next]) {
            PeripheryJiudianItem * item = [[PeripheryJiudianItem alloc] init];
            item.name = [rs stringForColumn:@"name"];
            item.address = [rs stringForColumn:@"address"];
            item.distance = [rs stringForColumn:@"distance"];
            item.uid = [rs stringForColumn:@"uid"];
            item.map_x = [rs stringForColumn:@"map_x"];
            item.map_y = [rs stringForColumn:@"map_y"];
            item.comm_num = [rs stringForColumn:@"comm_num"];
            item.price = [rs stringForColumn:@"price"];
            item.star = [rs stringForColumn:@"star"];
            item.type = [rs stringForColumn:@"type"];
            
            [array addObject:item];
            [item release];
        }
    }
    //休闲
    if ([item isKindOfClass:[PeripheryXiuxianItem class]]) {
        NSString * sql = [NSString stringWithFormat:@"select name,address,distance,uid,map_y,map_x,comm_num,price,star,type from %@ limit %d,%d",tableName,start,count];
        FMResultSet * rs = [mDb executeQuery:sql];
        while ([rs next]) {
            PeripheryXiuxianItem * item = [[PeripheryXiuxianItem alloc] init];
            item.name = [rs stringForColumn:@"name"];
            item.address = [rs stringForColumn:@"address"];
            item.distance = [rs stringForColumn:@"distance"];
            item.uid = [rs stringForColumn:@"uid"];
            item.map_x = [rs stringForColumn:@"map_x"];
            item.map_y = [rs stringForColumn:@"map_y"];
            item.comm_num = [rs stringForColumn:@"comm_num"];
            item.price = [rs stringForColumn:@"price"];
            item.star = [rs stringForColumn:@"star"];
            item.type = [rs stringForColumn:@"type"];
            
            [array addObject:item];
            [item release];
        }
    }
    //cell
    if ([item isKindOfClass:[JingdianCellFirstItem class]]) {
        NSString * sql = [NSString stringWithFormat:@"select sid,sname,scene_layer,parent_sid,x,y,desc,opening_hours,price,address from %@ limit %d,%d",tableName,start,count];
        FMResultSet * rs = [mDb executeQuery:sql];
        while ([rs next]) {
            JingdianCellFirstItem * item = [[JingdianCellFirstItem alloc] init];
            item.sid = [rs stringForColumn:@"sid"];
            item.sname = [rs stringForColumn:@"sname"];
            item.scene_layer = [rs stringForColumn:@"scene_layer"];
            item.parent_sid = [rs stringForColumn:@"parent_sid"];
            item.x = [rs stringForColumn:@"x"];
            item.y = [rs stringForColumn:@"y"];
            item.desc = [rs stringForColumn:@"desc"];
            item.opening_hours = [rs stringForColumn:@"opening_hours"];
            item.price = [rs stringForColumn:@"price"];
            item.address = [rs stringForColumn:@"address"];

            [array addObject:item];
            [item release];
        }
    }
    //cellImage
    if ([item isKindOfClass:[JingdianCellImageItem class]]) {
        NSString * sql = [NSString stringWithFormat:@"select pic_url,is_cover from %@ limit %d,%d",tableName,start,count];
        FMResultSet * rs = [mDb executeQuery:sql];
        while ([rs next]) {
            JingdianCellImageItem * item = [[JingdianCellImageItem alloc] init];
            item.pic_url = [rs stringForColumn:@"pic_url"];
            item.is_cover = [rs stringForColumn:@"is_cover"];
            
            [array addObject:item];
            [item release];
        }
    }
    
    
    
    return array;

}



-(id)init
{
    if (self = [super init]) {
        [self creatDatabase];
    }
    return self;
}
- (void)dealloc
{
    [mDb release];
    mDb = nil;
    [super dealloc];
}

@end
