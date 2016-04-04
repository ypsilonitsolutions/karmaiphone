//
//  OverlayView.h
//  testing swiping
//
//  Created by Mahesh Kumar Dhakad on 11/02/15.
//  Copyright (c) 2012 MKD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger , GGOverlayViewMode) {
    GGOverlayViewModeLeft,
    GGOverlayViewModeRight
};
@interface OverlayView : UIView
@property (nonatomic) GGOverlayViewMode mode;
@property (nonatomic, strong) UIImageView *imageView;
@end
