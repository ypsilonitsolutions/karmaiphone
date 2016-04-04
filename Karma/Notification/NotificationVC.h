//
//  NotificationVC.h
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 21/09/15.
//  Copyright (c) 2015 Mahesh Kumar Dhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"


@interface NotificationVC : UIViewController
{
    IBOutlet UITableView *table_noti;
    BOOL isMenuShow;
    NSString *tv_CellNibName;
    MBProgressHUD *HUD;
    NSString *currentUserId;

}

@end
