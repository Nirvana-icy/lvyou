//
//  SceneCell.h
//  百度旅游
//
//  Created by Lucky on 13-4-7.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SceneCell : UITableViewCell
@property (nonatomic,retain) IBOutlet UIImageView * leftImageview;
@property (nonatomic,retain) IBOutlet UIImageView * bottomImageview;
@property (nonatomic,retain) IBOutlet UILabel * topLabel;
@property (nonatomic,retain) IBOutlet UILabel * bottomLabel;
@end
