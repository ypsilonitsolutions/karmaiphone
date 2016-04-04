//
//  StoryTVCell.m
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 24/07/15.
//  Copyright (c) 2015 MaheshDhakad. All rights reserved.
//

#import "StoryTVCell.h"

@implementation StoryTVCell


- (void)awakeFromNib {
    // Initialization code
    [_progressView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    _btn_delete.backgroundColor=[UIColor colorWithRed:  0.941 green:0.196 blue:0.392 alpha:1];
    _btn_confid.backgroundColor=[UIColor colorWithRed:0.392 green:0.784 blue:0.941 alpha:1];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
