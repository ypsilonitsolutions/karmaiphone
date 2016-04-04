//
//  StoryTVCell.h
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 24/07/15.
//  Copyright (c) 2015 MaheshDhakad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryTVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbl_header;
@property (weak, nonatomic) IBOutlet UILabel *lbl_notif_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_comment;
@property (weak, nonatomic) IBOutlet UIImageView *img_user;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (nonatomic,retain) IBOutlet UISwipeGestureRecognizer *swipeGestureLeft;
@property (nonatomic,retain) IBOutlet UISwipeGestureRecognizer *swipeGestureRight;
@property(nonatomic,retain) IBOutlet UIView *cell_View;
@property (weak, nonatomic) IBOutlet UIButton *btn_creport;
@property (weak, nonatomic) IBOutlet UIButton *btn_delete;
@property (weak, nonatomic) IBOutlet UIButton *btn_preport;
@property (weak, nonatomic) IBOutlet UIButton *btn_report;
@property (weak, nonatomic) IBOutlet UIButton *btn_confid;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end
