//
//  LineCell.h
//  百度旅游
//
//  Created by Lucky on 13-4-8.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineCell : UITableViewCell
@property (nonatomic,retain) IBOutlet UIImageView * topImageView;
@property (nonatomic,retain) IBOutlet UIImageView * midImageView;
@property (nonatomic,retain) IBOutlet UILabel * titleLabel;
@property (nonatomic,retain) IBOutlet UILabel * midLabel;
@property (nonatomic,retain) IBOutlet UILabel * bottomLabel;
@end
