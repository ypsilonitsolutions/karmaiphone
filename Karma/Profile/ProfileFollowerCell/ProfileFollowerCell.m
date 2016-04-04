//
//  ProfileFollowerCell.m
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 04/09/15.
//  Copyright (c) 2015 MaheshDhakad. All rights reserved.
//

#import "ProfileFollowerCell.h"

@implementation ProfileFollowerCell
@synthesize btn_prf,lbl_Name,lbl_Counter,imageView_BG,imageView_ProfilePic;
- (void)awakeFromNib {
    // Initialization code Categorylist_iphone6
    
   // self.imageView_BG.layer.cornerRadius = self.imageView_BG.frame.size.width / 2;
    //self.imageView_BG.layer.masksToBounds = YES;
    
    
    self.imageView_ProfilePic.layer.cornerRadius = self.imageView_ProfilePic.frame.size.width / 2;
    self.imageView_ProfilePic.layer.masksToBounds = YES;
}

@end
