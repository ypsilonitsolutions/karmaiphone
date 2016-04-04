//
//  StoryCommentTVCell.m
//  CollectionViewWithTAbleview
//
//  Created by admin on 18/09/15.
//  Copyright (c) 2015 ypsilon. All rights reserved.
//

#import "StoryCommentTVCell.h"

@implementation StoryCommentTVCell

- (void)awakeFromNib {
    // Initialization code
    
    self.img_user.layer.cornerRadius = self.img_user.frame.size.width / 2;
    self.img_user.clipsToBounds = YES;
    
    self.btn_comment.layer.cornerRadius = 4;
    self.btn_comment.layer.masksToBounds = YES;
    self.btn_comment.backgroundColor=[UIColor colorWithRed:0.663 green:0.663 blue:0.659 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

}

@end
