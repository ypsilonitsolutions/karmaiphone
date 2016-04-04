//
//  NotificationVC.m
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 21/09/15.
//  Copyright (c) 2015 Mahesh Kumar Dhakad. All rights reserved.
//

#import "NotificationVC.h"

@interface NotificationVC ()
{
    NSMutableArray *Array_noti,*arrayTVData;
    IBOutlet UIButton *btn_clear;
    //IBOutlet UITableView *table_noti;
     NSString *nibName;
}
@end

@implementation NotificationVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"Notification";
            tv_CellNibName = @"NotificationTVCell";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"Notification";
            tv_CellNibName = @"NotificationTVCell" ;
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"Notification_iPhone6";
            tv_CellNibName = @"NotificationTVCell_iPhone6" ;
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"Notification_iPhone6";
            tv_CellNibName = @"NotificationTVCell_iPhone6Plus" ;
        }
    }
    else
    {
        nibName=@"Notification_iPad";
        tv_CellNibName = @"NotificationTVCell_iPad" ;
    }
    
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self add_ProgressBar];
    btn_clear.backgroundColor = [UIColor colorWithRed:0.663 green:0.663 blue:0.659 alpha:1];
    btn_clear.layer.cornerRadius=4;
    btn_clear.layer.masksToBounds=YES;

    currentUserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"LOGIN_USER_ID"];

    [self get_NotificationList];

    //NSUserDefaults *VIP =[NSUserDefaults standardUserDefaults];
   // NSString *aa = [VIP valueForKey:@"LOGIN_USER_ID"];
        
   // [self Method_First];
}

-(void)viewWillLayoutSubviews{
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    
   // [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
}
- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:MDRight];
}



-(IBAction)action_Search:(id)sender{
  
    CategoryList *obj_HVC=[[CategoryList alloc]initWithNibName:@"CategoryList" bundle:nil];
    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_ISVC.topViewController = obj_HVC;
    [self.navigationController pushViewController:obj_ISVC animated:NO];
}


-(void)add_ProgressBar
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.tag = 444;
    HUD.square = YES;
    [self.view addSubview:HUD];
    //HUD.labelText = @"Loading...";
    //HUD.detailsLabelText = @"Pdf..";
    
}


#pragma mark - clear_NotificationList
#pragma mark -

-(IBAction)action_Clear:(id)sender{
    
    [self clear_NotificationList];
}


-(void)clear_NotificationList{

    NSUserDefaults *VIP =[NSUserDefaults standardUserDefaults];
    NSString *userId = [VIP valueForKey:@"LOGIN_USER_ID"];
    
    [HUD show:YES];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:userId forKey:@"userId"];

    WebService *api=[[WebService alloc] init];
    
    [api call_API:nil andURL:CLEAR_NOTIFICATIONS andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
        [HUD hide:YES];
        
        [arrayTVData removeAllObjects];
        [Array_noti removeAllObjects];
        [table_noti reloadData];

    }];
    

}

#pragma mark - get_NotificationList
#pragma mark -

-(void)get_NotificationList{
    
    [HUD show:YES];
    
    Array_noti=[[NSMutableArray alloc]init];
    arrayTVData=[[NSMutableArray alloc]init];

    WebService *api=[[WebService alloc] init];
    
    [api call_API:nil andURL:GET_NOTIFICATIONS andVC:self  OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
        [HUD hide:YES];
        
        NSArray *Arr_Response = response ;
        
        int maincount = (int)[Arr_Response count];
        
        if(maincount == 0){
            
            //_AlertView_WithOut_Delegate(@"",@"No data found",@"Ok", nil);
            return;
            
        }else{
            
            arrayTVData = [response mutableCopy];
            
            for (int i =0; i<[Arr_Response count]; i++)
            {
                NSDictionary *dict=[Arr_Response objectAtIndex:i];
                ModelClass *obj=[[ModelClass alloc]init];
                
                obj.N_content=[NSString stringWithFormat:@"%@",[dict valueForKey:@"content"]];
                obj.N_create=[NSString stringWithFormat:@"%@",[dict valueForKey:@"created"]];
                int dt = (int)obj.N_create;
                NSDate *date = [NSDate dateWithTimeIntervalSinceNow:(dt / 1000.0)];
                NSLog(@"%@",date);
                
                obj.N_noti=[NSString stringWithFormat:@"%@",[dict valueForKey:@"notificationId"]];
                
                NSArray *userBySubjectUserId =[dict objectForKey:@"userBySubjectUserId"];
                
                obj.N_email=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"email"]];
                obj.N_fname=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"firstName"]];
                obj.N_lname=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"lastName"]];
                obj.N_propics=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"profilePicUrl"]];
                NSLog(@"obj.N_propics=%@",obj.N_propics);
                obj.N_story=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"stories"]];
                obj.N_userid=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"userId"]];
                obj.N_privacy=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"privacy"]];
                obj.N_karma=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"karma"]];
                obj.N_follows=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"followers"]];
                //  obj.sub_user_karma=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"profilePicUrl"]];
                
                [Array_noti addObject:obj];
                
            }
            
            [table_noti reloadData];

        }
    }];
    
}





