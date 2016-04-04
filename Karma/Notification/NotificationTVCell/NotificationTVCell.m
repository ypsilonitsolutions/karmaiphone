//
//  NotificationTVCell.m
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 23/09/15.
//  Copyright (c) 2015 Mahesh Kumar Dhakad. All rights reserved.
//

#import "NotificationTVCell.h"

@implementation NotificationTVCell

@synthesize lbl_post,lblname,date,img_notiuser,btnShowProfile,imageView_BG,lbl_Karma;

- (void)awakeFromNib {
    // Initialization code
    
    img_notiuser.layer.cornerRadius = img_notiuser.frame.size.width / 2;
    img_notiuser.layer.masksToBounds = YES;
    [lbl_post sizeToFit];
    lbl_post.numberOfLines = 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
