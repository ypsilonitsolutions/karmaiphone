//
//  StoryViewController.h
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 15/09/15.
//  Copyright (c) 2015 Mahesh Kumar Dhakad. All rights reserved.

#import <UIKit/UIKit.h>
#import "Constant.h"


@interface StoryViewController : UIViewController<UIActionSheetDelegate,UIGestureRecognizerDelegate,DraggableViewDelegate>
{
    MBProgressHUD *HUD;
    
    // For Video
    UIWebView *videoView;
   // UIView *moviePlayerView;
    NSString *pageCount;
    BOOL isZoomImage;

    NSArray *arrayStory;
    NSString *currentUserId;
    NSUserDefaults *nsud;
    NSArray *arrayStoryComments;
    NSMutableArray *arrayKarmaMeterPercent;
    MPMoviePlayerViewController *moviePlayer;

    NSString *karmaMeterValue;
    
    NSString *karmaMeterGoodValue;
    NSString *karmaMeterBadValue;

    NSString *voteType;
    NSString *storyID;
    
   int cardNumber;
    
}

@property NSString *currentsearch_demo;
@property NSString *currentAddstory_userid;
@property NSString *currentsearch_userid;
@property NSString *tag_pics;
@property NSString *tag_userId;
@property NSString *tag_findtag;
@property NSString *tag_categoryname;
@property NSString *countfind;
@property NSString *getStoryByTagId;
@property NSString *getStoryByStoryId;
@property NSString *getStoryByUserId;
@property NSString *getStoryURL;

@property (strong, nonatomic) IBOutlet UIImageView *imgViewGIFBad;

@property (strong, nonatomic) IBOutlet UIImageView *imgViewGIFGood;

@property (strong, nonatomic) IBOutlet UIView *commentsView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UIButton *btnAddNewStory;
@property (strong, nonatomic)  UIView *moviePlayerView;

//Tinder
-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;
@property (retain,nonatomic) NSMutableArray* allCards;
// End Tinder

@end
