//
//  MenuViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2015 MaheshDhakad. All rights reserved.
//

#import "MenuViewController.h"
#import "Constant.h"

@interface MenuViewController()


@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, assign) CGFloat peekLeftAmount;
@property (nonatomic, assign) CGFloat peekRightAmount;
@property (nonatomic, strong) NSArray *arr_Images;

@end


@implementation MenuViewController
@synthesize menuItems,arr_Images;
@synthesize peekLeftAmount;
@synthesize peekRightAmount;
@synthesize tv;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    screenSize = [[UIScreen mainScreen]bounds];
    obj_NSUD =[NSUserDefaults standardUserDefaults];
    
    if (screenSize.size.height <=480){
        self = [super initWithNibName:@"MenuViewController_iPhone4" bundle:nil];
       }else if (screenSize.size.height <=568)
      {
        self = [super initWithNibName:@"MenuViewController" bundle:nil];
      }else if (screenSize.size.height <=667){
      self = [super initWithNibName:@"MenuViewController_iphone6" bundle:nil];
      }else if (screenSize.size.height <=736){
          self = [super initWithNibName:@"MenuViewController_iPhone6Plus" bundle:nil];
      }else if (screenSize.size.height <=1024)
      {
      self = [super initWithNibName:@"MenuViewController_iPad" bundle:nil];
      }
    
    return self;
}
- (void)awakeFromNib
{
    
  self.menuItems = [NSArray arrayWithObjects:@"Profile",@"Deals",@"Map",@"Help",@"Sign Out",nil];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
    
    self.peekRightAmount = 40.0f;
    obj_NSUD =[NSUserDefaults standardUserDefaults];

    
    if (screenSize.size.height <=480){
       [self.slidingViewController setAnchorRightRevealAmount:150.0f];
    }else if (screenSize.size.height <=568)
    { [self.slidingViewController setAnchorRightRevealAmount:150.0f];
    }else if (screenSize.size.height <=667){
        [self.slidingViewController setAnchorRightRevealAmount:150.0f];
    }
    else if (screenSize.size.height <=736){
        [self.slidingViewController setAnchorRightRevealAmount:200.0f];
    }
    else if (screenSize.size.height <=1024)
    {
        [self.slidingViewController setAnchorRightRevealAmount:250.0f];
    }

    
    
 
  self.slidingViewController.underLeftWidthLayout = MDFullWidth;
    if ([obj_NSUD boolForKey:@"Is LogIn"]) {
      //  self.arr_Images = [NSArray arrayWithObjects:@"home_icon.png",@"near_business_icon.png",@"favourites_icon_menu_panel.png",@"reminders_icon_menu_panel.png",@"winnings_icon_menu_panel.png",@"menu_panel_deals_icon_menu_panel.png",@"events_icon_menu_panel.png",@"jobs_icon_menu_panel.png",@"my_acount_icon.png",@"about_icon.png",@"contact_icon.png",@"share_icon.png",@"news.png",@"notification.png",@"news.png",nil];
        self.menuItems = [NSArray arrayWithObjects:@"Home",@"Search",@"Profile",@"Notifications",@"Invite Friends",@"Settings",@"Logout",nil];
    }
    else{
        // self.arr_Images = [NSArray arrayWithObjects:@"home_icon.png",@"near_business_icon.png",@"favourites_icon_menu_panel.png",@"reminders_icon_menu_panel.png",@"winnings_icon_menu_panel.png",@"menu_panel_deals_icon_menu_panel.png",@"events_icon_menu_panel.png",@"jobs_icon_menu_panel.png",@"my_acount_icon.png",@"about_icon.png",@"contact_icon.png",@"share_icon.png",@"news.png",@"notification.png",@"news.png",nil];
        self.menuItems = [NSArray arrayWithObjects:@"Home",@"Search",@"Profile",@"Notifications",@"Invite Friends",@"Settings",@"Logout",nil];
    }
   

    
    self.tv.backgroundColor =  [UIColor blackColor];
    //[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
   // [self.slidingViewController setAnchorRightPeekAmount:self.peekRightAmount];
   // self.slidingViewController.underLeftWidthLayout = ECVariableRevealWidth;
}


