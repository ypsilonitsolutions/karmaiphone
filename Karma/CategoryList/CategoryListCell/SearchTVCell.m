//
//  SearchTVCell.m
//  Phoenix
//
//  Created by Mahesh Kumar Dhakad on 11/25/14.
//  Copyright (c) 2015 MaheshDhakad. All rights reserved.
//

#import "SearchTVCell.h"

@implementation SearchTVCell

@synthesize stroy,followers,btn_story,userimage_list,name,bg_list,lbl_karma,btnShowProfile;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
          // Initialization code MyCell_iphone6 liveTableViewCell_ipad
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    
    bg_list.layer.cornerRadius = bg_list.frame.size.width / 2;
    bg_list.layer.masksToBounds = YES;
    
    userimage_list.layer.cornerRadius = userimage_list.frame.size.width / 2;
    userimage_list.layer.masksToBounds = YES;
    
    btn_story.layer.cornerRadius = 5.0;
    btn_story.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
