//
//  AddStoryViewController.h
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 05/07/15.
//  Copyright (c) 2012 MKD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "CustomUIASView.h"

@interface AddStoryViewController : UIViewController<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>
{
    NSUserDefaults *nsud;
    MBProgressHUD *HUD;
    NSString *nibName; NSString *storyTagCellNibName;

    
    NSMutableArray *array_Tags;
    NSMutableArray *arraySelectedTags;

    NSString *youTubeURL;
    NSString *storyId;
    NSString *currentUserId;
    NSString *confidential;
    
    UIImage *pickImage;
    int isMediaType;

    
    IBOutlet UIButton *btn_camera;
    IBOutlet UIView *view_teatarea;
    IBOutlet UIView *view_textvalue;
    IBOutlet UIImageView *image_camera;
    IBOutlet UIImageView *checkimage;
    IBOutlet UICollectionView *collectionview;
    IBOutlet UILabel *lbl_counter;
    IBOutlet UILabel *lbl_name;
    IBOutlet UIButton *btn_Addstory;
    IBOutlet UIButton *btn_HideIdentity;
   
    IBOutlet UITextView *txt_view;
    IBOutlet UIImageView *img_userbg;
    IBOutlet UIImageView *img_userdef;
    IBOutlet UIImageView *img_userimage;
    IBOutlet UIImageView *imgView_Profile;

    IBOutlet UIScrollView *_scrollView;

}

@property NSString *profile_storybtn;
@property NSString *profile_name;
@property NSString *profile_image;
@property NSString *profile_mag;
@property NSString *prf_karma;

@property NSString *str_UserId;
@property NSString *str_ProfileOwner;

@property (nonatomic, retain) CustomUIASView *uiasView;

@end
