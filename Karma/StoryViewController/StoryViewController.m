
//  StoryViewController.m
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 15/09/15.
//  Copyright (c) 2015 Mahesh Kumar Dhakad. All rights reserved.
//




#import "StoryViewController.h"
#import "Constant.h"

@interface StoryViewController ()
{
        IBOutlet UIView *view_FullStoryImage;
        NSString *nibName;
        NSMutableArray *array_AllStory;
    
        __weak IBOutlet UIImageView *img_bad;
        __weak IBOutlet UIImageView *img_good;
    
        // For Full Screen Image
    
        IBOutlet UIImageView *img_full;
        IBOutlet UIButton *btn_sado;
    
        IBOutlet UIButton *btn_full;
        IBOutlet UIButton *btn_bad;
        IBOutlet UIButton *btn_good;
    
        NSInteger lastIndexNum;
    
        //Tinder
        IBOutlet UIView *main_view;
        NSInteger cardsLoadedIndex;
        //%%% the index of the card you have loaded into the loadedCards array last
        NSMutableArray *loadedCards;
        //End Tinder
    
    
        //for comment data
        IBOutlet UILabel *Lbl_date;
        IBOutlet UILabel *Lbl_name;
        IBOutlet UILabel *lbl_Description;
        IBOutlet UILabel *Lbl_karma;
        IBOutlet UIImageView *img_user;
        IBOutlet UIImageView *bg_image;
        IBOutlet UILabel *lbl_CommentCount;
        IBOutlet UIButton *btnShowProfile;
        IBOutlet UILabel *lbl_goodpercen;
        IBOutlet UILabel *lbl_badpercen;
        IBOutlet UIProgressView *progressView;
    
}


@property (nonatomic, strong) NSMutableArray *colorArray;
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
@end

@implementation StoryViewController


@synthesize moviePlayerView;

//Tinder
//static const int MAX_BUFFER_SIZE = 2; //%%% max number of cards loaded at any given time, must be greater than 1
//static const float CARD_HEIGHT = 386; //%%% height of the draggable card
//static const float CARD_WIDTH = 290; //%%% width of the draggable card
@synthesize allCards;
//End Tinder



#pragma mark  - View Life Cycle
#pragma mark  -


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    nibName=nil;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"StoryViewController";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"StoryViewController_iPhone4";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"StoryViewController_iPhone6";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
          nibName=@"StoryViewController_iPhone6Plus";
        }
    }
    else
    {
        nibName=@"StoryViewController_iPad";
    }
    
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}




- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self add_ProgressBar];
    nsud = [NSUserDefaults standardUserDefaults];
    currentUserId = [nsud objectForKey:@"LOGIN_USER_ID"];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [progressView setTransform:CGAffineTransformMakeScale(1.0, 25.0)];
    }else{
        [progressView setTransform:CGAffineTransformMakeScale(1.0, 35.0)];
    }
    
    _btnAddNewStory.layer.cornerRadius = 3;
    _btnAddNewStory.layer.masksToBounds = YES;
    pageCount = @"0";
    [self get_Storys];
    
    // comment userprofile cercle
    img_user.layer.cornerRadius = img_user.frame.size.width / 2;
    img_user.clipsToBounds = YES;
}

-(void)viewWillLayoutSubviews{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    view_FullStoryImage.hidden = YES;

}

-(void)add_ProgressBar
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.tag = 444;

    HUD.square = YES;
    [HUD show:YES];
    [self.view addSubview:HUD];
    
}

#pragma mark  - Action  Add New Story
#pragma mark  -

-(IBAction)addNewStory:(UIButton*)sender
{
    AddStoryViewController *addStory=[[AddStoryViewController alloc]initWithNibName:@"AddStoryViewController" bundle:nil];
     addStory.profile_mag=@"0";
  
    ModelClass *obj=[array_AllStory objectAtIndex:cardNumber];
    
    NSString *strUserid=obj.sub_user_userId;
    
    if ([currentUserId intValue]==[strUserid intValue]) {
        addStory.str_ProfileOwner = @"1";
    }else{
        addStory.str_ProfileOwner = @"0";
    }
    
    addStory.str_UserId = strUserid;
    
    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_ISVC.topViewController = addStory;
    
    [self.navigationController pushViewController:obj_ISVC animated:NO];
   
}



#pragma mark  - Call API Get_Storys
#pragma mark  -

