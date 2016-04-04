//
//  StoryCommentsVC.h
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 21/01/16.
//  Copyright (c) 2015 Mahesh Kumar Dhakad. All rights reserved.

#import <UIKit/UIKit.h>
#import "Constant.h"


@interface StoryCommentsVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIActionSheetDelegate,MDGrowingTextViewDelegate,UITextFieldDelegate>
{
    NSString *currentUserId;
    NSUserDefaults *nsud;
    MBProgressHUD *HUD;
    BOOL isMenuShow;
    NSString *tvCellName,*storyCellNibName;
    //NSArray *arrayStory;
    NSString *commentID;
    NSString *isReportandDelete;
    NSMutableArray *swipedCellIndexed;
    NSMutableArray *arrayStoryComments;
    NSString *storyID;
    NSString *commentIndex;
    NSMutableArray *array_AllStory;
    NSInteger reportIndex;
    NSString *isAuthor;
    // For Video
    UIWebView *videoView;
    //UIView *moviePlayerView;
    MPMoviePlayerViewController *moviePlayer;
    float isChangeHieght;
    float newHieght;
    MDGrowingTextView *commentTextView;
    UIView *containerView;
    UIButton *btn_send;
    BOOL isZoomImage;
    IBOutlet UIView *view_Story;
    IBOutlet UIView *view_StoryImage;

}

@property NSArray *arrayStory;
@property NSString *karmaMeterPercent;

@property NSString *str_UserId;
@property NSString *str_ProfileOwner;


@property (strong, nonatomic) IBOutlet UITableView *tv;
@property (strong, nonatomic) IBOutlet UIView *storyCommentsView;
@property (strong, nonatomic) IBOutlet UIButton *btnAddNewStory;
@property (strong, nonatomic)  UIView *moviePlayerView;

-(void)resignTextView;


@end
