
//  StoryCommentsVC.m
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 15/09/15.
//  Copyright (c) 2015 Mahesh Kumar Dhakad. All rights reserved.
//

//#import "HomePage.h"
//#import "MasterViewController.h"



#import "StoryCommentsVC.h"

#define WeightLABEL 20;

@interface StoryCommentsVC (){

    
    // For Story Full Image view
    IBOutlet UIView *view_FullStoryImage;
    IBOutlet UIImageView *img_full;
    IBOutlet UIButton *btn_sado;
    IBOutlet UIButton *btn_full;
    
    IBOutlet UIView *main_view;
    UIProgressView *progressView;

    NSString *nibName;
        
    // For Story Details
    IBOutlet UILabel *lbl_StoryKarma;
    IBOutlet UILabel *lbl_StoryUserName;
    IBOutlet UIButton  *btn_Follows;
    IBOutlet UIButton *btn_AddStory;
    IBOutlet UIImageView *imageView_StoryUser;
    IBOutlet UIImageView *imageView_StoryUserBG;
}




@end

@implementation StoryCommentsVC
@synthesize tv,moviePlayerView;

#pragma mark  - View Life Cycle
#pragma mark  -



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    nibName=nil;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"StoryCommentsVC";
            tvCellName=@"StoryCommentsTVCell";
            storyCellNibName = @"StoryPhotoTVCell";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"StoryCommentsVC_iPhone4";
            tvCellName=@"StoryCommentsTVCell";
            storyCellNibName = @"StoryPhotoTVCell_iPhone4";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"StoryCommentsVC_iPhone6";
            tvCellName=@"StoryCommentsTVCell_iPhone6";
            storyCellNibName = @"StoryPhotoTVCell_iPhone6";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"StoryCommentsVC_iPhone6Plus";
            tvCellName=@"StoryCommentsTVCell_iPhone6Plus";
            storyCellNibName = @"StoryPhotoTVCell_iPhone6Plus";
        }
    }
    else
    {
        nibName=@"StoryCommentsVC_iPad";
        tvCellName=@"StoryCommentsTVCell_iPad";
        storyCellNibName = @"StoryPhotoTVCell_iPad";
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
   // [[IQKeyboardManager sharedManager] setEnable:NO];
    nsud = [NSUserDefaults standardUserDefaults];
    currentUserId = [nsud objectForKey:@"LOGIN_USER_ID"];
    swipedCellIndexed= [[NSMutableArray alloc]init];
    
    if ([_str_UserId intValue] != [currentUserId intValue]) {
        [self check_isFollowing];
    }

    [self make_RoundedCorner];
    newHieght = 33;
    
    //tv.contentInset = UIEdgeInsetsZero;
   // self.automaticallyAdjustsScrollViewInsets = NO;
   // tv.tableHeaderView = view_Story;
    [self loadViews];
}
- (void)loadViews {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 48, self.view.frame.size.width, 48)];
        progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 24, self.view.frame.size.width, 48)];
        [progressView setTransform:CGAffineTransformMakeScale(1.0, 25.0)];
        commentTextView = [[MDGrowingTextView alloc] initWithFrame:CGRectMake(8, 7, self.view.frame.size.width-8-16-33, 33)];
        commentTextView.minNumberOfLines = 1;

    }else{
        
        containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 68, self.view.frame.size.width, 68)];
        progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 33, self.view.frame.size.width, 68)];
        [progressView setTransform:CGAffineTransformMakeScale(1.0, 35.0)];

        commentTextView = [[MDGrowingTextView alloc] initWithFrame:CGRectMake(8, 7.5, self.view.frame.size.width-8-16-55, 55)];
        commentTextView.minNumberOfLines = 2;

    }
    
    containerView.backgroundColor = [UIColor clearColor];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

    
    progressView.trackTintColor = [WebService colorWithHexString:@"64C8F0"];
    progressView.progressTintColor = [WebService colorWithHexString:@"F03264"];
    
    
   // progressView.center =  containerView.center;
    progressView.progress = .50;
    [containerView addSubview:progressView];
    
    [self.view addSubview:containerView];

    commentTextView.isScrollable = NO;
   // commentTextView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
    commentTextView.maxNumberOfLines = 4;
    // you can also set the maximum height in points with maxHeight
    // textView.maxHeight = 200.0f;
    //commentTextView.returnKeyType = UIReturnKeyGo; //just as an example
    commentTextView.font = [UIFont systemFontOfSize:15.0f];
    commentTextView.delegate = self;
  //  commentTextView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    commentTextView.backgroundColor = [UIColor whiteColor];
    commentTextView.placeholder = @"Write a comment";
    commentTextView.layer.cornerRadius = 3;
    commentTextView.layer.masksToBounds = YES;
   // commentTextView.text = @"Write a comment";
    commentTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [containerView addSubview:commentTextView];
    
    UIImage *sendBtnImage = [[UIImage imageNamed:@"send.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];

    btn_send = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        btn_send.frame = CGRectMake(self.view.frame.size.width - 41, 7.5, 33, 33);
    }else{
        btn_send.frame = CGRectMake(self.view.frame.size.width - 63, 6, 54, 54);
    }
    
    btn_send.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
   
    btn_send.layer.cornerRadius = btn_send.frame.size.width / 2;
    btn_send.layer.masksToBounds = YES;
    [btn_send addTarget:self action:@selector(addNewComment:) forControlEvents:UIControlEventTouchUpInside];
    [btn_send setImage:sendBtnImage forState:UIControlStateNormal];
    btn_send.backgroundColor = [UIColor whiteColor];

    [containerView addSubview:btn_send];
    
    
    

}

-(void)viewWillLayoutSubviews{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    // setup CommentBox
   // _arrayStory = [[nsud valueForKey:@"currentIndexStory"] copy];
    
    
    [self show_StroyDetails];

}

