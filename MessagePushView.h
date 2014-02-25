//
//  MessagePushView.h
//  百度旅游
//
//  Created by Lucky on 13-3-31.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagePushView : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * mTableView;
    NSMutableArray * firstSectionArray;
    NSMutableArray * secondSectionArray;
    NSMutableArray * dataArray;
}
@end
