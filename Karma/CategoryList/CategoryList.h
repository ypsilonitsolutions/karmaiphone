//
//  CategoryList.h
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 01/09/15.
//  Copyright (c) 2015 MaheshDhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface CategoryList : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSString *nibName;
    NSString *categoryCellNibName;

    UITableView *autocomplete;
    NSString *searchstring;
    MBProgressHUD *HUD;
    NSString *currentUserId;

    BOOL isMenuShow;
}


@property (strong,nonatomic) IBOutlet UITableView *tv_Search;
@property(strong,nonatomic)IBOutlet UITextField *txt_search;

@property (weak, nonatomic)  UISearchDisplayController *searchdisplaycontroller;

@end