#pragma mark - Table View Delegate Methods
#pragma mark -
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == tableView.numberOfSections - 1)
    {
        return [UIView new];
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (section == tableView.numberOfSections - 1) {
        return 1;
        
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int a;
    if (screenSize.size.height <=480){
        a=44;
    }else if (screenSize.size.height <=568)
    {
        a=44;
    }else if (screenSize.size.height <=667){
       
        a=44;
    }else if (screenSize.size.height <=736){
        
        a=70;
    }else if (screenSize.size.height <=1024)
    {
        a=60;
    }
    return a;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return 0;//@"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = @"MenuItemCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
  }
    
    if (screenSize.size.height <=480){
        
    }else if (screenSize.size.height <=568)
    {   cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    }else if (screenSize.size.height <=667){
          cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    }else if (screenSize.size.height <=736){
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
        
    }else if (screenSize.size.height <=1024)
    {
          cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor: [UIColor blackColor]];

    cell.textLabel.textColor=[UIColor whiteColor];
    //cell.textLabel.font=[UIFont systemFontOfSize:14];
    cell.textLabel.textAlignment=NSTextAlignmentLeft;
    cell.textLabel.text = [self.menuItems objectAtIndex:indexPath.row];
    
    if (indexPath.row==3){
        
         UILabel *lbl_NotificationCounts = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 20, 20)];
        lbl_NotificationCounts.backgroundColor = [UIColor greenColor];
        lbl_NotificationCounts.textColor = [UIColor whiteColor];
        lbl_NotificationCounts.text = @"10";
        lbl_NotificationCounts.layer.cornerRadius = lbl_NotificationCounts.frame.size.width / 2;
        lbl_NotificationCounts.layer.masksToBounds = YES;
        [cell addSubview:lbl_NotificationCounts];
    }
  //  cell.imageView.image= [UIImage imageNamed:[arr_Images objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) { // Home
        
        Profile *pro=[[Profile alloc]initWithNibName:@"Profile" bundle:nil];
        pro.str_ProfileOwner = @"1";
        
        NSString *strUserid = [[NSUserDefaults standardUserDefaults] objectForKey:@"LOGIN_USER_ID"];
        
        pro.str_UserId = strUserid;
        InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        obj_ISVC.topViewController = pro;
        [self.navigationController pushViewController:obj_ISVC animated:NO];
        
    }else if (indexPath.row==1) { // Search
        
        CategoryList *obj_HVC=[[CategoryList alloc]initWithNibName:@"CategoryList" bundle:nil];
        InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        obj_ISVC.topViewController = obj_HVC;
        [self.navigationController pushViewController:obj_ISVC animated:NO];
        
       
        
    }else if (indexPath.row==2){ // Profile
        
        Profile *pro=[[Profile alloc]initWithNibName:@"Profile" bundle:nil];
        pro.str_ProfileOwner = @"1";
        
        NSString *strUserid = [[NSUserDefaults standardUserDefaults] objectForKey:@"LOGIN_USER_ID"];
        
        pro.str_UserId = strUserid;
        
        InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        obj_ISVC.topViewController = pro;
        
        [self.navigationController pushViewController:obj_ISVC animated:NO];

    }else if (indexPath.row==3){ // Notification
        
        NotificationVC *obj_HVC=[[NotificationVC alloc]initWithNibName:@"Notification" bundle:nil];
        InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        obj_ISVC.topViewController = obj_HVC;
        [self.navigationController pushViewController:obj_ISVC animated:NO];

        
    }else if (indexPath.row==4){ // Invite Friends
        
        NSMutableArray *sharingItems = [NSMutableArray new];
        
        [sharingItems addObject:@""];
        
        UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
             [self presentViewController:activityController animated:YES completion:nil];
            
        }else{
            if ( [activityController respondsToSelector:@selector(popoverPresentationController)] ) {
                
            UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityController];
                
            // UITableViewCell *clickedCell = [tableView cellForRowAtIndexPath:indexPath];
            [popup presentPopoverFromRect:btnShare.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
           }
       }
    
    }else if (indexPath.row==5) { // Settings
        
        
    }else if (indexPath.row==6) { // Logout
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Do you want logout" message:@"" delegate:self cancelButtonTitle:@"yes"otherButtonTitles:@"no", nil];
        [alert setTag:12];
        [alert show];
    }

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
            
            
           // RootViewController *second=[[RootViewController alloc]init];
            
            //[self.navigationController pushViewController:second animated:NO];
            
            [self.navigationController popToRootViewControllerAnimated:NO];

        }else{
            
            
            
        }
    }
    if ([alertView tag] == 13) {
        if (buttonIndex == 0) {
            
            
        }else{
            
        }

    }
}


-(void)fb_Logout
{
    [FBSession.activeSession closeAndClearTokenInformation];
    [FBSession.activeSession close];
}



@end
