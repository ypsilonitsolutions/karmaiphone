//
//  DraggableView.h
//  testing swiping
//
//  Created by Mahesh Kumar Dhakad on 11/02/15.
//  Copyright (c) 2012 MKD. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "OverlayView.h"

@protocol DraggableViewDelegate <NSObject>

-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@end

@interface DraggableView : UIView

@property (weak) id <DraggableViewDelegate> delegate;

@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic)CGPoint originalPoint;
@property (nonatomic,strong)OverlayView* overlayView;
@property (nonatomic,strong)UILabel* information; //%%% a placeholder for any card-specific information

-(void)leftClickAction;
-(void)rightClickAction;

@end
