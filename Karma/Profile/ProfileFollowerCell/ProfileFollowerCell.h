//
//  ProfileFollowerCell.h
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 04/09/15.
//  Copyright (c) 2015 MaheshDhakad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileFollowerCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbl_Name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Counter;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_BG;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_ProfilePic;
@property (strong, nonatomic) IBOutlet UIButton *btn_prf;
@end
