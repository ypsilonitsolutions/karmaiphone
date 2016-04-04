//
//  UnderRightViewController.m
//  MDSlidingViewController
//
//  Created by Mahesh Kumar Dhakad on 12/23/12.
//  Copyright (c) 2015 MaheshDhakad. All rights reserved.
//

#import "UnderRightViewController.h"

@interface UnderRightViewController()

@property (nonatomic, assign) CGFloat peekLeftAmount;

@end

@implementation UnderRightViewController

@synthesize peekLeftAmount;

@synthesize imgView_Profile,lbl_ProfileName;

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.peekLeftAmount = 40.0f;
  [self.slidingViewController setAnchorLeftPeekAmount:self.peekLeftAmount];
  self.slidingViewController.underRightWidthLayout = MDVariableRevealWidth;
    
    

    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString *str_UserName=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserName"];
    
    if (str_UserName) {
        self.lbl_ProfileName.text = str_UserName;

    }else{
        self.lbl_ProfileName.text = @"User Name";
    }

}



#pragma mark - Button Action Methods
#pragma mark -


-(IBAction)action_ProfileSetting:(id)sender
{
    //ProfileSettingViewController *obj_PSVC=[[ProfileSettingViewController alloc]initWithNibName:@"ProfileSettingViewController" bundle:nil];
    
    //[self.navigationController pushViewController:obj_PSVC animated:YES];
    
}

-(IBAction)action_PayVKCase:(id)sender
{
    
}

-(IBAction)action_OrderHistory:(id)sender
{
    
}

-(IBAction)action_Logout:(id)sender
{
   // HomeViewController *obj_HVC=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    
    //[self.navigationController pushViewController:obj_HVC animated:YES];
    
}



@end