-(void)fb_Logout{
    
}



-(IBAction)Logout:(id)sender{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Do you want logout" message:@"" delegate:self cancelButtonTitle:@"yes"otherButtonTitles:@"no", nil];
    [alert setTag:12];
    [alert show];
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 12) {
        // it's the Error alert
        if (buttonIndex == 0) {     // and they clicked OK.
            [self fb_Logout];
            NSUserDefaults *VIP=[NSUserDefaults standardUserDefaults];
            [VIP setObject:nil forKey:@"current_emai"];
            [VIP setObject:nil forKey:@"LOGIN_USER_ID"];
            [VIP setObject:nil forKey:@"current_fname"];
            [VIP setObject:nil forKey:@"current_follows"];
            [VIP setObject:nil forKey:@"current_karma"];
            [VIP setObject:nil forKey:@"current_lname"];
            [VIP setObject:nil forKey:@"current_privacy"];
            [VIP setObject:nil forKey:@"current_profilePicUrl"];
            [VIP setObject:nil forKey:@"current_stories"];
            
            
            RootViewController *second=[[RootViewController alloc]init];
            
            // [self.navigationController pushViewController:second animated:YES];
            [UIView animateWithDuration:0.75
                             animations:^{
                                 [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                                 [self.navigationController pushViewController:second animated:NO];
                                 [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
                                 
                             }];
        }else{
            
            
        }
    }
    
    
}

-(IBAction)action_ShowMyProfile:(id)sender
{
    Profile *pro=[[Profile alloc]initWithNibName:@"Profile" bundle:nil];
    pro.str_ProfileOwner = @"1";
   
    pro.str_UserId = currentUserId;
    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_ISVC.topViewController = pro;
    [self.navigationController pushViewController:obj_ISVC animated:NO];
}





-(void)Method_First{
   // [self progressBar];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:@"get_sectors" forKey:@"rquest"];
    
    
    WebService *api = [WebService alloc];
    
    
    [api call_API:dict andURL:BASE_URL andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {
        
        
        NSDictionary *dictResponse = response;
        
        NSArray *msgarr=[dictResponse objectForKey:@"sectors"];
        NSArray *Array_represent=[dictResponse objectForKey:@"representatives"];
        
        for (int i =0; i<[msgarr count]; i++) {
            NSDictionary *dict=[msgarr objectAtIndex:i];
            
            //arr=[msgarr valueForKey:@"image"];
            
            ModelClass *obj=[[ModelClass alloc]init];
            
            obj.sector__id=[NSString stringWithFormat:@"%@",[dict valueForKey:@"sectors_id"]];
            obj.sector_image=[NSString stringWithFormat:@"%@",[dict valueForKey:@"sectors_image"]];
            obj.sector_sub_title=[NSString stringWithFormat:@"%@",[dict valueForKey:@"sectors_sub_title"]];
            obj.sector_title=[NSString stringWithFormat:@"%@",[dict valueForKey:@"sectors_title"]];
            obj.sectors_status=[NSString stringWithFormat:@"%@",[dict valueForKey:@"sectors_status"]];
            
            [Array_noti addObject:obj];
        }
        for (int i =0; i<[Array_represent count]; i++) {
            NSDictionary *dict=[Array_represent objectAtIndex:i];
            
            //arr=[msgarr valueForKey:@"image"];
            
            ModelClass *obj=[[ModelClass alloc]init];
            
            obj.rep_id=[NSString stringWithFormat:@"%@",[dict valueForKey:@"respresentatives_id"]];
            obj.rep_image=[NSString stringWithFormat:@"%@",[dict valueForKey:@"respresentatives_image"]];
            obj.rep_active=[NSString stringWithFormat:@"%@",[dict valueForKey:@"respresentatives_isActive"]];
            obj.rep_msg=[NSString stringWithFormat:@"%@",[dict valueForKey:@"respresentatives_message"]];
            obj.rep_title=[NSString stringWithFormat:@"%@",[dict valueForKey:@"respresentatives_category_name"]];
            
          //  [Array_Seconddata addObject:obj];
            
        }
        
        
       // [HUD hide:YES];
        
        [table_noti reloadData];
        
    }];
}


#pragma mark - UITableView Delegate
#pragma mark -


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int a;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone || [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {    // The iOS device = iPhone or iPod Touch
        
        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        
        if (iOSDeviceScreenSize.height == 1024)
        {
            a=90;
        }else if (iOSDeviceScreenSize.height == 667){
            a=84;
        }else if (iOSDeviceScreenSize.height == 736){
            a=84;
        }else{
            a=72;
        }
        
    }
    
    return a;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Array_noti count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NotificationTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil){
        
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:tv_CellNibName owner:self options:nil];
                cell = [nib objectAtIndex:0];
    }
    
    ModelClass *obj = [Array_noti objectAtIndex:indexPath.row];
    
    
    NSString *createdate = obj.N_create;
    
    double dd1=[createdate longLongValue];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(dd1 / 1000.0)];
    NSString *timeAgoDate = [self timeAgoStringFromDate:date];
    
    cell.date.text = timeAgoDate;
    
    cell.lblname.text= [NSString stringWithFormat:@"%@ %@",obj.N_fname,obj.N_lname];

    cell.lbl_post.text= obj.N_content;
    
   
    cell.lbl_Karma.text = obj.N_karma;
    //cell.img_notiuser.image=[UIImage imageNamed:obj.N_propics];
    NSURL *URL=[NSURL URLWithString:obj.N_propics];
    
  //  [cell.img_notiuser setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"default_user_icon.png"]];
    if ([obj.N_propics length] > 0) {
      //  cell.img_notiuser.image  = nil;
        cell.img_notiuser.imageURL = URL;
    }
    

    cell.img_notiuser.contentMode = UIViewContentModeScaleAspectFill;
     [cell.btnShowProfile setTag:indexPath.row];
     [cell.btnShowProfile addTarget:self action:@selector(action_ShowProfile:) forControlEvents:UIControlEventTouchUpInside];
    NSString *karmaMeterValue = obj.N_karma;
    
    if([karmaMeterValue intValue] > 0){
        
        cell.imageView_BG.image=[UIImage imageNamed:@"blue_user_image_default.png"];
        [cell.lbl_Karma setTextColor:[UIColor whiteColor]];
        
        cell.imageView_BG.transform = CGAffineTransformMakeRotation(-[karmaMeterValue floatValue] * M_PI/180);

    }else if([karmaMeterValue intValue] < 0){
        
        cell.imageView_BG.image=[UIImage imageNamed:@"pink_user_image_default.png"];
        [cell.lbl_Karma setTextColor:[UIColor whiteColor]];
        
        cell.imageView_BG.transform = CGAffineTransformMakeRotation(-[karmaMeterValue floatValue] * M_PI/180);

        
    }else{
        
        cell.imageView_BG.image=[UIImage imageNamed:@"rad_blue_border_img.png"];
        [cell.lbl_Karma setTextColor:[UIColor blackColor]];
        
    }

    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *index = [arrayTVData objectAtIndex:indexPath.row];
    
    
    if([[index valueForKey:@"story"] isEqual:[NSNull null]]){
        ModelClass *obj= [Array_noti objectAtIndex:indexPath.row];
        Profile *pro=[[Profile alloc]initWithNibName:@"Profile" bundle:nil];
        //NSArray *obj1 = [arrayStoryComments objectAtIndex:Btnid.tag];
        
        
       // NSArray *user =obj.N_userid;
        
        NSString *strUserid=obj.N_userid;
        pro.str_ProfileOwner = @"0";
        
        pro.str_UserId=strUserid;
        InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        obj_ISVC.topViewController = pro;
        [self.navigationController pushViewController:obj_ISVC animated:NO];
//        Modelclass *obj= [Array_noti objectAtIndex:indexPath.row];
//        NSString *currentuserid = obj.N_userid;
//        
//        StroyViewController *obj_HVC=[[StroyViewController alloc]initWithNibName:@"StroyViewController" bundle:nil];
//        obj_HVC.currentsearch_userid = currentuserid;
//        obj_HVC.currentsearch_demo= @"story_by_userID";
//        obj_HVC.getStoryURL = BASE_URL_STROYSHOW;
//        obj_HVC.getStoryByUserId = obj.N_userid;
//        
//        InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
//        obj_ISVC.topViewController = obj_HVC;
//        [self.navigationController pushViewController:obj_ISVC animated:NO];
        
    }else{
        
        NSArray *arrStory = [index valueForKey:@"story"];
        
        [self goes_ToStoryDetails:arrStory];

        /*
        NSString *storyID =   [arrStory valueForKey:@"storyId"];
        
        StoryViewController *obj_HVC=[[StoryViewController alloc]initWithNibName:@"StoryViewController" bundle:nil];
        obj_HVC.currentsearch_userid = storyID;
        obj_HVC.currentsearch_demo= @"story_by_storyID";
        obj_HVC.getStoryURL = GET_STORIES;
        obj_HVC.getStoryByStoryId = storyID;
        
        InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        obj_ISVC.topViewController = obj_HVC;
        [self.navigationController pushViewController:obj_ISVC animated:NO];
        */
    }
}