-(void)get_Storys{
    
    [HUD show:YES];
   
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if([_currentsearch_demo isEqualToString:@"story_by_userID"]){
        
        [dict setValue:_getStoryByUserId forKey:@"userId"];
        [dict setValue:@" " forKey:@"tagId"];
        [dict setValue:@" " forKey:@"following"];
        [dict setValue:@" " forKey:@"storyId"];
       // [dict setValue:@"0" forKey:@"offset"];
        
        
     }else  if([_currentsearch_demo isEqualToString:@"story_by_categoryID"]){
        
       [dict setValue:_getStoryByTagId forKey:@"tagId"];
        [dict setValue:@" " forKey:@"userId"];
         
         [dict setValue:@" " forKey:@"following"];
         [dict setValue:@" " forKey:@"storyId"];
       //  [dict setValue:@"0" forKey:@"offset"];
         
     }else  if([_currentsearch_demo isEqualToString:@"story_by_storyID"]){
         [dict setValue:@" " forKey:@"tagId"];
         [dict setValue:@" " forKey:@"userId"];
         [dict setValue:@" " forKey:@"following"];
         [dict setValue:_getStoryByStoryId forKey:@"storyId"];
         //[dict setValue:@"0" forKey:@"offset"];
         
     }else  if([_currentsearch_demo isEqualToString:@"get_trending"]){
         
     }else  if([_currentsearch_demo isEqualToString:@"People_I_Follow"]){
         [dict setValue:@" " forKey:@"tagId"];
         [dict setValue:@" " forKey:@"userId"];
         [dict setValue:@"1" forKey:@"following"];
         [dict setValue:@" " forKey:@"storyId"];
        // [dict setValue:@"0" forKey:@"offset"];
     }
    [dict setValue:pageCount forKey:@"offset"];

    NSString *url = _getStoryURL;
    
    WebService *api=[[WebService alloc] init];
    
    [api call_API:dict andURL:url andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
        [HUD hide:YES];
        
        
        NSMutableArray *Arr_Response = response ;
       // Arr_Response=[[[Arr_Response reverseObjectEnumerator] allObjects] mutableCopy];
        int maincount = (int)[Arr_Response count];
        
        if(maincount == 0){
          
            _btnAddNewStory.hidden = NO;
            _footerView.hidden = YES;
            _commentsView.hidden = YES;

            return;
            
        }else{
            
            _btnAddNewStory.hidden = YES;
            _footerView.hidden = NO;
            _commentsView.hidden = NO;

            arrayStory =[[NSMutableArray alloc]init];
            arrayKarmaMeterPercent = [NSMutableArray new];
            // arrayStory  = [dict allValues];
            array_AllStory =[[NSMutableArray alloc]init];
            //tinder
            loadedCards = [[NSMutableArray alloc] init];
            allCards = [[NSMutableArray alloc] init];
            cardsLoadedIndex = 0;
            
          NSMutableArray  *tempArrayStory =[[NSMutableArray alloc]init];

            
            for (int i =0; i<[Arr_Response count]; i++)
            {
                NSDictionary *dict = [[NSDictionary alloc] init];
                
                if([self.currentsearch_demo isEqualToString:@"get_trending"]){
                    
                   dict =  [[response valueForKey:@"story"] objectAtIndex:i];
                    
                    [tempArrayStory addObject: [[response valueForKey:@"story"] objectAtIndex:i]];

                }else{
                    
                    dict = [response objectAtIndex:i];
                    
                    [tempArrayStory addObject: [response objectAtIndex:i]];
                }
                
                ModelClass *obj=[[ModelClass alloc]init];
                
                obj.countid=[NSString stringWithFormat:@"%d",i];
                
                if([[dict valueForKey:@"voteType"] isEqual:[NSNull null]]){
                    
                    obj.voteType = [NSString stringWithFormat:@"2"];
                }else{
                    obj.voteType = [NSString stringWithFormat:@"%@",[dict valueForKey:@"voteType"]];
                }
                
                obj.sty_goodvotes=[NSString stringWithFormat:@"%@",[dict valueForKey:@"goodVotes"]];
                obj.sty_badvotes=[NSString stringWithFormat:@"%@",[dict valueForKey:@"badVotes"]];
                
               // NSString *goodvotes=[NSString stringWithFormat:@"%@",[dict valueForKey:@"goodVotes"]];
                //int gd=[goodvotes intValue];
               // NSString *badvotes=[NSString stringWithFormat:@"%@",[dict valueForKey:@"badVotes"]];
                //int bd=[badvotes intValue];
                
                // Calculate Krma Meter Percent
                //[self get_KarmaMeterPercent_byGoodVotes:gd andBadVotes:bd];
                

                obj.sty_contentvotes=[NSString stringWithFormat:@"%@",[dict valueForKey:@"content"]];
                obj.sty_commentvotes=[NSString stringWithFormat:@"%@",[dict valueForKey:@"comments"]];
                obj.Voteforstoryid=[NSString stringWithFormat:@"%@",[dict valueForKey:@"storyId"]];
                obj.sty_picUrl=[NSString stringWithFormat:@"%@",[dict valueForKey:@"picUrl"]];
                obj.createdate=[NSString stringWithFormat:@"%@",[dict valueForKey:@"created"]];
                //confidential
                obj.sty_confidences=[NSString stringWithFormat:@"%@",[dict valueForKey:@"confidential"]];
                
                
                NSMutableArray *tagstory =[dict objectForKey:@"storyTagMaps"];
                
                for (int i =0; i<[tagstory count]; i++) {
                    NSDictionary *dict1=[tagstory objectAtIndex:i];
                    
                    NSMutableArray *tagstory1=[dict1 objectForKey:@"tag"];
                    // NSDictionary *dict11=[tagstory1 objectAtIndex:i];
                    
                    obj.tagstory_name=[NSString stringWithFormat:@"%@",[tagstory1 valueForKey:@"name"]];
                    obj.tagstory_picUrl=[NSString stringWithFormat:@"%@",[tagstory1 valueForKey:@"picUrl"]];
                    obj.tagstory_tagid=[NSString stringWithFormat:@"%@",[tagstory1 valueForKey:@"tagId"]];
                }
                
                NSMutableArray *userBySubjectUserId =[dict objectForKey:@"userBySubjectUserId"];
                
                obj.sub_user_email=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"email"]];
                obj.sub_user_firstName=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"firstName"]];
                obj.sub_user_lastname=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"lastName"]];
                obj.sub_user_profilePicUrl=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"profilePicUrl"]];
                obj.sub_user_stories=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"stories"]];
                obj.sub_user_userId=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"userId"]];
                obj.sub_user_karma=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"karma"]];
                obj.sub_user_follow=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"followers"]];
                obj.sub_user_userId=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"userId"]];
                
                NSMutableArray *userByAuthorUserId =[dict objectForKey:@"userByAuthorUserId"];
                
                obj.cat_user_email=[NSString stringWithFormat:@"%@",[userByAuthorUserId valueForKey:@"email"]];
                obj.cat_user_firstName=[NSString stringWithFormat:@"%@",[userByAuthorUserId valueForKey:@"firstName"]];
                obj.cat_user_lastname=[NSString stringWithFormat:@"%@",[userByAuthorUserId valueForKey:@"lastName"]];
                obj.cat_user_profilePicUrl=[NSString stringWithFormat:@"%@",[userByAuthorUserId valueForKey:@"profilePicUrl"]];
                obj.cat_user_stories=[NSString stringWithFormat:@"%@",[userByAuthorUserId valueForKey:@"stories"]];
                obj.cat_user_userId=[NSString stringWithFormat:@"%@",[userByAuthorUserId valueForKey:@"userId"]];
                obj.cat_user_follow=[NSString stringWithFormat:@"%@",[userByAuthorUserId valueForKey:@"followers"]];
                obj.cat_user_karma=[NSString stringWithFormat:@"%@",[userByAuthorUserId valueForKey:@"karma"]];
                
                [array_AllStory addObject:obj];
                
            }
            
            NSInteger newPageCount = [pageCount intValue] + array_AllStory.count;
            
            pageCount =  [NSString stringWithFormat:@"%li",(long)newPageCount];
            
            /*
            if([_currentsearch_demo isEqualToString:@"story_by_userID"]){
                arrayStory = tempArrayStory;

                 array_AllStory = [[[array_AllStory reverseObjectEnumerator] allObjects] mutableCopy];
                 arrayStory = [[[arrayStory reverseObjectEnumerator] allObjects] mutableCopy];
            }else{
                
                arrayStory = tempArrayStory;
            }
            */
            arrayStory = tempArrayStory;

            [self loadCards];
            
            arrayStoryComments = [[arrayStory valueForKey:@"commentsList" ] objectAtIndex:0];
            cardNumber = (int)cardsLoadedIndex-1;
            [self show_StroyandCommentsCount];
        }
        
        [HUD hide:YES];

    }];

  
}




