//
//  MyCell_Periphery.h
//  百度旅游
//
//  Created by Lucky on 13-3-27.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell_Periphery : UITableViewCell
@property (nonatomic,readonly) IBOutlet UIImageView * pinImage;
@property (nonatomic,readonly) IBOutlet UILabel * titleLable;
@property (nonatomic,readonly) IBOutlet UIImageView * starImage;
@property (nonatomic,readonly) IBOutlet UILabel * averagePriceLable;
@property (nonatomic,readonly) IBOutlet UILabel * priceLable;
@property (nonatomic,readonly) IBOutlet UILabel * critiqueLable;
@property (nonatomic,readonly) IBOutlet UILabel * distanceLable;
@end