-(void)make_RoundedCorner{
    
    [tv setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [progressView setTransform:CGAffineTransformMakeScale(1.0, 24.0)];
    
    btn_AddStory.layer.cornerRadius = 3;
    btn_AddStory.layer.masksToBounds = YES;
    
    _btnAddNewStory.layer.cornerRadius = 3;
    _btnAddNewStory.layer.masksToBounds = YES;
    
    btn_Follows.layer.cornerRadius = 3;
    btn_Follows.layer.masksToBounds = YES;
    
    imageView_StoryUser.layer.cornerRadius = imageView_StoryUser.frame.size.width / 2;
    imageView_StoryUser.layer.masksToBounds = YES;
    
}


-(void)add_ProgressBar
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.tag = 444;

    [self.view addSubview:HUD];
    //HUD.labelText = @"Loading...";
    //HUD.detailsLabelText = @"Pdf..";
    
    float ff =[_karmaMeterPercent floatValue];
    progressView.progress = (ff/100);
    HUD.square = YES;
   // [HUD show:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Show Stroy Deatils
#pragma mark -

//
-(void)show_StroyDetails{
    
    arrayStoryComments = [[_arrayStory valueForKey:@"commentsList"] mutableCopy];
    array_AllStory = [[NSMutableArray alloc]init];
    
        NSDictionary *dict = [NSDictionary dictionaryWithObject:_arrayStory forKey:@"Keys"];
        
        dict = [dict objectForKey:@"Keys"];
    
    ModelClass *obj_MC = [self parsing_DataintoModelCalss:dict];
    
    float ff =[_karmaMeterPercent floatValue];
    progressView.progress = (ff/100);
    
    storyID = obj_MC.sty_storyid;
    

    NSString *Check_confid = obj_MC.sty_confidences;
    
    if ([Check_confid isEqualToString:@"1"])
    {
        lbl_StoryUserName.hidden = YES;
        lbl_StoryKarma.hidden = YES;
        lbl_StoryUserName.textColor = [UIColor lightGrayColor];
        lbl_StoryUserName.text = [NSString stringWithFormat:@"Confidential"];
        imageView_StoryUserBG.image = [UIImage imageNamed:@"confidential_icon.png"];
    }else{
        
        lbl_StoryUserName.hidden = NO;
        lbl_StoryKarma.hidden = NO;
        lbl_StoryKarma.text = [NSString stringWithFormat:@"%@",obj_MC.sub_user_karma];
        NSString *f = obj_MC.sub_user_firstName;
        NSString *l = obj_MC.sub_user_lastname;
        NSString *full = [NSString stringWithFormat:@"%@ %@",f,l];
        lbl_StoryUserName.textColor=[UIColor blackColor];
        lbl_StoryUserName.text =full;
        
        NSString *karmaMeterValue = obj_MC.sub_user_karma;
        
        if([karmaMeterValue intValue]<0)
        {
            imageView_StoryUserBG.image =[UIImage imageNamed:@"pink_user_image_default.png"];
            [lbl_StoryKarma setTextColor:[UIColor whiteColor]];
            
            imageView_StoryUserBG.transform = CGAffineTransformMakeRotation(-[karmaMeterValue floatValue] * M_PI/180);

        }else if([karmaMeterValue intValue]>0){
            
            imageView_StoryUserBG.image=[UIImage imageNamed:@"blue_user_image_default.png"];
            [lbl_StoryKarma setTextColor:[UIColor whiteColor]];
            
            imageView_StoryUserBG.transform = CGAffineTransformMakeRotation(-[karmaMeterValue floatValue] * M_PI/180);

        }else{
            
            imageView_StoryUserBG.image=[UIImage imageNamed:@"rad_blue_border_img.png"];
            [lbl_StoryKarma setTextColor:[UIColor blackColor]];
        }
        
            NSString *subjectUserImageURL =[NSString stringWithFormat:@"%@",obj_MC.sub_user_profilePicUrl];
            NSURL *URL=[NSURL URLWithString:subjectUserImageURL];
            imageView_StoryUser.backgroundColor = [UIColor whiteColor];

           // [imageView_StoryUser setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"default_img.png"]];
             imageView_StoryUser.imageURL = URL;
     }
    
    [tv reloadData];
    
}




-(ModelClass *)parsing_DataintoModelCalss:(NSDictionary *)dict{
    
    ModelClass *obj = [[ModelClass alloc] init];
    
    // For Story
    obj.sty_storyid=[NSString stringWithFormat:@"%@",[dict valueForKey:@"storyId"]];
    if([[dict valueForKey:@"voteType"] isEqual:[NSNull null]]){
        
        obj.voteType = [NSString stringWithFormat:@"2"];
    }else{
        obj.voteType = [NSString stringWithFormat:@"%@",[dict valueForKey:@"voteType"]];
    }
    obj.sty_goodvotes=[NSString stringWithFormat:@"%@",[dict valueForKey:@"goodVotes"]];
    obj.sty_badvotes=[NSString stringWithFormat:@"%@",[dict valueForKey:@"badVotes"]];
    obj.sty_contentvotes=[NSString stringWithFormat:@"%@",[dict valueForKey:@"content"]];
    obj.sty_commentvotes=[NSString stringWithFormat:@"%@",[dict valueForKey:@"comments"]];
    obj.Voteforstoryid=[NSString stringWithFormat:@"%@",[dict valueForKey:@"storyId"]];
    obj.sty_picUrl=[NSString stringWithFormat:@"%@",[dict valueForKey:@"picUrl"]];
    obj.createdate=[NSString stringWithFormat:@"%@",[dict valueForKey:@"created"]];
    //confidential
    obj.sty_confidences=[NSString stringWithFormat:@"%@",[dict valueForKey:@"confidential"]];
    obj.confidential=[dict valueForKey:@"confidential"];

    
    
    // For Story Tags

    NSMutableArray *tagstory =[dict objectForKey:@"storyTagMaps"];
    
    obj.tags_story = tagstory;
    
    NSMutableArray *stringTags = [[NSMutableArray alloc] init];

    for (int i =0; i<[tagstory count]; i++) {
        
        NSDictionary *dict1=[tagstory objectAtIndex:i];
        
        NSMutableArray *tagstory1=[dict1 objectForKey:@"tag"];
        // NSDictionary *dict11=[tagstory1 objectAtIndex:i];
        
        obj.tagstory_name=[NSString stringWithFormat:@"%@",[tagstory1 valueForKey:@"name"]];
        obj.tagstory_picUrl=[NSString stringWithFormat:@"%@",[tagstory1 valueForKey:@"picUrl"]];
        obj.tagstory_tagid=[NSString stringWithFormat:@"%@",[tagstory1 valueForKey:@"tagId"]];
        
        [stringTags addObject:obj.tagstory_tagid];

    }
    
    NSString *finalTags = [stringTags componentsJoinedByString:@","];
    
    obj.tags_ids_story = finalTags;
    // For Story Subject Details

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
    
    
    // For Story Author Details

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
    
    return obj;
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


#pragma mark  - addNewStory
#pragma mark  -


-(IBAction)addNewStory:(UIButton*)sender
{
    AddStoryViewController *addStory=[[AddStoryViewController alloc]initWithNibName:@"AddStoryViewController" bundle:nil];
    addStory.profile_mag=@"0";
    ModelClass *obj=[array_AllStory objectAtIndex:0];
    
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

#pragma mark  - action Follow Story
#pragma mark  -

-(IBAction)follow_Story:(UIButton*)sender
{
    [self toggle_Follower];
    
}

#pragma mark - check_isFollowing
#pragma mark -

-(void)check_isFollowing{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:_str_UserId forKey:@"userId"];
    
    WebService *api = [[WebService alloc] init];
    
    [api call_API:dict andURL:IS_FOLLOWING andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
        NSString *status_follow=[response valueForKey:@"status"];
        
        if([status_follow intValue] == 0)
        {
            [btn_Follows setTitle: @"+ follow" forState: UIControlStateNormal];
            [btn_Follows setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }else{
            
            [btn_Follows setTitle: @"- follow" forState: UIControlStateNormal];
            [btn_Follows setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        
        btn_Follows.hidden = false;
        
    }];
}


#pragma mark - toggle_Follower
#pragma mark -

-(void)toggle_Follower{
    
    [HUD show:YES];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:_str_UserId forKey:@"userId"];
    [dict setValue:@" " forKey:@"facebookId"];

    WebService *api = [[WebService alloc] init];
    
    [api call_API:dict andURL:TOGGLE_FOLLOWER andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
        [HUD hide:YES];
        
       // NSString *status_follow = [response valueForKey:@"status"];
        
        if([btn_Follows.titleLabel.text isEqualToString:@"+ follow"] )
        {
            [btn_Follows setTitle: @"- follow" forState: UIControlStateNormal];
            [btn_Follows setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }else{
            
            [btn_Follows setTitle: @"+ follow" forState: UIControlStateNormal];
            [btn_Follows setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
    }];
}


#pragma mark  - UITableView Methods
#pragma mark  -

///*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 0)];
    header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    header.backgroundColor = [UIColor grayColor];
    if (section==0) {
        return nil;
    }else{
        return nil;
    }
}
//*/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;//view_StoryImage.frame.size.height;
    }else{
        return 0;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
                
                if ([[UIScreen mainScreen] bounds].size.height==568){
                    return 202;
                }else if ([[UIScreen mainScreen] bounds].size.height==480){
                    return 150;
                }else if ([[UIScreen mainScreen] bounds].size.height==667){
                    return 300;
                }else if ([[UIScreen mainScreen] bounds].size.height==736){
                    return 320;
                }else{
                    return 202;
                }
            }else{
              return 425;
            }
        }else{
            return 127;
        }
    }else{
        return 127;
    }
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    //return 10;
    
    if (section==0) {
        
        return 2;
    
    }else{
        
        int commentCount = (int)[arrayStoryComments count];
        return commentCount;
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section!=0) {
        
        [cell.layer addSublayer:[WebService setBorderWithFrame:CGRectMake(0.0f, 0, cell.frame.size.width, 1.0f) andColor:[WebService colorWithHexString:@"d8d8d8"]]];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {

        return [self createStoryCell:indexPath];

    }else{
        
        return [self createStoryCommentsCell:indexPath];

    }
    
}


-(UITableViewCell *)createStoryCell:(NSIndexPath *)indexPath{
    
    StoryCommentsTVCell *cell=[tv dequeueReusableCellWithIdentifier:@"cell"];

    if (indexPath.row==0) {
        
        if(cell == nil){
            
            NSArray * nib = [[NSBundle mainBundle]loadNibNamed:storyCellNibName owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        ModelClass *obj =[array_AllStory objectAtIndex:0];

        NSString *rr=[NSString stringWithFormat:@"%@",obj.sty_picUrl];
        int lenh =(int)[rr length];
        int ind;
        if([rr isEqualToString:@""]){
           // NSURL *URL1=[NSURL URLWithString:rr];
           // [cell.imageView_Story setImageWithURL:URL1 placeholderImage:[UIImage imageNamed:@"default_img_story.png"]];
            [cell.btn_ShowStoryFullImage setTag:100];

        }
        else
        {
            ind =(lenh - 4);
            NSString *linkcheck =[rr substringFromIndex:ind];
            
            NSString *encodedUrl = [rr stringByAddingPercentEscapesUsingEncoding:
                                    NSUTF8StringEncoding];
            
            [cell.btn_ShowStoryFullImage setTag:indexPath.row];
            
            if([linkcheck length] < 4){
                
                [cell.btn_ShowStoryFullImage setTag:100];
                
            }if([linkcheck isEqualToString:@".jpg"]||[linkcheck isEqualToString:@".png"]||[linkcheck isEqualToString:@"jpeg"]){
                
                NSURL *URL1=[NSURL URLWithString:encodedUrl];
                //[cell.imageView_Story setImageWithURL:URL1];
                cell.imageView_Story.imageURL = URL1;
                cell.imageView_Story.backgroundColor = [UIColor whiteColor];

                cell.imageView_Story.layer.masksToBounds = YES;

            }else{
                
                NSString *youtubeID = [WebService extractYoutubeIdFromLink:rr];
                
                NSString *stringVideoURL =[NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg",youtubeID];
                
                NSURL *movieURL=[NSURL URLWithString:stringVideoURL];
                [cell.imageView_Story setImageWithURL:movieURL];
                [cell.btn_ShowStoryFullImage setImage:[UIImage imageNamed:@"video.png"] forState:UIControlStateNormal];
                cell.imageView_Story.layer.masksToBounds = YES;

            }
        }


        [cell.btn_ShowStoryFullImage addTarget:self action:@selector(show_FullStoryImage:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btn_StoryShare setTag:indexPath.row];
        
        [cell.btn_StoryShare addTarget:self action:@selector(shareStory:) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
            
        if(cell == nil){
            
            NSArray * nib = [[NSBundle mainBundle]loadNibNamed:tvCellName owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        [cell.view_CommentDeatils setBackgroundColor:[WebService colorWithHexString:@"F2F2F2"]];

        
        ModelClass *obj  = [array_AllStory objectAtIndex:0];
        
        
        NSString *createdate=obj.createdate;
        
        createdate = [self get_StoryCreateDate:createdate];
        
        cell.lbl_CommentCreateDate.text = createdate;
        
        [cell.btn_CommentUserProfile setTag:indexPath.row];
        [cell.btn_CommentUserProfile addTarget:self action:@selector(action_ShowStoryUserProfile:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *describtion = obj.sty_contentvotes;
        
      
        cell.lbl_CommentDesc.text = [NSString stringWithFormat:@"%@ ",describtion];
        
        cell.lbl_CommentDesc.frame = [self get_TextFrame:cell.lbl_CommentDesc];
        
        NSString *karmaMeterValue = obj.cat_user_karma;
        //  NSString *value = [checkusercolor substringToIndex:1];
        if([karmaMeterValue intValue]<0)
        {
            cell.imageView_CommentUserBG.image=[UIImage imageNamed:@"pink_user_image_default.png"];
            [cell.lbl_CommentKarma setTextColor:[UIColor whiteColor]];
            cell.imageView_CommentUserBG.transform = CGAffineTransformMakeRotation(-[karmaMeterValue floatValue] * M_PI/180);

        }
        else if([karmaMeterValue intValue]>0)
        {
            cell.imageView_CommentUserBG.image=[UIImage imageNamed:@"blue_user_image_default.png"];
            [cell.lbl_CommentKarma setTextColor:[UIColor whiteColor]];
            
            cell.imageView_CommentUserBG.transform = CGAffineTransformMakeRotation(-[karmaMeterValue floatValue] * M_PI/180);

        }else
        {
            cell.imageView_CommentUserBG.image=[UIImage imageNamed:@"rad_blue_border_img.png"];
            [cell.lbl_CommentKarma setTextColor:[UIColor blackColor]];
        }
        
        NSString *Check_confid = obj.sty_confidences;
        
        if ([Check_confid isEqualToString:@"1"])
        {
            cell.lbl_CommentUserName.hidden=YES;
            cell.lbl_CommentKarma.hidden=YES;
            cell.imageView_CommentUserBG.hidden=YES;
            // NSString *dd=obj.cat_user_profilePicUrl;
            cell.imageView_CommentUser.image=[UIImage imageNamed:@"confidential_icon.png"];
        }else{
            cell.lbl_CommentUserName.hidden=NO;
            cell.lbl_CommentKarma.hidden=NO;
            cell.imageView_CommentUserBG.hidden=NO;
            cell.imageView_CommentUser.image=[UIImage imageNamed:obj.cat_user_profilePicUrl];
            NSURL *URL=[NSURL URLWithString:obj.cat_user_profilePicUrl];
            cell.imageView_CommentUser.imageURL = URL;
            cell.imageView_CommentUser.backgroundColor = [UIColor whiteColor];

          //  [cell.imageView_CommentUser setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"default_img.png"]];
            NSString *name=obj.cat_user_firstName;
            NSString *lastname=obj.cat_user_lastname;
            cell.lbl_CommentUserName.text=[NSString stringWithFormat:@"%@ %@",name,lastname];
            
            cell.lbl_CommentKarma.text=[NSString stringWithFormat:@"%@ ",karmaMeterValue];
        }
        
        
        // For Swipe
        
        cell.btn_report.tag = -1;
        cell.btn_delete.tag = -1;
        cell.btn_confidential.tag = -1;
        cell.btn_preport.tag = -1;
        cell.btn_creport.tag = -1;
        
        if ([swipedCellIndexed containsObject:[NSString stringWithFormat:@"%li%li",(long)indexPath.section,(long)indexPath.row]]) {
            
            [self set_LeftFrame:indexPath andTVCell:cell];
            
        }
        [cell.btn_delete addTarget:self action:@selector(action_Delete:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btn_report addTarget:self action:@selector(action_Report:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btn_preport addTarget:self action:@selector(action_Report:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btn_creport addTarget:self action:@selector(action_Report:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btn_confidential addTarget:self action:@selector(action_Confidential:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        
        [cell.swipeGestureLeft addTarget:self action:@selector(handleSwipeGestureLeft:)];
        cell.swipeGestureRight.direction = UISwipeGestureRecognizerDirectionRight;
        [cell.swipeGestureRight addTarget:self action:@selector(handleSwipeGestureRight:)];
        
    }
    
    
    return cell;
}


-(UITableViewCell *)createStoryCommentsCell:(NSIndexPath *)indexPath{
    
    StoryCommentsTVCell *cell = [tv dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil){
        
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:tvCellName owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        
    }
        [cell.view_CommentDeatils setBackgroundColor:[UIColor clearColor]];

        NSArray *obj = [arrayStoryComments objectAtIndex:indexPath.row];
        
        NSArray *user =[obj valueForKey:@"user"];
        
        NSString *createdate=[obj valueForKey:@"created"];
        double dd1=[createdate longLongValue];
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(dd1 / 1000.0)];

        NSString *timeAgoDate = [self timeAgoStringFromDate:date];
        
        cell.lbl_CommentCreateDate.text= timeAgoDate ;
        
        NSString *describtion= [obj valueForKey:@"content"];
    
        cell.lbl_CommentDesc.text = [NSString stringWithFormat:@"%@ ",describtion];

        cell.lbl_CommentDesc.frame = [self get_TextFrame:cell.lbl_CommentDesc];
    
        NSString *Check_confid=[user valueForKey:@"content"];
        
        if ([Check_confid isEqualToString:@"1"])
        {
            cell.lbl_CommentUserName.hidden=YES;
            cell.imageView_CommentUserBG.hidden=YES;
            cell.imageView_CommentUser.image=[UIImage imageNamed:@"confidential_icon.png"];
        }else{
            
            cell.lbl_CommentUserName.hidden=NO;
            cell.lbl_CommentKarma.hidden=NO;
            cell.imageView_CommentUserBG.hidden=NO;
            
            NSString *name=[user valueForKey:@"firstName"];
            NSString *lastname=[user valueForKey:@"lastName"];
            cell.lbl_CommentUserName.text=[NSString stringWithFormat:@"%@ %@",name,lastname];
            cell.lbl_CommentKarma.text=[NSString stringWithFormat:@"%@ ",[user valueForKey:@"karma"]];
            
            NSURL *URL=[NSURL URLWithString:[user valueForKey:@"profilePicUrl"]];
            cell.imageView_CommentUser.backgroundColor = [UIColor whiteColor];
           // [cell.imageView_CommentUser setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"default_img.png"]];
            cell.imageView_CommentUser.imageURL = URL;

            NSString *karmaMeterValue = [user valueForKey:@"karma"];
            //  NSString *value = [checkusercolor substringToIndex:1];
            
            if([karmaMeterValue intValue]<0)
            {
                cell.imageView_CommentUserBG.image=[UIImage imageNamed:@"pink_user_image_default.png"];
                [cell.lbl_CommentKarma setTextColor:[UIColor whiteColor]];
                
                cell.imageView_CommentUserBG.transform = CGAffineTransformMakeRotation(-[karmaMeterValue floatValue] * M_PI/180);
            }
            else if([karmaMeterValue intValue]>0)
            {
                cell.imageView_CommentUserBG.image=[UIImage imageNamed:@"blue_user_image_default.png"];
                [cell.lbl_CommentKarma setTextColor:[UIColor whiteColor]];
                
                cell.imageView_CommentUserBG.transform = CGAffineTransformMakeRotation(-[karmaMeterValue floatValue] * M_PI/180);

            }else
            {
                cell.imageView_CommentUserBG.image=[UIImage imageNamed:@"rad_blue_border_img.png"];
                [cell.lbl_CommentKarma setTextColor:[UIColor blackColor]];
            }
        }
    
        [cell.btn_CommentUserProfile setTag:indexPath.row];
        [cell.btn_CommentUserProfile addTarget:self action:@selector(action_ShowCommentUserProfile:) forControlEvents:UIControlEventTouchUpInside];
    
    // For Swipe
    
    cell.btn_report.tag = indexPath.row;
    cell.btn_delete.tag = indexPath.row;
    cell.btn_confidential.tag = indexPath.row;
    cell.btn_preport.tag = indexPath.row;
    cell.btn_creport.tag = indexPath.row;

    if ([swipedCellIndexed containsObject:[NSString stringWithFormat:@"%li%li",(long)indexPath.section,(long)indexPath.row]]) {
        
        
        [self set_LeftFrame:indexPath andTVCell:cell];
        
    }
    [cell.btn_delete addTarget:self action:@selector(action_Delete:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btn_preport addTarget:self action:@selector(action_Report:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btn_report addTarget:self action:@selector(action_Report:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn_creport addTarget:self action:@selector(action_Report:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btn_confidential addTarget:self action:@selector(action_Confidential:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [cell.swipeGestureLeft addTarget:self action:@selector(handleSwipeGestureLeft:)];
    cell.swipeGestureRight.direction = UISwipeGestureRecognizerDirectionRight;
    [cell.swipeGestureRight addTarget:self action:@selector(handleSwipeGestureRight:)];
    
    return cell;

}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


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


#pragma mark - UISwipeGestureRecognizer Methods
#pragma mark -


-(void)handleSwipeGestureLeft:(UISwipeGestureRecognizer *)sender{
    
    
    StoryCommentsTVCell *cell = (StoryCommentsTVCell *)sender.view;
    
    NSIndexPath *indexPath = [tv indexPathForCell:cell];
    
    if (![swipedCellIndexed containsObject:[NSString stringWithFormat:@"%li%li",(long)indexPath.section,(long)indexPath.row]]) {
        
        [swipedCellIndexed addObject:[NSString stringWithFormat:@"%li%li",(long)indexPath.section,(long)indexPath.row]];
        
        NSLog(@"handleSwipeGesture Left called");
        
        [UIView beginAnimations:@"SwipeLeft" context:nil];
        [UIView setAnimationDelay:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        [self set_LeftFrame:indexPath andTVCell:cell];
        
        [UIView commitAnimations];
        
    }
    
}

-(void)set_LeftFrame:(NSIndexPath *)indexPath andTVCell:(StoryCommentsTVCell *)cell{
    
    isAuthor = @"0";
    
    ModelClass *obj_Story  = [array_AllStory objectAtIndex:0];
    NSString *authorUserID = obj_Story.cat_user_userId;
    NSString *subjectUserID = obj_Story.sub_user_userId;

    if (indexPath.section == 0) {
            
            if ([authorUserID intValue] == [currentUserId intValue]) {
                isAuthor = @"1";
            }
                if([currentUserId intValue] == [authorUserID intValue]&& [currentUserId intValue] == [subjectUserID intValue]){
                    
                    cell.btn_creport.hidden = true;
                    cell.btn_preport.hidden = true;
                    [cell.cell_View setFrame:CGRectMake(-(cell.btn_delete.frame.size.width*3),0, cell.cell_View.frame.size.width, cell.cell_View.frame.size.height)];
                    
                }else if([currentUserId intValue] == [authorUserID intValue]){
                    
                    cell.btn_creport.hidden = false;
                    cell.btn_preport.hidden = true;
                    [cell.cell_View setFrame:CGRectMake(-(cell.btn_delete.frame.size.width*2),0, cell.cell_View.frame.size.width, cell.cell_View.frame.size.height)];
                }else{
                    
                    cell.btn_creport.hidden = true;
                    cell.btn_preport.hidden = false;
                    [cell.cell_View setFrame:CGRectMake(-(cell.btn_delete.frame.size.width),0, cell.cell_View.frame.size.width, cell.cell_View.frame.size.height)];
                }

    }else{
            
            NSArray *obj = [arrayStoryComments objectAtIndex:indexPath.row];
            NSArray *user =[obj valueForKey:@"user"];
            
            NSString *strUserid = [user valueForKey:@"userId"];
            
            if ([strUserid intValue] == [currentUserId intValue]) {
                isAuthor = @"1";
            }
            
            if([isAuthor intValue] == 1){
                    [cell.cell_View setFrame:CGRectMake(-cell.btn_delete.frame.size.width*2,0, cell.cell_View.frame.size.width, cell.cell_View.frame.size.height)];
                    cell.btn_preport.hidden = true;
                    cell.btn_creport.hidden = false;

                }else{
                    cell.btn_creport.hidden = true;
                    cell.btn_preport.hidden = false;
                    [cell.cell_View setFrame:CGRectMake(-cell.btn_delete.frame.size.width,0, cell.cell_View.frame.size.width, cell.cell_View.frame.size.height)];
                }
    }
    

}

-(void)handleSwipeGestureRight:(UISwipeGestureRecognizer *)sender{
    
    StoryCommentsTVCell *cell = (StoryCommentsTVCell *)sender.view;
    
    NSLog(@"handleSwipeGesture Right called");
    
    
    NSIndexPath *indexPath = [tv indexPathForCell:cell];
    
    if ([swipedCellIndexed containsObject:[NSString stringWithFormat:@"%li%li",(long)indexPath.section,(long)indexPath.row]] ) {
        
        [swipedCellIndexed removeObject:[NSString stringWithFormat:@"%li%li",(long)indexPath.section,(long)indexPath.row]];
        
        [UIView beginAnimations:@"SwipeRight" context:nil];
        [UIView setAnimationDelay:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [cell.cell_View setFrame:CGRectMake(0,0, cell.cell_View.frame.size.width, cell.cell_View.frame.size.height)];
        [UIView commitAnimations];
        
    }
    
}


#pragma mark - Swipe View UIButton Action Methods
#pragma mark -

// UPDATE_STORY Methods

-(void)action_Confidential:(UIButton *)sender{
    
  //  currentStoryIndex = [NSString stringWithFormat:@"%li",(long)sender.tag];
    
    NSLog(@"sender tag : %li",(long)sender.tag);
    
    [HUD show:YES];
    
    ModelClass *obj = [array_AllStory objectAtIndex:0];
    NSString *storyId = obj.sty_storyid;
    NSString *storyConfidential = obj.confidential;
    
    NSMutableDictionary *dictParam = [[NSMutableDictionary alloc]init];
    
    [dictParam setValue:obj.tagstory_tagid forKey:@"tags"];
    [dictParam setValue:storyId forKey:@"storyId"];
    [dictParam setValue:obj.sty_contentvotes forKey:@"content"];
    [dictParam setValue:obj.sty_picUrl forKey:@"picUrl"];
    
    if ([storyConfidential intValue]==0) {
        [dictParam setValue:@"1" forKey:@"confidential"];
    }else{
        [dictParam setValue:@"0" forKey:@"confidential"];
    }
    NSLog(@"dictParam : %@",dictParam);
    
    WebService *api = [[WebService alloc] init];
    
    [api call_API:dictParam andURL:UPDATE_STORY andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
        [HUD hide:YES];
        
        NSMutableArray *arr_Response = [NSMutableArray arrayWithObject:response];
        
        NSArray *allKeys = [response allKeys];
        
        NSLog(@"UPDATE_STORY response : %@",response);
        
        if (![allKeys containsObject:@"errors"])
        {
            NSDictionary *dict = [arr_Response objectAtIndex:0];
            
            [array_AllStory replaceObjectAtIndex:0 withObject:[self parsing_DataintoModelCalss:dict]];
            
            _arrayStory = response;
            
            [self show_StroyDetails];

        }else{
            
            NSArray *errors = [arr_Response valueForKey:@"errors"];
            
            NSString *mgs = [[errors valueForKey:@"exception"] objectAtIndex:0];
            NSString *sts = [NSString stringWithFormat:@"%@",[arr_Response valueForKey:@"status"]];
            NSLog(@"UPDATE_STORY mgs : %@",mgs);
            NSLog(@"UPDATE_STORY sts : %@",sts);
            
            if ([sts intValue] == 0) {
                
                [[[UIAlertView alloc] initWithTitle:@"Error" message:mgs delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];
            }
        }
        
        
    }];
}


-(void)action_Delete:(UIButton *)sender{
    
    if (sender.tag==-1) {
        
        isReportandDelete = @"Story";
        
    }else{
        
        isReportandDelete = @"comment";
        NSArray *obj = [arrayStoryComments objectAtIndex:sender.tag];
        commentID =[obj valueForKey:@"commentId"];
    }
    [self call_DeleteStoryorCommentAPI:(int)sender.tag];
}

-(void)action_Report:(UIButton *)sender{
    reportIndex = sender.tag;
    
    if (sender.tag==-1) {
         isReportandDelete = @"Story";
    }else{
        isReportandDelete = @"comment";
        NSArray *obj = [arrayStoryComments objectAtIndex:sender.tag];
        commentID =[obj valueForKey:@"commentId"];
    }
    //For Report
    [self action_showReportOptions];
}





#pragma mark - Show  Report Option
#pragma mark -


-(void)action_showReportOptions
{
    UIActionSheet *ActionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"inappropriate content",@"feels like spam/scam",@"creator is offensive", nil];
    
    ActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    ActionSheet.tag = 1;
    [ActionSheet showInView:self.view];
    
}

-(void)call_ReportStoryAPI:(NSString *)reportFor{
    
    [HUD show:YES];
    
    WebService *api=[[WebService alloc] init];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    if ([isReportandDelete isEqualToString:@"Story"]) {
        [dic setObject:storyID forKey:@"storyId"];
    }else{
        [dic setObject:commentID forKey:@"commentId"];
    }
    
    [dic setObject:reportFor forKey:@"status"];
    
    [api call_API:dic andURL:REPORT andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
        [HUD hide:YES];
        
        if ([isReportandDelete isEqualToString:@"Story"]) {
            
            [_storyCommentsView setHidden:YES];
            [containerView setHidden:YES];
            [_btnAddNewStory setHidden:NO];
            
        }else{
            
            NSString *removeSwipedCellIndexed =[NSString stringWithFormat:@"%@%li",@"1",(long)reportIndex];
            
            [swipedCellIndexed removeObject:removeSwipedCellIndexed];
            
            [arrayStoryComments removeObjectAtIndex:reportIndex];
            [tv reloadData];
        }
    }];
}

#pragma mark - UIActionSheet Delegate
#pragma mark -


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag ==0) {
        
        
        
    }else  if (actionSheet.tag ==1){
        
        if (buttonIndex==0) {
             [self call_ReportStoryAPI:@"R1"]; //For inappropriate content
        }else if (buttonIndex==1) {
            [self call_ReportStoryAPI:@"R2"]; // feels like spam/scam
        }else if (buttonIndex==2) {
             [self call_ReportStoryAPI:@"R4"]; // For creator is offensive
        }else{
            // For cancel
        }

    }
    
    
}

#pragma mark - Call Delete Story and Comment API
#pragma mark -

-(void)call_DeleteStoryorCommentAPI:(int)index{
    
    [HUD show:YES];

    WebService *api=[[WebService alloc] init];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    if ([isReportandDelete isEqualToString:@"Story"]) {
        [dic setObject:storyID forKey:@"storyId"];
    }else{
        [dic setObject:commentID forKey:@"commentId"];
    }
    
    [api call_API:dic andURL:DELETE andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){

        [HUD hide:YES];
        
        if ([isReportandDelete isEqualToString:@"Story"]) {
            
            [_storyCommentsView setHidden:YES];
            [_btnAddNewStory setHidden:NO];
            [containerView setHidden:YES];

        }else{
            
            NSString *removeSwipedCellIndexed =[NSString stringWithFormat:@"%@%i",@"1",index];

            [swipedCellIndexed removeObject:removeSwipedCellIndexed];

            [arrayStoryComments removeObjectAtIndex:index];
            [tv reloadData];
        }
    }];
}



#pragma mark -  Posting Data On Facebook
#pragma mark  -


-(void)shareStory:(UIButton*)sender{
    
    
    ModelClass *obj = [array_AllStory objectAtIndex:0];

    if ([obj.sty_picUrl isEqualToString:@""]) {
        
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No Image Available to share" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];

    }else{
        
        NSString *contentvotes = [NSString stringWithFormat:@"%@",obj.sty_contentvotes];
        
        NSString *authorFullName = [NSString stringWithFormat:@"%@ %@",obj.cat_user_firstName,obj.cat_user_lastname];
        
        NSString *subjectFullName = [NSString stringWithFormat:@"%@ %@",obj.sub_user_firstName,obj.sub_user_lastname];
        
        NSString *strImageURL = [NSString stringWithFormat:@"%@",obj.sty_picUrl];
        NSString *encodedImageURL = [strImageURL stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding];
        NSURL *imgURL = [NSURL URLWithString:encodedImageURL];

        NSString *strContentURL =[NSString stringWithFormat:@"http://karma.vote/story.html?storyid=%@",storyID];
        NSString *encodedContentURL = [strContentURL stringByAddingPercentEscapesUsingEncoding:  NSUTF8StringEncoding];
        NSURL *contentURL = [NSURL URLWithString:encodedContentURL];
        
        NSString *confidential  = obj.sty_confidences;
        
        NSString *contentDescription ;
        
        if (![confidential isEqualToString:@"1"]){
            contentDescription = [NSString stringWithFormat:@"%@ posted a story about %@",authorFullName,subjectFullName];
        }else{
            contentDescription = @"" ;
        }
        
        FBLinkShareParams *params = [[FBLinkShareParams alloc] initWithLink:contentURL name:contentvotes caption:nil description:contentDescription picture:imgURL];
        
        NSMutableDictionary *dictParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:contentvotes, @"name",@"", @"caption",contentDescription, @"description", strContentURL, @"link",strImageURL, @"picture",nil];
        
     
        // If the Facebook app is installed and we can present the share dialog
        if ([FBDialogs canPresentShareDialogWithParams:params]) {
            
//            [FBDialogs presentMessageDialogWithLink:contentURL name:contentvotes caption:nil description:contentDescription picture:imgURL clientState:nil handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
//            
//                
//            }];
            
            
            FBAppCall *appCall= nil;
            appCall = [FBDialogs
                       presentShareDialogWithLink : contentURL
                       name : contentvotes
                       caption : nil
                       description : contentDescription
                       picture : imgURL
                       clientState : nil
                       handler : ^(FBAppCall *call, NSDictionary *results, NSError *error) {
                           if (error) {
                               NSLog(@"Error: %@", error.description);
                           } else {
                              NSLog(@"FB Post Success!");
                           }
                       }
                ];
            
//            [FBDialogs presentMessageDialogWithParams:params clientState:nil
//                                              handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
//                                                  if(error) {
//                                                      
//                                                  } else {
//                                                      // Success
//                                                      NSLog(@"result %@", results);
//                                                  }
//                                              }];
            // Next try to post using Facebook's iOS6 integration
           
            
            // If the Facebook app is NOT installed and we can't present the share dialog
        } else {
            // FALLBACK: publish just a link using the Feed dialog
            // Show the feed dialog
            [FBWebDialogs presentFeedDialogModallyWithSession:nil parameters:dictParams handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error)
             { if (error) {                           // An error occurred, we need to handle the error
                // See: https://developers.facebook.com/docs/ios/errors
                NSLog(@"Error publishing story: %@", error.description);
            } else {
                if (result == FBWebDialogResultDialogNotCompleted) {
                    // User cancelled.
                    NSLog(@"User cancelled.");
                } else{                                                              //Handle the publish feed callback
                    NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                    if (![urlParams valueForKey:@"post_id"]) {
                        
                    } else {
                        // User clicked the Share button
                        // NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                        // NSLog(@"result %@", result);
                    }
                }
            }
             }];
        }
        
    }
    
}

// A function for parsing URL parameters returned by the Feed Dialog.
- (NSDictionary*)parseURLParams:(NSString *)query {
    
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}



#pragma mark -  Show Comment User  Profile Methons
#pragma mark -

-(void)action_ShowCommentUserProfile:(UIButton*)sender{
    
    //Modelclass *obj1=[arrayStoryComments objectAtIndex:sender.tag];
    
    Profile *pro=[[Profile alloc]initWithNibName:@"Profile" bundle:nil];
    NSArray *obj1 = [arrayStoryComments objectAtIndex:sender.tag];
    
    NSArray *user =[obj1 valueForKey:@"user"];
    
    NSString *strUserid=[user valueForKey:@"userId"];
    
    if ([currentUserId intValue]==[strUserid intValue]) {
        pro.str_ProfileOwner = @"1";
    }else{
        pro.str_ProfileOwner = @"0";
    }
    
    pro.str_UserId=strUserid;
    
    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_ISVC.topViewController = pro;
    [self.navigationController pushViewController:obj_ISVC animated:NO];
    
}

#pragma mark -  Show Story User  Profile Methons
#pragma mark -

-(void)action_ShowStoryUserProfile:(UIButton*)sender{
    
    ModelClass *obj = [array_AllStory objectAtIndex:0];
    
    Profile *pro=[[Profile alloc]initWithNibName:@"Profile" bundle:nil];
    
    NSString *strUserid=obj.cat_user_userId;
    
    if ([currentUserId intValue]==[strUserid intValue]) {
        pro.str_ProfileOwner = @"1";
    }else{
        pro.str_ProfileOwner = @"0";
    }
    
    pro.str_UserId=strUserid;
    
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


-(IBAction)show_StorySubjectUserProfile:(UIButton *)sender
{
    ModelClass *obj=[array_AllStory objectAtIndex:0];
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


#pragma  mark - Show / Hide Full Story Image
#pragma  mark -

-(IBAction)hide_FullStoryImage:(id)sender
{
    isZoomImage = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self setNeedsStatusBarAppearanceUpdate];
    view_FullStoryImage.hidden = YES;
}


-(void)show_FullStoryImage:(UIButton *)sender{
    
    
    ModelClass *obj=[array_AllStory objectAtIndex:0];
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
        
        if (sender.tag!=100) {
            isZoomImage = YES;

            [[UIApplication sharedApplication] setStatusBarHidden:YES];
            [self setNeedsStatusBarAppearanceUpdate];
            
        // [img_full setImageWithURL:[NSURL URLWithString:story_PicURL] placeholderImage:[UIImage imageNamed:@"default_img.png"]];
        img_full.imageURL = [NSURL URLWithString:story_PicURL];

         view_FullStoryImage.hidden = NO;
         view_FullStoryImage.layer.zPosition = 1;
            img_full.imageURL = [NSURL URLWithString:story_PicURL];
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
  //  MPMoviePlayerViewController *moviePlayer = [notification object];
    
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


#pragma mark - other action Methods
#pragma mark -


-(void)fb_Logout
{
    [FBSession.activeSession closeAndClearTokenInformation];
    [FBSession.activeSession close];
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 12) {
        // it's the Error alert
        if (buttonIndex == 0) {
            
            // and they clicked OK.
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
            NSLog(@"Yess");
        }else{
            
            
        }
    }
}




#pragma mark -  Show My Profile Methons
#pragma mark -


-(IBAction)action_ShowMyProfile:(UIButton *)sender
{
    sender.adjustsImageWhenHighlighted = false;

    Profile *pro=[[Profile alloc]initWithNibName:@"Profile" bundle:nil];
    pro.str_ProfileOwner = @"1";
    
    pro.str_UserId = currentUserId;
    
    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_ISVC.topViewController = pro;
    
    [self.navigationController pushViewController:obj_ISVC animated:NO];
}



#pragma mark  - action_Refresh COMMENTS
#pragma mark  -


-(IBAction)action_Refresh:(id)sender{

    [self get_StoryComments];
}



- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma mark  - Call API GET_COMMENTS
#pragma mark  -

-(void)get_StoryComments{
    
    [HUD show:YES];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:storyID forKey:@"storyId"];
    [dict setValue:@"0" forKey:@"offset"];
    
    WebService *api = [[WebService alloc] init];
    
    [api call_API:dict andURL:GET_COMMENTS andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
        arrayStoryComments = [[NSMutableArray alloc]init];
        [swipedCellIndexed removeAllObjects];

        [HUD hide:YES];
        
        arrayStoryComments = [response mutableCopy] ;
        
        [tv reloadData];
    }];
}


#pragma mark -  Comments on Story
#pragma mark  -

-(IBAction)addNewComment:(id)sender
{
    [commentTextView resignFirstResponder];
    
    if ([commentTextView.text isEqualToString:@"Write a comment"]||[commentTextView.text isEqualToString:@""]||[commentTextView.text length]==0) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Message"message:@"Please Enter Comment"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }else{
        
        [HUD show:YES];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setValue:commentTextView.text forKey:@"content"];
        [dict setValue:storyID forKey:@"story.storyId"];
        
        WebService *api=[[WebService alloc] init];
        
        [api call_API:dict andURL:ADD_COMMENT andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
            
            [HUD hide:YES];
            
            commentTextView.text=@"";
            [arrayStoryComments addObject:response];
            [tv reloadData];
            [self tableviewScrollAtBottom];
        }];
    }
}


-(void)tableviewScrollAtBottom{
    
    
    double  y = tv.contentSize.height - tv.bounds.size.height; CGPoint bottomOffset = CGPointMake(0, y);
    
    if (y > -tv.contentInset.top)
        
        [tv setContentOffset:bottomOffset animated:YES];
    
}

#pragma mark  - UITextView Delegate
#pragma mark  -

- (void)textFieldDidBeginEditing:(UITextField *)textField{


}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    
   // [self textViewDidChange:textView_Comment];
    
    if (textView.text.length + text.length > 35){
        if (location != NSNotFound){
            [textView resignFirstResponder];
        }
        return YES;
    }
    else if (location != NSNotFound){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    textView.frame = newFrame;
    
     isChangeHieght = newSize.height- newHieght;
    
    if (isChangeHieght > 0) {
        newHieght = newSize.height;
       // textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y-isChangeHieght,fmaxf(newSize.width, fixedWidth),newSize.height);
        isChangeHieght = 0;
    }
    
    
    //textView.center = _footerView.center;
}

-(void)resignTextView
{
    [commentTextView resignFirstResponder];
}

- (void)growingTextView:(MDGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    CGRect r = containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    containerView.frame = r;
    
    CGRect frame = btn_send.frame;
    frame.origin.y = btn_send.frame.origin.y+(diff/2);
    //  btn_send.frame = frame;
    
    [progressView setTransform:CGAffineTransformMakeScale(1.0, containerView.frame.size.height/2)];
    progressView.center = CGPointMake( containerView.frame.size.width/2, containerView.frame.size.height/2); // set center

}



#pragma mark  - StatusBarHidden
#pragma mark  -


- (BOOL)prefersStatusBarHidden {
    
    if (isZoomImage) {
        return YES;
    }else{
        return NO;
    }
}

//4514 5700 0594 8347 qwerty

#pragma mark  - @end
#pragma mark  -

@end