-(CGRect)get_TextFrame:(UILabel *)label{
    
    CGFloat fixedWidth = label.frame.size.width;
    CGSize newSize = [label sizeThatFits:CGSizeMake(fixedWidth, 75)];
    CGRect newFrame = label.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    
    label.frame = newFrame;
    
    return newFrame;
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


-(NSMutableDictionary *)get_KarmaMeterPercent_byGoodVotes:(int)goodVotes andBadVotes:(int)badVotes{
    
    float totalVotes = goodVotes + badVotes;
    
    if(totalVotes == 0)
    {
        karmaMeterValue = [NSString stringWithFormat:@"50"];
        karmaMeterGoodValue = [NSString stringWithFormat:@"50%@",@"%"];
        karmaMeterBadValue = [NSString stringWithFormat:@"50%@",@"%"];
    }else{
        
        NSString *sum=[NSString stringWithFormat:@"%f",(goodVotes/totalVotes)];
        float cn =[sum floatValue];
        // karmaMeterValue =[NSString stringWithFormat:@"%f",(((cn*100)-50)*2)];
        int roundedUp = roundf((((cn*100)-50)*2));
        
        karmaMeterValue =[NSString stringWithFormat:@"%i",roundedUp];
        
        if ([karmaMeterValue intValue] == 0) {
            
            karmaMeterValue = [NSString stringWithFormat:@"50"];
            karmaMeterBadValue = [NSString stringWithFormat:@"50%@",@"%"];
            karmaMeterGoodValue = [NSString stringWithFormat:@"50%@",@"%"];


        } else if([karmaMeterValue intValue] > 0) {
            
            int badPercent = 100 - [karmaMeterValue intValue];
            karmaMeterGoodValue = [NSString stringWithFormat:@"%@%@",karmaMeterValue,@"%"];
            
            karmaMeterBadValue = [NSString stringWithFormat:@"%d%@",badPercent,@"%"];

        }else{
            
            karmaMeterValue = [karmaMeterValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
            int goodPercent = 100 - [karmaMeterValue intValue];
            karmaMeterGoodValue = [NSString stringWithFormat:@"%d%@",goodPercent,@"%"];
            karmaMeterBadValue = [NSString stringWithFormat:@"%@%@",karmaMeterValue,@"%"];
        }
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:karmaMeterGoodValue, @"Good_Percent",karmaMeterBadValue, @"Bad_Percent",karmaMeterValue, @"KarmaMeterValue", nil];
    [arrayKarmaMeterPercent addObject:dict];

   return dict;
}



#pragma mark - other action Methods
#pragma mark -





-(IBAction)func_Currentprofile:(UIButton *)sender
{
    sender.adjustsImageWhenHighlighted = false;
    
    Profile *pro=[[Profile alloc]initWithNibName:@"Profile" bundle:nil];
    pro.str_ProfileOwner = @"1";
   
    pro.str_UserId = currentUserId;
    
    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_ISVC.topViewController = pro;
    
    [self.navigationController pushViewController:obj_ISVC animated:NO];
}

#pragma  mark - Show / Hide Full Story Image
#pragma  mark -

-(IBAction)hide_FullStoryImage:(id)sender
{
    isZoomImage = NO;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    view_FullStoryImage.hidden = YES;
    
}

-(void)show_FullStoryImage:(UIButton *)sender{
    
    if (sender.tag!=100) {
 
        ModelClass *obj=[array_AllStory objectAtIndex:[sender tag]];
        NSString *story_PicURL = [NSString stringWithFormat:@"%@",obj.sty_picUrl];
        
        if ([sender.currentImage isEqual:[UIImage imageNamed:@"video.png"]]){
            
            // [self embedYouTube:story_PicURL frame:view_FullStoryImage.frame];
            
            if (!([story_PicURL rangeOfString:@"youtube.com" options:NSCaseInsensitiveSearch].location ==NSNotFound))
            {
                [self submitYouTubeURL:story_PicURL];
            }else{
                
                [self playMovie:story_PicURL];
            }
            
        }else{
            isZoomImage = YES;
            
            [[UIApplication sharedApplication] setStatusBarHidden:YES];
            [self setNeedsStatusBarAppearanceUpdate];
            //[img_full setImageWithURL:[NSURL URLWithString:story_PicURL] placeholderImage:[UIImage imageNamed:@"default_img.png"]];
            img_full.imageURL = [NSURL URLWithString:story_PicURL];
            view_FullStoryImage.hidden = NO;
        }

    }
    
}

#pragma  mark - MPMoviePlayerViewController
#pragma  mark -

- (void)submitYouTubeURL:(NSString*)stringURL {
    
    
    NSURL *url = [NSURL URLWithString:stringURL];
    
    [MDYoutubeParser thumbnailForYoutubeURL:url thumbnailSize:YouTubeThumbnailDefaultHighQuality completeBlock:^(UIImage *image, NSError *error) {
        
        if (!error) {
            
            [MDYoutubeParser h264videosWithYoutubeURL:url completeBlock:^(NSDictionary *videoDictionary, NSError *error) {
                
                NSDictionary *qualities = videoDictionary;
                
                NSString *URLString = nil;
                if ([qualities objectForKey:@"small"] != nil) {
                    URLString = [qualities objectForKey:@"small"];
                }
                else if ([qualities objectForKey:@"live"] != nil) {
                    URLString = [qualities objectForKey:@"live"];
                }
                else {
                    [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Couldn't find youtube video" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];
                    return;
                }
                [self playMovie:URLString];
                
            }];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alert show];
        }
    }];
}


- (void)playMovie:(NSString *)URLString{
    
    
    NSURL *_urlToLoad = [NSURL URLWithString:URLString];

    if (_urlToLoad) {
        
        moviePlayerView = [[UIView alloc] initWithFrame:self.view.frame];
        moviePlayerView.backgroundColor = [UIColor clearColor];
       // MPMoviePlayerViewController *
        moviePlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:_urlToLoad];
        moviePlayer.view.frame = self.view.frame;
        //moviePlayer.moviePlayer.controlStyle = MPMovieControlStyleDefault;
        moviePlayer.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
        moviePlayer.moviePlayer.shouldAutoplay = YES;
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer.moviePlayer];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification                object:moviePlayer.moviePlayer];
        
        [moviePlayerView addSubview:moviePlayer.view];
        moviePlayerView.tag = 222;
        [self.view addSubview:moviePlayerView];

    }
   
}



- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
   // MPMoviePlayerController *moviePlayer = [notification object];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];

    if ([moviePlayer respondsToSelector:@selector(setFullscreen:animated:)])
    {
        // the transition should be around here... (fade out)
        [moviePlayer.view removeFromSuperview];
    }
    if (moviePlayerView) {
        
        [moviePlayerView removeFromSuperview];
    }
}




#pragma  mark - Show Story Create User Profile
#pragma  mark -

-(IBAction)show_StoryCreateUserProfile:(UIButton *)sender
{
    ModelClass *obj=[array_AllStory objectAtIndex:cardNumber];
    Profile *pro=[[Profile alloc]initWithNibName:@"Profile" bundle:nil];
    
    NSString *strUserid = obj.cat_user_userId;
    
    if ([currentUserId intValue]==[strUserid intValue]) {
        pro.str_ProfileOwner = @"1";
    }else{
        pro.str_ProfileOwner = @"0";
    }
    pro.str_UserId = strUserid;
    
    NSString *Check_confid = obj.sty_confidences;

    if (![Check_confid isEqualToString:@"1"])
    {
        InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        obj_ISVC.topViewController = pro;
        
        [self.navigationController pushViewController:obj_ISVC animated:NO];
    }
    
}


#pragma  mark - Show Story Subject  User Profile
#pragma  mark -


-(void)show_StorySubjectUserProfile:(UIButton *)sender
{
    ModelClass *obj=[array_AllStory objectAtIndex:cardNumber];
    Profile *pro=[[Profile alloc]initWithNibName:@"Profile" bundle:nil];
    
    NSString *strUserid=obj.sub_user_userId;
    
    if ([currentUserId intValue]==[strUserid intValue]) {
        pro.str_ProfileOwner = @"1";
    }else{
        pro.str_ProfileOwner = @"0";
    }
    pro.str_UserId = strUserid;
    
    NSString *Check_confid = obj.sty_confidences;

    if (![Check_confid isEqualToString:@"1"])
    {
        InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        obj_ISVC.topViewController = pro;
        
        [self.navigationController pushViewController:obj_ISVC animated:NO];
    }

}


#pragma mark  - func Vote
#pragma mark  -


-(IBAction)Func_bad:(UIButton *)sender
{
    [self swipeLeft];
}


-(IBAction)Func_good:(UIButton *)sender
{
    
    [self swipeRight];
}


