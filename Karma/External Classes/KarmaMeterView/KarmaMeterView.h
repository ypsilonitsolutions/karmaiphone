//
//  KarmaMeterView.h
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 02/02/16.
//  Copyright (c) 2016 MKD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
@interface KarmaMeterView : UIView

@property (nonatomic, strong) UILabel * leftLabel;
@property (nonatomic, strong) UILabel * rightLabel;
@property (nonatomic, strong) UIColor * lightColor;
@property (nonatomic, strong) UIColor * darkColor;

@property (nonatomic, assign) CGFloat progress;

@end