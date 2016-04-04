//
//  Profile.h
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 04/09/15.
//  Copyright (c) 2015 MaheshDhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"


@interface Profile : UIViewController<UIGestureRecognizerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    NSString *nibName;
    NSString *profileFollowerCellNibName;
    NSString *commentTVCellNibName;
    NSUserDefaults *nsud;
    NSMutableArray *arrayStory;
    NSString *pageCount;
    BOOL isLoadingMore;
    NSString *currentUserId;
    
    IBOutlet UILabel *lbl_karmavote;
    IBOutlet UIView *lbl_bg;
    IBOutlet UIView *view_Layout;
    IBOutlet UIButton *btn_follows;

    NSMutableArray *arrayProfileInfo,*arrayProfileStory,*arrayProfileFollowers;
    
    MBProgressHUD *HUD;
    NSString *karmaMeterValue;
    
   IBOutlet UIImageView *img_banner;
   IBOutlet UIImageView *img_banner_BG;
    NSString *str_counter;
    NSString *currentStoryid;
    NSString *currentStoryIndex;

}

@property NSString *str_UserId;
@property NSString *str_ProfileOwner;

@property (strong,nonatomic) IBOutlet UITableView *tv_ProfileStory;



@end