-(void)zigZagAnimation:(NSString *)animationFor andStoryID:(NSString *)storyId{

    
    if([animationFor isEqualToString:@"Bad"])
    {
        
            [self call_GiveVoteAPI:@"1" andStoryID:storyId];

            /*
            [self.imgViewGIFBad setHidden:NO];
            
            NSURL *url = [[NSBundle mainBundle] URLForResource:@"bad" withExtension:@"gif"];
            UIImage *testImage = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
            self.imgViewGIFBad.animationImages = testImage.images;
            self.imgViewGIFBad.animationDuration = testImage.duration;
            self.imgViewGIFBad.animationRepeatCount = 1;
            self.imgViewGIFBad.image = testImage.images.lastObject;
           // [self.imgViewGIFBad startAnimating];
            
            [self performSelector:@selector(hide_BadZigZagAnimation) withObject:nil afterDelay:3.5];
            */

    }else if ([animationFor isEqualToString:@"Good"]){
        
            [ self call_GiveVoteAPI:@"2" andStoryID:storyId];
            
            /*
            [self.imgViewGIFGood setHidden:NO];
            
            NSURL *url = [[NSBundle mainBundle] URLForResource:@"good" withExtension:@"gif"];
            UIImage *testImage = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
            self.imgViewGIFGood.animationImages = testImage.images;
            self.imgViewGIFGood.animationDuration = testImage.duration;
            self.imgViewGIFGood.animationRepeatCount = 1;
            self.imgViewGIFGood.image = testImage.images.lastObject;
            [self.imgViewGIFGood startAnimating];
            
            [self performSelector:@selector(hide_GoodZigZagAnimation) withObject:nil afterDelay:3.5];
            */
        
    }
    
}





-(void)hide_BadZigZagAnimation
{
    [self.imgViewGIFBad stopAnimating];
    [self.imgViewGIFBad setHidden:YES];
}

-(void)hide_GoodZigZagAnimation{
    [self.imgViewGIFGood stopAnimating];
    [self.imgViewGIFGood setHidden:YES];
}




-(void)call_GiveVoteAPI:(NSString *)voteFor andStoryID:(NSString *)storyId{
    
    [HUD show:YES];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if([voteFor isEqualToString:@"1"])
    {
        [dict setValue:storyId forKey:@"storyId"];
        
        [dict setValue:@"0" forKey:@"goodVotes"];
        
        [dict setValue:@"1" forKey:@"badVotes"];
        
        WebService *api=[[WebService alloc] init];
        
        [api call_API:dict andURL:VOTE_STORY andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
            
            [HUD hide:YES];
            
           // [self get_Storys];

        }];
        
    }else{
        
        [dict setValue:storyId forKey:@"storyId"];
        [dict setValue:@"1" forKey:@"goodVotes"];
        
        [dict setValue:@"0" forKey:@"badVotes"];
        
        WebService *api=[[WebService alloc] init];
        
        [api call_API:dict andURL:VOTE_STORY andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
            
            [HUD hide:YES];
           // [self get_Storys];

        }];
    }

}

#pragma mark  - action_Refresh ALL Stroy
#pragma mark  -


-(IBAction)action_Search:(id)sender{

    
    CategoryList *obj_HVC=[[CategoryList alloc]initWithNibName:@"CategoryList" bundle:nil];
    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_ISVC.topViewController = obj_HVC;
    [self.navigationController pushViewController:obj_ISVC animated:NO];

   // [self get_Storys];
}


- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:MDRight];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tinder Methods
#pragma mark -

//#warning include own card customization here!
//%%% creates a card and returns it.  This should be customized to fit your needs.
// use "index" to indicate where the information should be pulled.  If this doesn't apply to you, feel free
// to get rid of it (eg: if you are building cards from data from the internet)


