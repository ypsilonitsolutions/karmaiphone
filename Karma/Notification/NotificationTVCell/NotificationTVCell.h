//
//  NotificationTVCell.h
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 23/09/15.
//  Copyright (c) 2015 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationTVCell : UITableViewCell

@property (weak,nonatomic)IBOutlet UILabel *lblname;
@property(weak,nonatomic)IBOutlet UILabel *lbl_post;
@property (weak,nonatomic)IBOutlet UILabel *date;
@property(weak,nonatomic)IBOutlet UIImageView *img_notiuser;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_BG;
@property(weak,nonatomic)IBOutlet UIButton *btnShowProfile;
@property(strong,nonatomic)IBOutlet UILabel *lbl_Karma;

@end
