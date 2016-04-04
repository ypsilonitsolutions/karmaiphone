//
//  CardView.h
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 11/02/15.
//  Copyright (c) 2012 MKD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DraggableView.h"

@interface CardView : UIView

@property (strong, nonatomic) IBOutlet UILabel *lbl_karma;
@property (strong, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_follows;
@property (weak, nonatomic) IBOutlet UILabel *lbl_story;
@property (weak, nonatomic) IBOutlet UIImageView *userimage;
@property (weak, nonatomic) IBOutlet UIImageView *bg_userimage;
@property (weak, nonatomic) IBOutlet UIImageView *sliderimage;
@property (weak, nonatomic) IBOutlet UIButton *btn_story;
@property (weak, nonatomic) IBOutlet UIButton *btn_profile;
@property (weak, nonatomic) IBOutlet UIView *view_Story;
@property (weak, nonatomic) IBOutlet UIButton *btn_ShowFullImage;



@end
