//
//  RootViewController.h
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 31/08/15.
//  Copyright (c) 2015 MaheshDhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"


@interface RootViewController : UIViewController<FBLoginViewDelegate>
{
    NSString *nibName;
    BOOL isLogedIn;
    NSURL *fbPictureURL;
    NSString *friend_id;
    FBSession *session;
    MBProgressHUD *HUD;
    NSString *fbProfilePicURL;
    NSString *f_Name,*l_Name,*email,*fbID,*gender,*username;
}


@end