- (NSString *)timeAgoStringFromDate:(NSDate *)date {
    
    NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:date toDate:now options:0];
    
    if (components.year > 0) {
        formatter.allowedUnits = NSCalendarUnitYear;
    } else if (components.month > 0) {
        formatter.allowedUnits = NSCalendarUnitMonth;
    } else if (components.weekOfMonth > 0) {
        formatter.allowedUnits = NSCalendarUnitWeekOfMonth;
    } else if (components.day > 0) {
        formatter.allowedUnits = NSCalendarUnitDay;
    } else if (components.hour > 0) {
        formatter.allowedUnits = NSCalendarUnitHour;
    } else if (components.minute > 0) {
        formatter.allowedUnits = NSCalendarUnitMinute;
    } else {
        formatter.allowedUnits = NSCalendarUnitSecond;
    }
    
    NSString *formatString = NSLocalizedString(@"%@ ago", @"Used to say how much time has passed. e.g. '2 hours ago'");
    
    return [NSString stringWithFormat:formatString, [formatter stringFromDateComponents:components]];
}

-(void)goes_ToStoryDetails:(NSArray *)createdStory{
    
    NSString *goodVotes = [NSString stringWithFormat:@"%@",[createdStory valueForKey:@"goodVotes"]];
    NSString *badVotes = [NSString stringWithFormat:@"%@",[createdStory valueForKey:@"badVotes"]];
    
    NSString *str_KarmaMeterPercent = [self get_KarmaMeterPercent_byGoodVotes:[goodVotes intValue] andBadVotes:[badVotes intValue]];
    
    float percent =[str_KarmaMeterPercent floatValue];
    
    NSString *karmaMeterPercent = [NSString stringWithFormat:@"%f",percent];
    
    NSArray *userByAuthorUserId =[createdStory valueForKey:@"userByAuthorUserId"];
    
    NSString *storyUserID = [NSString stringWithFormat:@"%@",[userByAuthorUserId valueForKey:@"userId"]];
    
    StoryCommentsVC *storyCommentsVC=[[StoryCommentsVC alloc]initWithNibName:@"StoryCommentsVC" bundle:nil];
    
    storyCommentsVC.arrayStory = createdStory;
    storyCommentsVC.karmaMeterPercent = karmaMeterPercent;
    storyCommentsVC.str_UserId = storyUserID;
    [self.navigationController pushViewController:storyCommentsVC animated:NO];
}