-(DraggableView *)createDraggableViewWithDataAtIndex:(NSInteger)index
{
    
    CardView  *cell=[[CardView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];

    DraggableView *draggableView = [[DraggableView alloc]initWithFrame:CGRectMake(0,64, self.view.frame.size.width , cell.frame.size.height)];
    draggableView.backgroundColor=[UIColor clearColor];
    
        ModelClass *obj = [array_AllStory objectAtIndex:index];
       // NSArray *indexs =  [arrayStory  objectAtIndex:index];
       // storyID = obj.Voteforstoryid;
    
        cell.userimage.hidden=NO;
        cell.lbl_name.hidden=NO;
        
        cell.sliderimage.hidden=NO;
        btn_bad.hidden=NO;
        btn_good.hidden=NO;
        img_bad.hidden=NO;
        img_good.hidden=NO;
        cell.view_Story.hidden=NO;
        
        NSString *Check_confid = obj.sty_confidences;
        
        if ([Check_confid isEqualToString:@"1"])
        {
            cell.view_Story.hidden=NO;
            cell.lbl_follows.hidden=YES;
            cell.lbl_story.hidden=YES;
            cell.btn_story.hidden=YES;
            cell.lbl_karma.hidden=YES;
            cell.lbl_name.textColor=[UIColor lightGrayColor];
            cell.lbl_name.text=[NSString stringWithFormat:@"Confidential"];
            cell.bg_userimage.image=[UIImage imageNamed:@"confidential_icon.png"];
        }else{
            
            cell.lbl_follows.hidden=NO;
            cell.lbl_story.hidden=NO;
            cell.btn_story.hidden=NO;
            cell.btn_story.hidden=NO;
            cell.lbl_karma.hidden=NO;
            [cell.btn_profile setTag:index];
            [cell.btn_profile addTarget:self action:@selector(show_StorySubjectUserProfile:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btn_story.backgroundColor=[UIColor colorWithRed:0.663 green:0.663 blue:0.659 alpha:1];
            cell.btn_story.layer.cornerRadius = 4;
            cell.btn_story.layer.masksToBounds = YES;
            [cell.btn_story addTarget:self action:@selector(addNewStory:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.lbl_karma.text=[NSString stringWithFormat:@"%@ ",obj.sub_user_karma];
           // cell.lbl_karma.text=[NSString stringWithFormat:@"Story : %@ ",storyID];
            NSString *a =obj.sub_user_firstName;
            
            // cell.lbl_follows.text =obj.cat;
            NSString *b = obj.sub_user_lastname;
            NSString *c = [NSString stringWithFormat:@"%@ %@", a, b];
            cell.lbl_name.textColor=[UIColor blackColor];
            cell.lbl_name.text =c;
            
            NSString *checkusercolor = obj.sub_user_karma;
            //  NSString *value = [checkusercolor substringToIndex:1];
            if([checkusercolor intValue]<0)
            {
                cell.bg_userimage.image=[UIImage imageNamed:@"pink_user_image_default.png"];
                [cell.lbl_karma setTextColor:[UIColor whiteColor]];
                
                cell.bg_userimage.transform = CGAffineTransformMakeRotation(-[checkusercolor floatValue] * M_PI/180);

            }
            else if([checkusercolor intValue]>0)
            {
                cell.bg_userimage.image=[UIImage imageNamed:@"blue_user_image_default.png"];
                [cell.lbl_karma setTextColor:[UIColor whiteColor]];
                
                cell.bg_userimage.transform = CGAffineTransformMakeRotation(-[checkusercolor floatValue] * M_PI/180);

            }else
            {
                cell.bg_userimage.image=[UIImage imageNamed:@"rad_blue_border_img.png"];
                [cell.lbl_karma setTextColor:[UIColor blackColor]];
            }
            /*
             NSString *r=[NSString stringWithFormat:@"%@",obj.sub_user_profilePicUrl];
             cell.userimage.image=[UIImage imageNamed:r];
             NSURL *URL=[NSURL URLWithString:r];
             [cell.userimage setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"default_img.png"]];
             */
            NSString *r = [NSString stringWithFormat:@"%@",obj.sub_user_profilePicUrl];
            NSURL *URL = [NSURL URLWithString:r];
            
            cell.userimage.imageURL = URL;

            //[cell.userimage setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"default_img.png"]];
        }
        lastIndexNum = index;
        NSString *rr=[NSString stringWithFormat:@"%@",obj.sty_picUrl];
        int lenh =(int)[rr length];
        int ind;
        if([rr isEqualToString:@""]){
           // cell.sliderimage.image=[UIImage imageNamed:rr];
            //NSURL *URL1=[NSURL URLWithString:rr];
           // [cell.sliderimage setImageWithURL:URL1 placeholderImage:[UIImage imageNamed:@"default_img_story.png"]];
            //flag_youtudelink=YES;
            [cell.btn_ShowFullImage setTag:100];

        }
        else
        {
            ind =(lenh - 4);
            NSString *linkcheck =[rr substringFromIndex:ind];
            
            NSString *encodedUrl = [rr stringByAddingPercentEscapesUsingEncoding:
                                    NSUTF8StringEncoding];
            
            [cell.btn_ShowFullImage setTag:index];

            if([linkcheck length] < 4){
                
                [cell.btn_ShowFullImage setTag:100];
                
                [cell.sliderimage setContentMode:UIViewContentModeScaleAspectFit];

            }else if([linkcheck isEqualToString:@".jpg"]||[linkcheck isEqualToString:@".png"]||[linkcheck isEqualToString:@"jpeg"]){
                
                NSURL *URL1=[NSURL URLWithString:encodedUrl];
               // [cell.sliderimage setImageWithURL:URL1];
                cell.sliderimage.backgroundColor = [UIColor whiteColor];
                cell.sliderimage.layer.masksToBounds = YES;
                cell.sliderimage.imageURL = URL1;
            }else{
               
                NSString *youtubeID = [WebService extractYoutubeIdFromLink:rr];
                
                // http://img.youtube.com/vi/5HbYScltf1c/0.jpg
                // http://img.youtube.com/vi/5HbYScltf1c/mqdefault.jpg
                NSString *stringVideoURL =[NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg",youtubeID];
                
                NSURL *movieURL=[NSURL URLWithString:stringVideoURL];
                [cell.sliderimage setImageWithURL:movieURL];
                [cell.btn_ShowFullImage setImage:[UIImage imageNamed:@"video.png"] forState:UIControlStateNormal];
                cell.sliderimage.layer.masksToBounds = YES;

               // [cell.sliderimage setImage:[self generateThumbImage:stringVideoURL ]];
                
            }
        }
        // myLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    
    
       [cell.btn_ShowFullImage addTarget:self action:@selector(show_FullStoryImage:) forControlEvents:UIControlEventTouchUpInside];
    
        cell.lbl_follows.text=[NSString stringWithFormat:@"%@ followers",obj.sub_user_follow];
    
        cell.lbl_story.text=[NSString stringWithFormat:@"%@ stories",obj.sub_user_stories];
    
    
    [draggableView addSubview:cell];
    
    draggableView.delegate = self;
    
    return draggableView;
}





-(UIImage *)generateThumbImage:(NSString *)filepath
{
    NSURL *url = [NSURL fileURLWithPath:filepath];
    
    AVAsset *asset = [AVAsset assetWithURL:url];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    CMTime time = [asset duration];
    time.value = 1;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);  // CGImageRef won't be released by ARC
    
    return thumbnail;
}



//%%% loads all the cards and puts the first x in the "loaded cards" array
-(void)loadCards
{
    if([array_AllStory count] > 0)
    {
        for (int i = 0; i<[array_AllStory count]; i++) {
            
            DraggableView* newCard = [self createDraggableViewWithDataAtIndex:i];
            
            [allCards addObject:newCard];
            
            [loadedCards addObject:newCard];
        }
        
        for (int i = 0; i<[loadedCards count]; i++) {
            
            [main_view addSubview:[loadedCards objectAtIndex:i]];

            cardsLoadedIndex = cardsLoadedIndex+i;
        }
        cardsLoadedIndex = [loadedCards count];
    }
}

#pragma mark - Card Swiped Left
#pragma mark -


-(void)cardSwipedLeft:(UIView *)card
{
    [UIView animateWithDuration:2 animations:^{
        
        img_bad.image=[UIImage imageNamed:@"voted_bad_icon.png"];
        img_good.image=[UIImage imageNamed:@"good_icon.png"];
        
    }completion:^(BOOL finished) {
        
        ModelClass *obj = [array_AllStory objectAtIndex:cardNumber];
        storyID = obj.Voteforstoryid;
        
        [self zigZagAnimation:@"Bad" andStoryID:storyID];
        
        [self performSelector:@selector(change_StoryDetails) withObject:self afterDelay:1 ];

    }];
    
}


#pragma mark - Card Swiped Right
#pragma mark -


-(void)cardSwipedRight:(UIView *)card
{
    [UIView animateWithDuration:2 animations:^{

       img_bad.image=[UIImage imageNamed:@"bad_icon.png"];
      img_good.image=[UIImage imageNamed:@"voted_good_icon.png"];
    }completion:^(BOOL finished) {

      ModelClass *obj = [array_AllStory objectAtIndex:cardNumber];
      storyID = obj.Voteforstoryid;
    
      [self zigZagAnimation:@"Good" andStoryID:storyID];

      [self performSelector:@selector(change_StoryDetails) withObject:self afterDelay:1 ];
    }];

}




#pragma mark - change_StoryDetails
#pragma mark -


-(void)change_StoryDetails{
    
    [loadedCards removeLastObject];
    
    cardsLoadedIndex--;
    
    if (cardsLoadedIndex > 0) {
        
        cardNumber = (int)cardsLoadedIndex-1;
        
        [self show_StroyandCommentsCount];
        
        _footerView.hidden = NO;
        _commentsView.hidden = NO;
        _btnAddNewStory.hidden = YES;
        
        
    }else{
        
        _footerView.hidden = YES;
        _commentsView.hidden = YES;
        //_btnAddNewStory.hidden = NO;
        cardsLoadedIndex = 0;
        cardNumber = 0;
        [self get_Storys];
    }

}


#pragma mark - Card Swiped Left Right
#pragma mark -

//%%% when you hit the right button, this is called and substitutes the swipe
-(void)swipeRight
{
    DraggableView *dragView = [loadedCards lastObject];
    dragView.overlayView.mode = GGOverlayViewModeRight;
    [UIView animateWithDuration:1 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView rightClickAction];
}

//%%% when you hit the left button, this is called and substitutes the swipe
-(void)swipeLeft
{
    DraggableView *dragView = [loadedCards lastObject];
    dragView.overlayView.mode = GGOverlayViewModeLeft;
    [UIView animateWithDuration:1 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView leftClickAction];
}



#pragma mark - Show Stroy and Comments Count
#pragma mark -

//
-(void)show_StroyandCommentsCount{
    
    NSArray *storyIndex = [arrayStory  objectAtIndex:cardNumber];
    
    arrayStoryComments = [storyIndex valueForKey:@"commentsList" ];
    
    ModelClass *obj = [array_AllStory objectAtIndex:cardNumber];
    
    NSString *goodvotes=[NSString stringWithFormat:@"%@",obj.sty_goodvotes];
    int gd=[goodvotes intValue];
    NSString *badvotes=[NSString stringWithFormat:@"%@",obj.sty_badvotes];
    int bd=[badvotes intValue];

    // Calculate Krma Meter Percent
    NSMutableDictionary *dict =  [self get_KarmaMeterPercent_byGoodVotes:gd andBadVotes:bd];
    
    
    karmaMeterGoodValue = [dict valueForKey:@"Good_Percent"];
    karmaMeterBadValue = [dict valueForKey:@"Bad_Percent"];
    karmaMeterValue = karmaMeterBadValue;
   // NSString *karmaMeterValues =[NSString stringWithFormat:@"%@",[dict valueForKey:@"KarmaMeterValue"]];
    
    float ff =[karmaMeterBadValue floatValue];
    progressView.progress = (ff/100);
    lbl_goodpercen.text=[NSString stringWithFormat:@"%@",karmaMeterGoodValue];
    lbl_badpercen.text=[NSString stringWithFormat:@"%@",karmaMeterBadValue];

    KarmaMeterView *karmaMeterView = [[KarmaMeterView alloc] initWithFrame:CGRectMake(0, 0, _footerView.frame.size.width, _footerView.frame.size.height)];
    //karmaMeterView.leftLabel.text = @"35%" ;
    //karmaMeterView.rightLabel.text = @"65%" ;
    karmaMeterView.tag = 11;
    karmaMeterView.progress = (ff/100);

    [self.footerView addSubview:karmaMeterView];
    //self.footerView.layer.zPosition = 1;
    storyID = obj.Voteforstoryid;
    progressView.hidden = true;

    for (UIView *subViews in _footerView.subviews) {
       
        if ([subViews isKindOfClass:[UIView class]]&& subViews.tag==11) {
            subViews.layer.zPosition = 0;
        }else{
            subViews.layer.zPosition = 1;
        }
    }
    
    NSString *createdate = obj.createdate;
    Lbl_date.text= [self get_StoryCreateDate:createdate];
    
    NSString *describtion = obj.sty_contentvotes;
    
    lbl_Description.text = describtion;
    
    lbl_Description.frame = [self get_TextFrame:lbl_Description];

    NSString *checkusercolor = obj.cat_user_karma;
    //  NSString *value = [checkusercolor substringToIndex:1];
    if([checkusercolor intValue]<0)
    {
        bg_image.image = [UIImage imageNamed:@"pink_user_image_default.png"];
        [Lbl_karma setTextColor:[UIColor whiteColor]];
        
        bg_image.transform = CGAffineTransformMakeRotation(-[checkusercolor floatValue] * M_PI/180);

    }else if([checkusercolor intValue]>0){
        
        bg_image.image =[UIImage imageNamed:@"blue_user_image_default.png"];
        [Lbl_karma setTextColor:[UIColor whiteColor]];
       
        bg_image.transform = CGAffineTransformMakeRotation(-[checkusercolor floatValue] * M_PI/180);

    }else{
        
        bg_image.image = [UIImage imageNamed:@"rad_blue_border_img.png"];
        [Lbl_karma setTextColor:[UIColor blackColor]];
    }
    
    NSString *Check_confid = obj.sty_confidences;
    
    if ([Check_confid isEqualToString:@"1"])
    {
        Lbl_name.hidden=YES;
        Lbl_karma.hidden=YES;
        bg_image.hidden=YES;
        
        img_user.image=[UIImage imageNamed:@"confidential_icon.png"];
        
    }else{
        
        Lbl_name.hidden=NO;
        Lbl_karma.hidden=NO;
        bg_image.hidden=NO;
        
        NSURL *URL=[NSURL URLWithString:obj.cat_user_profilePicUrl];
        //[img_user setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"default_img.png"]];
        //load the image
        if (URL != nil ) {
           // img_user.image = nil;
            img_user.imageURL = URL;
        }

        NSString *name=obj.cat_user_firstName;
        NSString *lastname=obj.cat_user_lastname;
        Lbl_name.text=[NSString stringWithFormat:@"%@ %@",name,lastname];
        Lbl_karma.text=[NSString stringWithFormat:@"%@ ",obj.cat_user_karma];
    }
    
   // lbl_time.text = [NSString stringWithFormat:@"%ld Comments",(unsigned long)arrayStoryComments.count];
    
    lbl_CommentCount.text=[NSString stringWithFormat:@"%@ Comments",obj.sty_commentvotes];

    voteType =  obj.voteType;
    
    if([voteType isEqualToString:@"0"]){
        
       img_bad.image=[UIImage imageNamed:@"voted_bad_icon.png"];
        img_good.image=[UIImage imageNamed:@"good_icon.png"];
        
    }else if([voteType isEqualToString:@"1"]){
        
        img_bad.image=[UIImage imageNamed:@"bad_icon.png"];
        img_good.image=[UIImage imageNamed:@"voted_good_icon.png"];
        
    }else{
        
        img_bad.image=[UIImage imageNamed:@"bad_icon.png"];
        img_good.image=[UIImage imageNamed:@"good_icon.png"];
    }
}



-(NSString *)get_StoryCreateDate:(NSString *)date{
    
    double dd1=[date longLongValue];
    
    NSDate *nsDate = [NSDate dateWithTimeIntervalSince1970:(dd1 / 1000.0)];
    NSString *strdate=[NSString stringWithFormat:@"%@",nsDate];
    
    NSString *search=[[NSString alloc]init];
    
    search = [strdate substringToIndex:10];
    
    //NSString *myString = @"2012-11-22 10:19:04";
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *yourDate = [dateFormatter dateFromString:search];
    dateFormatter.dateFormat = @"MMMM d, YYYY";
    NSLog(@"%@",[dateFormatter stringFromDate:yourDate]);
    
    NSString *createDate =[dateFormatter stringFromDate:yourDate];

    return createDate;
}

-(IBAction)showStoryComments:(UIButton*)sender
{
    //[HUD show:YES];

    NSArray *currentIndexStory =[arrayStory objectAtIndex:cardNumber];
//    [nsud setObject:currentIndexStory forKey:@"currentIndexStory"];
//    [nsud setObject:karmaMeterValue forKey:@"karmaMeterValue"];
//    [nsud synchronize];
    ModelClass *obj = [array_AllStory objectAtIndex:cardNumber];

    StoryCommentsVC *storyCommentsVC=[[StoryCommentsVC alloc]initWithNibName:@"StoryCommentsVC" bundle:nil];
    storyCommentsVC.arrayStory = currentIndexStory;
    storyCommentsVC.karmaMeterPercent = karmaMeterValue;
    storyCommentsVC.str_UserId = obj.cat_user_userId;
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionFade;

   // [[[[self  view] window] layer] addAnimation:crossFade forKey:kCATransitionFade];
    
   // [UIView transitionFromView:self.view    toView:storyCommentsVC.view    duration:.5  options:UIViewAnimationOptionTransitionCrossDissolve   completion:NULL];
    
    CABasicAnimation *crossFade = [CABasicAnimation animationWithKeyPath:@"contents"];

    crossFade.duration = 5.0;
    crossFade.fromValue =self.view.layer;
    crossFade.toValue = storyCommentsVC.view.layer;
   // [self.view.layer addAnimation:crossFade forKey:@"animateContents"];
    
    storyCommentsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    
    //[self.navigationController pushViewController:storyCommentsVC animated:NO];
    
    [self.navigationController presentViewController:storyCommentsVC animated:NO completion:^{
        
    }];
    
    //[HUD hide:YES];

}


#pragma mark - @end
#pragma mark -


@end
