//
//  CardView.m
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 11/02/15.
//  Copyright (c) 2012 MKD. All rights reserved.
//

#import "CardView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CardView


- (id)initWithFrame:(CGRect)frame
{
    
    if ((self = [super initWithFrame:[[UIScreen mainScreen] bounds]])) {
        
        if (self)
        {
            NSArray *nib;
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
            {
                if ([[UIScreen mainScreen] bounds].size.height==480){
                    
                    nib= [[NSBundle mainBundle]loadNibNamed:@"CardView_iPhone4"owner:self options:nil];
                    
                }else if ([[UIScreen mainScreen] bounds].size.height==568){
                    
                    nib= [[NSBundle mainBundle]loadNibNamed:@"CardView"owner:self options:nil];
                    
                }else if ([[UIScreen mainScreen] bounds].size.height==667){
                    
                    nib= [[NSBundle mainBundle]loadNibNamed:@"CardView_iPhone6"owner:self options:nil];
                    
                }else if ([[UIScreen mainScreen] bounds].size.height==736){
                    
                    nib= [[NSBundle mainBundle] loadNibNamed:@"CardView_iPhone6Plus" owner:self options:nil];
                }
                
            }else{
                
                nib= [[NSBundle mainBundle]loadNibNamed:@"CardView_iPad"owner:self options:nil];
            }

            
            self = [nib objectAtIndex:0];
        }
    }
    
    return self;
}



- (void)awakeFromNib {
    
    // Initialization code
    self.userimage.layer.cornerRadius = self.userimage.frame.size.width / 2;
    self.userimage.layer.masksToBounds = YES;
    _btn_story.layer.cornerRadius = 3;
    _btn_story.layer.masksToBounds = YES;
    
}




@end
