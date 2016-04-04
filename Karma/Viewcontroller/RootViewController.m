//
//  RootViewController.m
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 31/08/15.
//  Copyright (c) 2015 MaheshDhakad. All rights reserved.
//
// FB SDK


#import "RootViewController.h"

@interface RootViewController ()
{
    BOOL isLoginWantWithFB;
    BOOL isFBLoginInSettings;
    NSString *_signInAuthStatus;
    IBOutlet UIImageView *rightimage;
    
    NotificationVC *notification;
    CategoryList *categoryList;
    UIButton *shadow;
}

@property (strong, nonatomic) ACAccount *facebookAccount;
@property (strong, nonatomic) ACAccountType *facebookAccountType;
@property (strong, nonatomic) ACAccountStore *accountStore;

@property (nonatomic, strong) FBLoginView *_fbloginView;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;

@end

@implementation RootViewController


#pragma mark - View Life Cycle
#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    nibName=nil;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"RootViewController";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"RootViewController";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"RootViewController_iPhone6";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"RootViewController_iPhone6";
        }
    }
    else
    {
        nibName=@"RootViewController_iPad";

    }
    
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    rightimage.backgroundColor=[UIColor colorWithRed:0.392 green:0.784 blue:0.941 alpha:1];
    
   // setup FbLoginView
    __fbloginView = [[FBLoginView alloc] init];
    __fbloginView.frame = CGRectOffset(__fbloginView.frame, 5, 5);
    __fbloginView.delegate = self;
    [self.view addSubview:__fbloginView];
    [__fbloginView sizeToFit];
    [__fbloginView setHidden:true];
    
   
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self autoLogin_Check];
}

#pragma mark - autoLogin_Check Methods
#pragma mark -

-(void)autoLogin_Check{
    
    NSUserDefaults *nsud =[NSUserDefaults standardUserDefaults];
    NSString *loginUserID= [nsud objectForKey:@"LOGIN_USER_ID"];
    NSString *devicetoken= [nsud objectForKey:@"GCMId"];

    if (loginUserID==nil) {
        
        
    }else{
        
        [self progressBar];
        
        email = [nsud valueForKey:@"current_emai"];
        fbID = [nsud valueForKey:@"facebookid1"];
        f_Name = [nsud valueForKey:@"current_fname"];
        l_Name = [nsud valueForKey:@"current_lname"];
        fbProfilePicURL = [nsud valueForKey:@"current_profilePicUrl"];

        // Call the API
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setValue:email forKey:@"email"];
        [dict setValue:fbID forKey:@"device.facebookId"];
        [dict setValue:f_Name forKey:@"firstName"];
        [dict setValue:l_Name forKey:@"lastName"];
        [dict setValue:fbProfilePicURL forKey:@"profilePicUrl"];
        [dict setValue:@"iphone" forKey:@"device.platform"];
        [dict setValue:devicetoken forKey:@"device.token"];
        //[dict setValue:@"031110a45662027d71b57e8326da3f28ffd50f251fdba26b1973bc1c4eee955" forKey:@"device.token"];
        
       // "device.facebookId" = 946532398718857;

        [self call_LoginAPI:dict];

    }
    
}

#pragma mark - FB Methods
#pragma mark -

-(IBAction)action_SignupWithFacebook:(id)sender{

    //[FBSession.activeSession closeAndClearTokenInformation];
    isLoginWantWithFB = true;
    
    for(id object in __fbloginView.subviews){
        if([[object class] isSubclassOfClass:[UIButton class]]){
            UIButton* button = (UIButton*)object;
            [button sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }
}


#pragma mark - FB Delegate App Methods
#pragma mark -

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    if (isLoginWantWithFB==true) {
        
        isLoginWantWithFB = false;
        
    [FBRequestConnection startWithGraphPath:@"/me"
                                 parameters:@{@"fields": @"email,name,first_name,last_name"}
                                 HTTPMethod:@"GET"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              )
     {
         NSDictionary *fbData1 = (NSDictionary *)result;
         email=fbData1 [@"email"];
         fbID=fbData1 [@"id"];
         f_Name=fbData1 [@"first_name"];
         l_Name=fbData1[@"last_name"];
         fbPictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1",fbID]];
         [self Func_pic];
       }];
    }
    
}


-(void)Func_pic{
    
  NSString *sstr =[NSString stringWithFormat:@"/%@/picture",fbID];
    
  FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                              initWithGraphPath:sstr
                              parameters:@{@"redirect": @"false",@"type": @"large"}
                              HTTPMethod:@"GET"];
  [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                      id result,
                                      
                                      NSError *error) {
    
    if(result)
    {
        NSDictionary *dictResponse = result;
        
        NSDictionary *data =[dictResponse objectForKey:@"data"];
        
        fbProfilePicURL =[data objectForKey:@"url"];
        [self Func_Login];
    }
    
  }];

    
    
}

