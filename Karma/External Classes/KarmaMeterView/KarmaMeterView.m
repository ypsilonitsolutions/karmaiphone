//
//  KarmaMeterView.m
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 02/02/16.
//  Copyright (c) 2016 MKD. All rights reserved.
//

#import "KarmaMeterView.h"

@interface KarmaMeterView()

@property (nonatomic, assign) UIColor *textColor;


@end

@implementation KarmaMeterView



- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        _textColor = [UIColor whiteColor];
        
        
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.opaque = NO;
        _leftLabel.backgroundColor = [UIColor clearColor];
        _leftLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _leftLabel.textColor = _textColor;
        [self addSubview:_leftLabel];
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.opaque = NO;
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _rightLabel.textColor = _textColor;
        [self addSubview:_rightLabel];

    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        _textColor = [UIColor blackColor];
        
        
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.opaque = NO;
        _leftLabel.backgroundColor = [UIColor clearColor];
        _leftLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _leftLabel.textColor = _textColor;
        [self addSubview:_leftLabel];
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.opaque = NO;
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _rightLabel.textColor = _textColor;
        [self addSubview:_rightLabel];

        
    }
    return self;
}

-(void) layoutSubviews
{    
    CGFloat leftLabelMargin = 20;
    CGFloat leftLabelWidth = 100;
    
   CGRect _leftLabelRect = CGRectMake(leftLabelMargin,0, leftLabelWidth, self.bounds.size.height);
    
    _leftLabel.frame = _leftLabelRect;
    
    CGFloat rightLabelWidth = 100;

    CGFloat  rightLabelMargin = (self.bounds.size.width-rightLabelWidth)-20;

   CGRect _rightLabelRect = CGRectMake(rightLabelMargin,0, rightLabelWidth, self.bounds.size.height);
    _rightLabel.frame = _rightLabelRect;

}

// Replace drawRect with the following
-(void) drawRect:(CGRect)rect
{
    UIBezierPath *fillPath = [UIBezierPath bezierPathWithRect:rect];
    [[UIColor whiteColor] setFill];
    [fillPath fill];
    
    CGRect progressRect = rect;
    progressRect.size.width = progressRect.size.width * (_progress);
    
    UIBezierPath *percentagePath = [UIBezierPath bezierPathWithRect:progressRect];
    [[WebService colorWithHexString:@"F03264"] setFill];
    [percentagePath fill];
    
    
    CGRect progressBG = rect;
    progressBG.origin.x = progressBG.size.width * _progress;
    progressBG.size.width = progressBG.size.width * (1.0-_progress);

    UIBezierPath *percentagePathBG = [UIBezierPath bezierPathWithRect:progressBG];
    [[WebService colorWithHexString:@"64C8F0"] setFill];
    [percentagePathBG fill];


}

@end
