//
//  StoryCommentTVCell.h
//  CollectionViewWithTAbleview
//
//  Created by admin on 18/09/15.
//  Copyright (c) 2015 ypsilon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryCommentTVCell.h"
@interface StoryCommentTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Lbl_date;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_des;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_desaboue2;
@property (weak, nonatomic) IBOutlet UILabel *Lbl_karma;
@property (weak, nonatomic) IBOutlet UIImageView *img_user;
@property (weak, nonatomic) IBOutlet UIImageView *bg_image;
@property (weak, nonatomic) IBOutlet UILabel *lbl_time;

@property (weak, nonatomic) IBOutlet UIButton *btn_share;
@property (weak, nonatomic) IBOutlet UIButton *btn_comment;

@property(weak,nonatomic)IBOutlet UIButton *btnShowProfile;

@property (weak, nonatomic) IBOutlet UILongPressGestureRecognizer *longPressGestureRecogn;
@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *tap;


@end
