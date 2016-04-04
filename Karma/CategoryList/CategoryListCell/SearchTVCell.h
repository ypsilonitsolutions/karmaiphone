//
//  SearchTVCell.h
//  Phoenix
//
//  Created by Mahesh Kumar Dhakad on 11/25/14.
//  Copyright (c) 2015 MaheshDhakad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTVCell : UITableViewCell


@property(strong,nonatomic)IBOutlet UILabel *followers;
@property(strong,nonatomic)IBOutlet UILabel *stroy;
@property(strong,nonatomic)IBOutlet UILabel *name;
@property(strong,nonatomic)IBOutlet UILabel *lbl_karma;
@property(strong,nonatomic)IBOutlet UIButton *btn_story;
@property (strong,nonatomic)IBOutlet UIImageView *userimage_list;
@property (strong,nonatomic)IBOutlet UIImageView *bg_list;

@property(weak,nonatomic)IBOutlet UIButton *btnShowProfile;


@end