-(void)fb_Logout
{
   [FBSession.activeSession closeAndClearTokenInformation];
   [FBSession.activeSession close];
}

-(void)get_FB_Friends{
  
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/{friend-list-id}"
                                  parameters:@{@"redirect": @"false"}
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        // Handle the result
    }];
    
    
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    FBRequest *friendsRequest = [FBRequest requestForMyFriends];
//    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection, NSDictionary* result, NSError *error) {
//        
//        NSArray* friends = [result objectForKey:@"data"];
//        NSLog(@"Found: %lu friends", (unsigned long)friends.count);
//        friend_id=@"";
//        NSString *friend_name=@"";
//        NSString *friend_pics=@"";
//        NSString *friend_email=@"";
//        
//        if (friends.count==0) {
//            
//            // [self Func_Login];
//            [defaults setObject:friend_id forKey:@"facebook_frnd_id"];
//            
//        }else{
//                       for (NSDictionary<FBGraphUser>* friend in friends) {
//                NSLog(@"I have a friend named %@ with id %@", friend.name, friend.objectID);
//                
//           
//                
//                
//                
//                friend_id=[friend_id stringByAppendingString:friend.objectID];
//                friend_id=[friend_id stringByAppendingString:@","];
//                
//               
//                friend_name=[friend_name stringByAppendingString:friend.name];
//                friend_name=[friend_name stringByAppendingString:@","];
//               
//                
//                
//               // [Arr_alldata1 addObject:c];
//               // [Arr_alldata1 addObject:friend_id];
//               //[Arr_alldata1 addObject:friend_name];
//                           
//            }
//            
//            
//            if ([friend_id length]>0) {
//                
//                friend_id=[friend_id substringToIndex:[friend_id length]-1];
//                
//                friend_name=[friend_name substringToIndex:[friend_name length]-1];
//                
//                
//                [defaults setObject:friend_id forKey:@"facebook_frnd_id"];
//                [defaults setObject:friend_name forKey:@"facebook_frnd_name"];
//            }
//          //  [self Func_Login];
//            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//            
//            NSUserDefaults *VIP =[NSUserDefaults standardUserDefaults];
//           NSString *currentuserfaceid = [VIP valueForKey:@"current_userid"];
//            [dict setValue:currentuserfaceid forKey:@"userId"];
//            [dict setValue:friend_id forKey:@"facebookId"];
//            
//            
//            WebService *obj=[[WebService alloc] init];
//            [obj callWebservice:dict : self :BASE_FRDSLIST :@"frds"];
//            
//        }
//    }];
//    
}

-(void)progressBar
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.tag = 444;
    HUD.square = YES;
    [HUD show:YES];
    [self.view addSubview:HUD];
    //HUD.labelText = @"Loading...";
    //HUD.detailsLabelText = @"Pdf..";
}


///Webservice
-(void)Func_Login{
    
    [self progressBar];
    
    NSUserDefaults *nsud = [NSUserDefaults standardUserDefaults];
    NSString *devicetoken= [nsud objectForKey:@"GCMId"];

    [nsud setObject:fbID forKey:@"facebookid"];
    [nsud setObject:email forKey:@"current_emai"];
    [nsud setObject:fbID forKey:@"facebookid1"];
    [nsud setObject:f_Name forKey:@"current_fname"];
    [nsud setObject:l_Name forKey:@"current_lname"];
    [nsud setObject:fbProfilePicURL forKey:@"current_profilePicUrl"];
    
     // Call the API
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:email forKey:@"email"];
    [dict setValue:fbID forKey:@"device.facebookId"];
    [dict setValue:f_Name forKey:@"firstName"];
    [dict setValue:l_Name forKey:@"lastName"];
    [dict setValue:fbProfilePicURL forKey:@"profilePicUrl"];
    [dict setValue:@"iphone" forKey:@"device.platform"];
    [dict setValue:devicetoken forKey:@"device.token"];
    //[dict setValue:@"031110a45662027d71b57e8326da3f28ffd50f251fdba26b1973bc1c4eee955" forKey:@"device.token"];
    
    [self call_LoginAPI:dict];

    
}

#pragma mark - call_LoginAPI Methods
#pragma mark -

