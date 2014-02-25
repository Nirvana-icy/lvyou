//
//  LineNextView.h
//  百度旅游
//
//  Created by Lucky on 13-4-8.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
@interface LineNextView : UIViewController
{
    NSString * sid;
    NSMutableArray * dataArray;
    NSInteger count;
}
@property (nonatomic,retain) IBOutlet UILabel * labelone;
@property (nonatomic,retain) IBOutlet UILabel * laebeltwo;
@property (nonatomic,retain) IBOutlet UILabel * labelthree;
@property (nonatomic,retain) IBOutlet UILabel * labelfour;
@property (nonatomic,retain) IBOutlet UILabel * labelfive;
@property (nonatomic,retain) NSString * sid;
@property (nonatomic,assign) NSInteger count;

@end