#pragma mark - Get Karma Meter Percent Methods
#pragma mark -


-(NSString *)get_KarmaMeterPercent_byGoodVotes:(int)goodVotes andBadVotes:(int)badVotes{
    
    float totalVotes = goodVotes + badVotes;
    
    NSString *karmaMeterValue;
    
    if(totalVotes == 0)
    {
        karmaMeterValue = [NSString stringWithFormat:@"50"];
        
    }else{
        
        NSString *sum=[NSString stringWithFormat:@"%f",(goodVotes/totalVotes)];
        
        float cn =[sum floatValue];
        
        int roundedUp = roundf((((cn*100)-50)*2));
        
        karmaMeterValue =[NSString stringWithFormat:@"%i",roundedUp];
        
        if ([karmaMeterValue intValue] == 0) {
            
            karmaMeterValue = [NSString stringWithFormat:@"50"];
            
        } else if([karmaMeterValue intValue] > 0) {
            
            
        }else{
            
            karmaMeterValue = [karmaMeterValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }
    }
    
    return karmaMeterValue;
}

#pragma mark - action_ShowProfile Methons
#pragma mark -

-(void)action_ShowProfile:(UIButton*)sender{
    
    UIButton *abc=(UIButton *)sender;
    
    NSInteger i=abc.tag;
    
    ModelClass *obj=[Array_noti objectAtIndex:i];
    
    Profile *pro=[[Profile alloc]initWithNibName:@"Profile" bundle:nil];
    
    // Profile *pro=[[Profile alloc]init];
    pro.str_UserId=obj.N_userid;
    pro.str_ProfileOwner = @"0";

    // pro.user_userId1=obj.S_userid;
    
    // second.user_stories=[dict valueForKey:@"stories"];
    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_ISVC.topViewController = pro;
    [self.navigationController pushViewController:obj_ISVC animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
