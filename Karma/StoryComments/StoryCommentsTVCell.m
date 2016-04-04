//
//  StoryCommentsTVCell.m
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 21/01/16.
//  Copyright © 2016 Mahesh Kumar Dhakad. All rights reserved.
//

#import "StoryCommentsTVCell.h"
#import "Constant.h"
@implementation StoryCommentsTVCell

- (void)awakeFromNib {
    // Initialization code
    _btn_StoryShare.layer.cornerRadius = 3;
    _btn_StoryShare.layer.masksToBounds = YES;

    
    _imageView_StoryUser.layer.cornerRadius = _imageView_StoryUser.frame.size.width / 2;
    _imageView_StoryUser.layer.masksToBounds = YES;
    
    _imageView_CommentUser.layer.cornerRadius = _imageView_CommentUser.frame.size.width / 2;
    _imageView_CommentUser.layer.masksToBounds = YES;
    
    [self  setSelectionStyle:UITableViewCellSelectionStyleNone];

    _btn_delete.backgroundColor=[UIColor colorWithRed:  0.941 green:0.196 blue:0.392 alpha:1];
    _btn_confidential.backgroundColor=[UIColor colorWithRed:0.392 green:0.784 blue:0.941 alpha:1];
    
    
    // For set Border
    
   // [self.contentView.layer addSublayer:[WebService setBorderWithFrame:CGRectMake(0.0f, 0, self.frame.size.width, 1.0f) andColor:[WebService colorWithHexString:@"d8d8d8"]]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    [self  setSelectionStyle:UITableViewCellSelectionStyleNone];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews]; //<-THIS LINE YOU NEED
    //own code continues here
    
}

@end
