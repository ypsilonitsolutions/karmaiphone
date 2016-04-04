//
//  MenuViewController.h
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2015 MaheshDhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDSlidingViewController.h"
#import "Constant.h"
@class Categorylist;

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

{
    CGRect screenSize;
    NSUserDefaults *obj_NSUD;
    int PrevScreen;
   IBOutlet UIButton *btnShare;
    
}

@property (nonatomic, retain)  Categorylist *obj_HVC;
@property (nonatomic, retain) IBOutlet UITableView *tv;



@end
