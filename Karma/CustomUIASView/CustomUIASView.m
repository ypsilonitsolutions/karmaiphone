//
//  CustomUIASView.m
//  CustomUIASView
//
//  Created by Mahesh Kumar Dhakad on 05/07/15.
//  Copyright (c) 2012 MKD. All rights reserved.
//

#import "CustomUIASView.h"


@implementation CustomUIASView


- (void)awakeFromNib {
    
    _btn_Submit.layer.cornerRadius = 3;
    _btn_Submit.layer.masksToBounds = YES;
    
    _btn_CancelBig.layer.cornerRadius = 3;
    _btn_CancelBig.layer.masksToBounds = YES;
    
    _btn_Cancel.layer.cornerRadius = 3;
    _btn_Cancel.layer.masksToBounds = YES;
    
    _view_SubContains.layer.cornerRadius = 3;
    _view_SubContains.layer.masksToBounds = YES;
    
   // _view_SubContains.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    
    _view_Contains.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;

    [super awakeFromNib];
    
}


- (id)initWithFrame:(CGRect)frame {
  
  if ((self = [super initWithFrame:frame])) {
    
      NSString *nibName=nil;
      
      if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
      {
          if ([[UIScreen mainScreen] bounds].size.height==568)
          {
              nibName=@"CustomUIASView";
          }
          else if ([[UIScreen mainScreen] bounds].size.height==480)
          {
              nibName=@"CustomUIASView";
          }
          else if ([[UIScreen mainScreen] bounds].size.height==667)
          {
              nibName=@"CustomUIASView_iPhone6";
          }
          else if ([[UIScreen mainScreen] bounds].size.height==736)
          {
              nibName=@"CustomUIASView_iPhone6Plus";
          }
      }
      else
      {
          nibName=@"CustomUIASView_iPad";
      }
     // [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:0];

      self = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] firstObject];
      
    //self.alpha  = .85;
   // [self addSubview:[[[UINib nibWithNibName:nibName bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0]];

    self.backgroundColor = [UIColor clearColor];
    
  }
  
  return self;
}


@end