-(void)call_LoginAPI:(NSMutableDictionary *)dict{
    
    WebService *api = [[WebService alloc] init];
    
    [api call_API:dict andURL:LOGIN andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
        NSString *status=[response valueForKey:@"status"];
        
        if([status isEqualToString:@"0"])
        {
            NSString *ss;
            NSArray *msg=
            [response valueForKey:@"errors"];
            for(int i =0;i<[msg count];i++){
               // NSDictionary *dic = msg;
                //  NSDictionary *diction =[msg objectAtIndex:i];
                ss =[dict valueForKey:@"exception"];
            }
            
            if([ss isKindOfClass:[NSNull class]])
            {
                //_AlertView_WithOut_Delegate(@"",@"Error",@"Ok", nil);
                return;
            }else{
               // _AlertView_WithOut_Delegate(@"",ss,@"Ok", nil);
                return;
            }
        }
        else{
            
            // Set Shared Preference
            
            NSUserDefaults *VIP =[NSUserDefaults standardUserDefaults];
            [VIP setObject:[response valueForKey:@"email"] forKey:@"current_emai"];
            [VIP setObject:[response valueForKey:@"userId"] forKey:@"LOGIN_USER_ID"];
            [VIP setObject:[response valueForKey:@"firstName"] forKey:@"current_fname"];
            [VIP setObject:[response valueForKey:@"followers"] forKey:@"current_follows"];
            [VIP setObject:[response valueForKey:@"karma"] forKey:@"current_karma"];
            [VIP setObject:[response valueForKey:@"lastName"] forKey:@"current_lname"];
            [VIP setObject:[response valueForKey:@"privacy"] forKey:@"current_privacy"];
            [VIP setObject:[response valueForKey:@"profilePicUrl"] forKey:@"current_profilePicUrl"];
            [VIP setObject:[response valueForKey:@"stories"] forKey:@"current_stories"];
            [VIP synchronize];
            
            shadow = [[UIButton alloc] initWithFrame:self.view.frame];
            shadow.backgroundColor = [UIColor blackColor];
            shadow.alpha = .5;
            [shadow addTarget:self action:@selector(removed_SubVC:) forControlEvents:UIControlEventTouchUpInside];
            //[self.view addSubview:shadow];
            
            //   Go to Home / CategoryViewController
            
            categoryList=[[CategoryList alloc]initWithNibName:@"CategoryList" bundle:nil];
            
            InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
            
            obj_HVC.topViewController =  categoryList;
            
            [self.navigationController pushViewController:obj_HVC animated:NO];
        }
        
        [HUD hide:YES];

    }];
    
}

- (void)removed_SubVC:(UIButton *)sender {
    
    if (sender.isSelected) {
        NSLog(@"isSelected");
        [self effectFunction_FadeIn];

    }else{
        NSLog(@"isSelected!");
        [self effectFunction_FadeOut];

    }
    sender.selected =! sender.selected;
}


#pragma mark- Animation Function
#pragma mark-

-(void)effectFunction_FadeIn{
    
    shadow.backgroundColor = [UIColor blackColor];;

    categoryList=[[CategoryList alloc]initWithNibName:@"CategoryList" bundle:nil];
    categoryList.view.frame = CGRectMake(20, 20, self.view.frame.size.width-40, self.view.frame.size.height-240);
    // [self addChildViewController:categoryList];
    [self.view addSubview:categoryList.view];
    
    
    notification =[[NotificationVC alloc]initWithNibName:@"Notification" bundle:nil];
    notification.view.frame = CGRectMake(20, self.view.frame.size.height-220, self.view.frame.size.width-40, self.view.frame.size.height-240);
    // [self addChildViewController:notification];
    [self.view addSubview:notification.view];
    
    
    shadow.transform = CGAffineTransformMakeScale(1.3, 1.3);
    categoryList.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    notification.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    [UIView animateWithDuration:.5 animations:^{
        shadow.alpha = .5;
        shadow.transform = CGAffineTransformMakeScale(1, 1);
        categoryList.view.transform = CGAffineTransformMakeScale(1, 1);
        notification.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
-(void)effectFunction_FadeOut{
    
    shadow.transform = CGAffineTransformMakeScale(1.3, 1.3);
    categoryList.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    notification.view.transform = CGAffineTransformMakeScale(1.3, 1.3);

    [UIView animateWithDuration:.5 animations:^{
        shadow.backgroundColor = [UIColor clearColor];;
        shadow.transform = CGAffineTransformMakeScale(1, 1);
        categoryList.view.transform = CGAffineTransformMakeScale(1, 1);
        notification.view.transform = CGAffineTransformMakeScale(1, 1);
        
    } completion:^(BOOL finished) {
        
        //[shadow removeFromSuperview];
        [categoryList.view removeFromSuperview];
        [notification.view removeFromSuperview];
        [categoryList removeFromParentViewController];
        [notification removeFromParentViewController];

    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - @end
#pragma mark -


@end
