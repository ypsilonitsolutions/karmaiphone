//
//  AppDelegate.m
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 31/08/15.
//  Copyright (c) 2015 Mahesh Kumar Dhakad. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize navController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
   [self setup_IQKeyboardManager];
    
    NSDictionary *userInfo = [launchOptions valueForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    
    NSDictionary *apsInfo = [userInfo objectForKey:@"apps"];
    
    //Accept push notification when app is not open
    if (apsInfo) {
        
        [self application:application didReceiveRemoteNotification:userInfo];
    }
    
    [self registerForPushNotification];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setTintColor:[WebService colorWithHexString:@"14B9D6"]];
    
    
    NSUserDefaults *nsud =[NSUserDefaults standardUserDefaults];
   // [nsud setObject:@"12" forKey:@"current_userid"];
    NSString *loginUserID= [nsud objectForKey:@"LOGIN_USER_ID"];

    if (loginUserID==nil) {
        
        RootViewController *VC = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
        navController = [[UINavigationController alloc] initWithRootViewController:VC];
    }else{
        
       // [self Login_fun];
        
        RootViewController *VC = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
        navController = [[UINavigationController alloc] initWithRootViewController:VC];
    }
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:UIApplication                object:moviePlayer.moviePlayer];

    navController.navigationBarHidden=true;
    
    [self.window setRootViewController:navController];
    
    [self.window makeKeyAndVisible];
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    //return YES;
}


#pragma mark - IQKeyboardManagerDelegate
#pragma mark -

-(void)setup_IQKeyboardManager{
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setShouldShowTextFieldPlaceholder:YES];
}


#pragma mark - UIApplication Delegate
#pragma mark -

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}




- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [FBSDKAppEvents activateApp];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Push Notifications
#pragma mark -


- (void) registerForPushNotification
{
    NSLog(@"registerForPushNotification");
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0 //
        
        NSLog(@"registerForPushNotification: For iOS >= 8.0");
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:
         [UIUserNotificationSettings settingsForTypes:
          (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                           categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
        
    }else{
        NSLog(@"registerForPushNotification: For iOS < 8.0");
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    }
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

//#if  def __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:   (UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:@"031110a45662027d71b57e8326da3f28ffd50f251fdba26b1973bc1c4eee955" forKey:@"GCMId"];

    if (error.code == 3010){
        
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    }else{
   NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
}


// For GCM_ID
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    // [def setObject:@"6031110a45662027d71b57e8326da3f28ffd50f251fdba26b1973bc1c4eee955" forKey:@"GCMId"];
    [def setObject:token forKey:@"GCMId"];
    
}

#pragma mark - didReceiveRemoteNotification
#pragma mark -

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
  //  NSArray *aps = [userInfo objectForKey:@"aps"];
   // NSString *alert = [aps valueForKey:@"alert"];
    
        NSUserDefaults *nsud=[NSUserDefaults standardUserDefaults];
        [nsud setInteger:4 forKey:@"PrevScreen"];
        [nsud synchronize];
    
       // NSString *msg = [aps valueForKey:@"msg"];
       // NSError *error;
       // NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
        //NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
       // NSString *sts = [jsonResponse objectForKey:@"status"];
        
       // NSString *message = [jsonResponse objectForKey:@"message"];
    
    
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString   *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}

#pragma mark - openURL
#pragma mark -

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication fallbackHandler:^(FBAppCall *call) { NSLog(@"In fallback handler");
    }];
    
}



@end
