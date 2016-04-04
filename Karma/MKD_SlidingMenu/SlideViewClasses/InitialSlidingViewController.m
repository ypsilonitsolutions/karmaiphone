//
//  InitialSlidingViewController.m
//  MDSlidingViewController
//
//  Created by Mahesh Kumar Dhakad on 12/23/12.
//  Copyright (c) 2012 MKD. All rights reserved.
//

#import "InitialSlidingViewController.h"

@implementation InitialSlidingViewController

- (void)viewDidLoad {
    
  [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
 }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
  return YES;
}

@end
