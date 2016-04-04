//
//  StoryCommentsTVCell.h
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 21/01/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryCommentsTVCell : UITableViewCell

// For Story Details
@property (strong, nonatomic) IBOutlet UILabel *lbl_StoryKarma;
@property (strong, nonatomic) IBOutlet UILabel *lbl_StoryUserName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_StoryUser;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_StoryUserBG;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_Story;
@property (weak, nonatomic) IBOutlet UIButton *btn_ShowStoryFullImage;
@property (weak, nonatomic) IBOutlet UIButton *btn_StoryUserProfile;
@property (weak, nonatomic) IBOutlet UIView *view_StoryDeatils;

@property (weak, nonatomic) IBOutlet UIButton *btn_StoryShare;


// For Story Description

@property (weak, nonatomic) IBOutlet UILabel *lbl_StoryCreateDate;
@property (weak, nonatomic) IBOutlet UILabel *lbl_StoryDesc;



// For Comment Details
@property (strong, nonatomic) IBOutlet UILabel *lbl_CommentKarma;
@property (strong, nonatomic) IBOutlet UILabel *lbl_CommentUserName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_CommentUser;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_CommentUserBG;
@property (weak, nonatomic) IBOutlet UIButton *btn_CommentUserProfile;
@property (weak, nonatomic) IBOutlet UIView *view_CommentDeatils;


// For Comment Description

@property (weak, nonatomic) IBOutlet UILabel *lbl_CommentCreateDate;
@property (weak, nonatomic) IBOutlet UILabel *lbl_CommentDesc;

// For UISwipeGestureRecognizer

@property (nonatomic,retain) IBOutlet UISwipeGestureRecognizer *swipeGestureLeft;
@property (nonatomic,retain) IBOutlet UISwipeGestureRecognizer *swipeGestureRight;
@property(nonatomic,retain) IBOutlet UIView *cell_View;

@property (weak, nonatomic) IBOutlet UIButton *btn_preport;

@property (weak, nonatomic) IBOutlet UIButton *btn_decline;
@property (weak, nonatomic) IBOutlet UIButton *btn_delete;
@property (weak, nonatomic) IBOutlet UIButton *btn_report;
@property (weak, nonatomic) IBOutlet UIButton *btn_confidential;
@property (weak, nonatomic) IBOutlet UIButton *btn_creport;



@end
