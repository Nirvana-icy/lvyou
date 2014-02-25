//
//  NotesCell.h
//  百度旅游
//
//  Created by Lucky on 13-4-7.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesCell : UITableViewCell
@property (nonatomic,retain) IBOutlet UIImageView * bigImageview;
@property (nonatomic,retain) IBOutlet UIImageView * samllImageview;
@property (nonatomic,retain) IBOutlet UILabel * titleLabel;
@property (nonatomic,retain) IBOutlet UILabel * authorLabel;
@property (nonatomic,retain) IBOutlet UILabel * dateLabel;
@property (nonatomic,retain) IBOutlet UILabel * runLabel;
@end
