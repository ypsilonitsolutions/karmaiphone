//
//  Profile.m
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 04/09/15.
//  Copyright (c) 2015 MaheshDhakad. All rights reserved.
//

#import "Profile.h"

@interface Profile () {
    
    NSMutableArray *swipedCellIndexed,*arrayTVData;
    
    IBOutlet UICollectionView *collectionview;
    IBOutlet UILabel *lbl_proname;
    IBOutlet UILabel *lbl_profol;
    IBOutlet UILabel *lbl_prostroy;
    
    NSString *user_ProfileName;
    NSString *user_ProfilePics;
    IBOutlet UIButton *btn_Story;
    NSMutableArray *arrayStroyDetails;
    
}

@end

@implementation Profile


@synthesize tv_ProfileStory,str_UserId,str_ProfileOwner;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"Profile";
            commentTVCellNibName = @"StoryTVCell";
            profileFollowerCellNibName = @"ProfileFollowerCell";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"Profile";
            commentTVCellNibName = @"StoryTVCell";
            profileFollowerCellNibName = @"ProfileFollowerCell";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"Profile_iPhone6";
            commentTVCellNibName = @"StoryTVCell_iPhone6";
            profileFollowerCellNibName = @"ProfileFollowerCell";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"Profile_iPhone6";
            commentTVCellNibName = @"StoryTVCell_iPhone6Plus";
            profileFollowerCellNibName = @"ProfileFollowerCell";
        }
    }
    else
    {
         nibName=@"Profile_iPad";
        commentTVCellNibName = @"StoryTVCell_iPad";
        profileFollowerCellNibName = @"ProfileFollowerCell";
    }
    
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    
    if (self)
    {
       
    }
    return self;
}

#pragma mark - View life Cycle
#pragma mark -

-(void)loadViews{
    
    if([str_ProfileOwner intValue] == 0){
        
        [self check_isFollowing];
    }
    
    btn_follows.hidden = true;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self progressBar];

    nsud = [NSUserDefaults standardUserDefaults];

    btn_follows.backgroundColor=[UIColor colorWithRed:0.663 green:0.663 blue:0.659 alpha:1];
    btn_Story.backgroundColor=[UIColor colorWithRed:0.663 green:0.663 blue:0.659 alpha:1];
    btn_follows.layer.cornerRadius=3;
    btn_follows.layer.masksToBounds=YES;
    btn_Story.layer.cornerRadius=3;
    btn_Story.layer.masksToBounds=YES;
    
    img_banner.layer.cornerRadius = img_banner.frame.size.height/2.0;
    lbl_bg.hidden=YES;
    
    nibName = @"Profile";
    
    [collectionview registerNib:[UINib nibWithNibName:profileFollowerCellNibName bundle:nil] forCellWithReuseIdentifier:@"CELL"];
            
    img_banner.layer.cornerRadius = img_banner.frame.size.width / 2;
    img_banner.layer.masksToBounds = YES;
    
    
    currentUserId = [nsud objectForKey:@"LOGIN_USER_ID"];
    
    
    arrayProfileStory = [[NSMutableArray alloc]init];
    arrayTVData = [[NSMutableArray alloc]init];
    arrayStory = [[NSMutableArray alloc]init];
    
    
   

}


-(void)viewWillLayoutSubviews{
    

}

-(void)viewWillAppear:(BOOL)animated
{
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  =[[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    // [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    [self call_AllAPI];
}

-(void)call_AllAPI{
    
    [arrayStory removeAllObjects];
    [arrayTVData removeAllObjects];
     [self.tv_ProfileStory reloadData];
    [self loadViews];

    pageCount = @"0";
    arrayStroyDetails = [NSMutableArray new];
    swipedCellIndexed = [NSMutableArray new];
    
    [self get_Profile];
    
    [self get_ProfileFollowers];
    
    [self get_ProfileStory];
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:MDRight];
}


- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - UICollectionView Delegate
#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [arrayProfileFollowers count];
}

- (ProfileFollowerCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProfileFollowerCell *cell = [collectionview dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    ModelClass *obj = [arrayProfileFollowers objectAtIndex:indexPath.row];
    
    cell.lbl_Counter.text= obj.sub_user_karma;
    cell.lbl_Name.text =obj.sub_user_firstName;

    NSURL *URL = [NSURL URLWithString:obj.sub_user_profilePicUrl];
    
#define IMAGE_VIEW_TAG 99
    
    cell.imageView_ProfilePic.tag = IMAGE_VIEW_TAG;
    
    //get image view
    MDImageView *imageView = (MDImageView *)[cell viewWithTag:IMAGE_VIEW_TAG];
    
    //cancel loading previous image for cell
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:imageView];

    //[cell.imageView_ProfilePic setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"default_user_icon.png"]];
    
    if (URL != nil) {
        cell.imageView_ProfilePic.imageURL = URL;
    }
    
    
    cell.imageView_ProfilePic.contentMode = UIViewContentModeScaleAspectFill;
    
    NSString *_karmaMeterValue = obj.sub_user_karma;

        if([_karmaMeterValue intValue] > 0){
            
            cell.imageView_BG.image=[UIImage imageNamed:@"blue_user_image_default.png"];
            [cell.lbl_Counter setTextColor:[UIColor whiteColor]];
            
            cell.imageView_BG.transform = CGAffineTransformMakeRotation(-[_karmaMeterValue floatValue] * M_PI/180);

        }else if([_karmaMeterValue intValue] < 0){
            
            cell.imageView_BG.image=[UIImage imageNamed:@"pink_user_image_default.png"];
            [cell.lbl_Counter setTextColor:[UIColor whiteColor]];

            cell.imageView_BG.transform = CGAffineTransformMakeRotation(-[_karmaMeterValue floatValue] * M_PI/180);

        }else{
           
            cell.imageView_BG.image=[UIImage imageNamed:@"rad_blue_border_img.png"];
            [cell.lbl_Counter setTextColor:[UIColor blackColor]];

        }
    cell.btn_prf.tag=indexPath.row;
    [cell.btn_prf addTarget:self action:@selector(changeProfile:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
  
    
}

#pragma mark - changeProfile
#pragma mark -

-(void)changeProfile:(UIButton *)sender{
    
    ModelClass *obj = [arrayProfileFollowers objectAtIndex:sender.tag ];
    
    NSString *strUserID = obj.sub_user_userId;

    if ([strUserID intValue]==[currentUserId intValue]) {
        
        str_UserId = obj.sub_user_userId;
        str_ProfileOwner = @"1";
        
    }else{
        
        str_ProfileOwner = @"0";
        str_UserId = obj.sub_user_userId;
    }
    
    [self call_AllAPI];

}


-(void)changedProfile:(UIButton *)sender{
    
    ModelClass *obj = [arrayProfileFollowers objectAtIndex:sender.tag ];

    Profile *pro=[[Profile alloc]initWithNibName:@"Profile" bundle:nil];
    
    NSString *strUserID = obj.sub_user_userId;
    
    if ([strUserID intValue]==[currentUserId intValue]) {
        pro.str_UserId = obj.sub_user_userId;
        pro.str_ProfileOwner = @"1";
    }else{
        pro.str_ProfileOwner = @"0";
        pro.str_UserId = obj.sub_user_userId;
    }
    
    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_ISVC.topViewController = pro;
    
    [self.navigationController pushViewController:obj_ISVC animated:NO];

}

#pragma mark - get_ProfileStory
#pragma mark -

-(void)get_Profile{
    
    [HUD show:YES];
   
    arrayProfileInfo =[[NSMutableArray alloc]init];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    int userType =[str_ProfileOwner intValue];
    
    if(userType == 0)
    {
        [dict setValue:str_UserId forKey:@"userId"];
        
    }else{
        
        [dict setValue:currentUserId forKey:@"userId"];
        
    }
    
    
    WebService *api = [[WebService alloc] init];
    
    [api call_API:dict andURL:GET_PROFILE andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
       // [HUD hide:YES];
        
        arrayProfileInfo = response;
        
        NSString *name=[response valueForKey:@"firstName"];
        NSString *lastname=[response valueForKey:@"lastName"];
        
        NSString *strFullName = [NSString stringWithFormat: @"%@ %@", name ,lastname];
        
        user_ProfileName = strFullName;
        
        user_ProfilePics=[response valueForKey:@"profilePicUrl"];
        
        lbl_karmavote.text=[NSString stringWithFormat:@"%@",[response valueForKey:@"karma"]];
        str_counter=[response valueForKey:@"karma"];
        lbl_profol.text=[NSString stringWithFormat:@"%@ followers",[response valueForKey:@"followers"]];
        lbl_prostroy.text=[NSString stringWithFormat:@"%@ stories",[response valueForKey:@"stories"]];
        lbl_proname.text=[NSString stringWithFormat:@"%@ %@",[response valueForKey:@"firstName"],[response valueForKey:@"lastName"]];
    
        NSURL *URL=[NSURL URLWithString:[response valueForKey:@"profilePicUrl"]];
        
        //[img_banner setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"default_img.png"]];
        
        if (URL != nil ) {
          //  img_banner.image = nil;
            img_banner.imageURL = URL;
        }
     
        
        NSString *privacy=[NSString stringWithFormat:@"%@",[response valueForKey:@"privacy"]];
        
        if(userType == 1)
        {
            if([privacy isEqualToString:@"0"])
            {
                [btn_follows setTitle: @"anyone" forState: UIControlStateNormal];
            }else if([privacy isEqualToString:@"1"]){
                
                [btn_follows setTitle: @"follow" forState: UIControlStateNormal];
            }else{
                
                [btn_follows setTitle: @"only me" forState: UIControlStateNormal];
            }

            [btn_follows setImage:[UIImage imageNamed:@"lock_icon.png"] forState:UIControlStateNormal];
            
            btn_follows.hidden = false;

        }else{
            
            [btn_follows setTitle: @"+ follow" forState: UIControlStateNormal];
            [btn_follows setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        
        
        
        NSString *_karmaMeterValue = [response valueForKey:@"karma"];
        
        if([_karmaMeterValue intValue] > 0){
            
            img_banner_BG.image=[UIImage imageNamed:@"blue_user_image_default.png"];
            [lbl_karmavote setTextColor:[UIColor whiteColor]];
            
            img_banner_BG.transform = CGAffineTransformMakeRotation(-[_karmaMeterValue floatValue] * M_PI/180);

        }else if([_karmaMeterValue intValue] < 0){
            
            img_banner_BG.image=[UIImage imageNamed:@"pink_user_image_default.png"];
            [lbl_karmavote setTextColor:[UIColor whiteColor]];
            
            
            img_banner_BG.transform = CGAffineTransformMakeRotation(-[_karmaMeterValue floatValue] * M_PI/180);

        }else{
            
            img_banner_BG.image=[UIImage imageNamed:@"rad_blue_border_img.png"];
            [lbl_karmavote setTextColor:[UIColor blackColor]];
        }

        
        
    }];
    
}

#pragma mark - get_ProfileStory
#pragma mark -

-(void)get_ProfileStory{
    
    //[HUD show:YES];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    
    if([str_ProfileOwner intValue] == 0)
    {
        [dict setValue:str_UserId forKey:@"userId"];
        
    }else{
        
        [dict setValue:currentUserId forKey:@"userId"];
    }

    
    [dict setValue:@" " forKey:@"tagId"];
    [dict setValue:@" " forKey:@"storyId"];
    [dict setValue:@" " forKey:@"following"];
    [dict setValue:pageCount forKey:@"offset"];
    
    WebService *api = [[WebService alloc] init];
    
    [api call_API:dict andURL:GET_STORIES andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
        [HUD hide:YES];
        
        NSArray *arr_Response = response ;
       // arrayProfileStory = [response mutableCopy];
       
       // NSMutableArray  *tempArrayStory =[[NSMutableArray alloc]init];
        
        for (int i =0; i<[arr_Response count]; i++)
        {
            NSDictionary *dict=[arr_Response objectAtIndex:i];
            
            [arrayStory addObject: [arr_Response objectAtIndex:i]];

            [arrayTVData addObject:[self parsing_DataintoModelCalss:dict]];
        }
          [HUD hide:YES];
       // arrayStory = [tempArrayStory mutableCopy];
        
        isLoadingMore = false;
        tv_ProfileStory.tableFooterView = nil;

        [self.tv_ProfileStory reloadData];
        
    }];

    
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
    
    
    return obj;
}

#pragma mark - scrollViewDidEndDragging
#pragma mark -

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    

    if ([scrollView isEqual:tv_ProfileStory]) {
        
        NSInteger currentOffset = scrollView.contentOffset.y;
        NSInteger maximumOffset = scrollView.contentSize.height- scrollView.frame.size.height;
        if (maximumOffset - currentOffset <= 0 && arrayTVData.count>0) {
            
            if (isLoadingMore != true) {
                isLoadingMore = true;
                //index =index +1;
                NSInteger newPageCount = [pageCount intValue] + arrayTVData.count;
                pageCount =  [NSString stringWithFormat:@"%li",(long)newPageCount];
                [self setupTableViewFooter];

                [self get_ProfileStory];
                // Call your link here
            }
            
        }

    }
    
}


- (void)setupTableViewFooter
{
    // set up label
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, -22, self.view.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
    footerView.backgroundColor = [WebService colorWithHexString:@"F2F2F2"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:14];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textColor = [UIColor darkGrayColor];
    label.text = @"Loading";
    
    CGSize labelSize = [label sizeThatFits:footerView.frame.size];
   // [footerView addSubview:label];
    
    // set up activity indicator
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.hidesWhenStopped = YES;
    activityIndicatorView.color = [WebService colorWithHexString:@"d8d8d8"];
    
    [activityIndicatorView startAnimating];
    
   // [footerView addSubview:activityIndicatorView];
    
    CGRect footerFrame = footerView.frame;
    label.frame = CGRectMake((footerFrame.size.width-labelSize.width - 4 - activityIndicatorView.frame.size.width)/2, (footerFrame.size.height-labelSize.height)/2
                             , (footerFrame.size.width-labelSize.width - 4 - activityIndicatorView.frame.size.width), labelSize.height);
    activityIndicatorView.frame = CGRectMake(label.frame.origin.x + labelSize.width + 4, (footerFrame.size.height-activityIndicatorView.frame.size.height)/2
                                              , activityIndicatorView.frame.size.width, activityIndicatorView.frame.size.height);
    
    //[MBProgressHUD showHUDAddedTo:footerView animated:YES];
    MBProgressHUD  *hud = [[MBProgressHUD alloc] initWithView:footerView];
    HUD.square = YES;
    [hud show:YES];
    [footerView addSubview:hud];

    
    tv_ProfileStory.tableFooterView = footerView;
}

#pragma mark - check_isFollowing
#pragma mark -

-(void)check_isFollowing{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:str_UserId forKey:@"userId"];
    
    WebService *api = [[WebService alloc] init];
    
    [api call_API:dict andURL:IS_FOLLOWING andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
        NSString *status_follow=[response valueForKey:@"status"];

        if([status_follow intValue] == 0)
        {
            [btn_follows setTitle: @"+ follow" forState: UIControlStateNormal];
            [btn_follows setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }else{
            
            [btn_follows setTitle: @"- follow" forState: UIControlStateNormal];
            [btn_follows setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        
        btn_follows.hidden = false;

    }];
}


#pragma mark - toggle_Follower
#pragma mark -

-(void)toggle_Follower{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:str_UserId forKey:@"userId"];
    [dict setValue:@" " forKey:@"facebookId"];

    [HUD show:YES];

    WebService *api = [[WebService alloc] init];
    
    [api call_API:dict andURL:TOGGLE_FOLLOWER andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
        [HUD hide:YES];

        //NSString *status_follow = [response valueForKey:@"status"];

        if([btn_follows.titleLabel.text isEqualToString:@"+ follow"] )
        {
            [btn_follows setTitle: @"- follow" forState: UIControlStateNormal];
            [btn_follows setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }else{
            
            [btn_follows setTitle: @"+ follow" forState: UIControlStateNormal];
            [btn_follows setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
    }];
}


#pragma mark - get_ProfileFollowers
#pragma mark -

-(void)get_ProfileFollowers{
    
    arrayProfileFollowers = [[NSMutableArray alloc]init];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    int userType =[str_ProfileOwner intValue];
    
    if(userType == 0){
        [dict setValue:str_UserId forKey:@"userId"];
    }else{
        [dict setValue:currentUserId forKey:@"userId"];
    }
    
    [dict setValue:@"0" forKey:@"offset"];
    
   // [HUD show:YES];
    
    WebService *api = [[WebService alloc] init];
    
    [api call_API:dict andURL:GET_FOLLOWERS andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
        NSArray *arr_Response = response ;
       // arrayProfileFollowers = response ;
        
        for (int i = 0; i<[arr_Response count]; i++)
        {
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];

            dict=[arr_Response objectAtIndex:i];
            
            ModelClass *obj=[[ModelClass alloc] init];
            
            obj.sty_goodvotes=[NSString stringWithFormat:@"%@",[dict valueForKey:@"goodVotes"]];
            obj.sty_badvotes=[NSString stringWithFormat:@"%@",[dict valueForKey:@"badVotes"]];
            obj.sty_contentvotes=[NSString stringWithFormat:@"%@",[dict valueForKey:@"content"]];
            obj.sty_commentvotes=[NSString stringWithFormat:@"%@",[dict valueForKey:@"comments"]];
            obj.sty_storyid=[NSString stringWithFormat:@"%@",[dict valueForKey:@"storyId"]];
            
            NSDictionary *userByFollowerUserId =[dict objectForKey:@"userByFollowerUserId"];//userByFollowerUserId
            
            NSDictionary *userByFollowedUserId =[dict objectForKey:@"userByFollowedUserId"];//userByFollowedUserId
            
            NSDictionary *dictFollow = [[NSDictionary alloc] init];

            NSString *userId =[NSString stringWithFormat:@"%@",[userByFollowedUserId valueForKey:@"userId"]];
            
            if ([str_UserId intValue] != [userId intValue]) {
                
                dictFollow = userByFollowedUserId;
            }else {
                dictFollow = userByFollowerUserId;
            }
            
            obj.sub_user_firstName=[NSString stringWithFormat:@"%@",[dictFollow valueForKey:@"firstName"]];
            obj.sub_user_lastname=[NSString stringWithFormat:@"%@",[dictFollow valueForKey:@"lastName"]];
            obj.sub_user_profilePicUrl=[NSString stringWithFormat:@"%@",[dictFollow valueForKey:@"profilePicUrl"]];
            obj.sub_user_userId=[NSString stringWithFormat:@"%@",[dictFollow valueForKey:@"userId"]];
            obj.sub_user_karma=[NSString stringWithFormat:@"%@",[dictFollow valueForKey:@"karma"]];
            
            [arrayProfileFollowers addObject:obj];
        }
        
        //[HUD hide:YES];
        [collectionview reloadData];
        
    }];

 }


////Swipe class


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
        return [arrayTVData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoryTVCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:commentTVCellNibName owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    ModelClass *obj = [arrayTVData objectAtIndex:indexPath.row];
    
    cell.lbl_comment.text=[NSString stringWithFormat:@"%@ comments",obj.sty_commentvotes];
     //  cell.lbl_comment.textAlignment=toupper(0.5);
    
    cell.lbl_header.text= obj.sty_contentvotes;

    cell.lbl_notif_name.frame = [self get_TextFrame:cell.lbl_notif_name];

     NSString *confidential = obj.confidential;
    
   // NSLog(@"confidential : %@",confidential);

    if ([confidential intValue]== 0) {
        
        NSString *storyImageURL = obj.sty_picUrl ;

        NSString *encodedStoryImageURL = [storyImageURL stringByAddingPercentEscapesUsingEncoding:
                                NSUTF8StringEncoding];
        NSURL *URL = [NSURL URLWithString:encodedStoryImageURL];
        
       // [cell.img_user setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"default_img_story.png"]];
        
        NSString *rr=[NSString stringWithFormat:@"%@",obj.sty_picUrl];
        
        int lenh =(int)[rr length];
        int ind;
        
        if([rr isEqualToString:@""]){
            
            
        }else{
            
            ind =(lenh - 4);
            
            NSString *linkcheck =[rr substringFromIndex:ind];
            
            if([linkcheck isEqualToString:@".jpg"]||[linkcheck isEqualToString:@".png"]||[linkcheck isEqualToString:@"jpeg"]){
                cell.img_user.backgroundColor = [UIColor whiteColor];
                cell.img_user.layer.masksToBounds = YES;
                cell.img_user.imageURL = URL;
                
            }else{
                
               // NSString *youtubeID = [WebService extractYoutubeIdFromLink:rr];
               // NSString *stringVideoURL =[NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg",youtubeID];
               // NSURL *movieURL=[NSURL URLWithString:stringVideoURL];
               // [cell.img_user setImageWithURL:movieURL];
                
                NSURL *youtubeURL = [NSURL URLWithString:rr];
                
                NSURL *youtubeThumbnailURL = [MDYoutubeParser thumbnailUrlForYoutubeURL:youtubeURL thumbnailSize:YouTubeThumbnailDefaultHighQuality];
                cell.img_user.imageURL = youtubeThumbnailURL;

                //[cell.img_user setImage:[WebService getThumbnailForYoutubeURL:rr]];
            }

        }
    }else{
        
        [cell.img_user setImage:[UIImage imageNamed:@"confidential_icon.png"]];
    }
    cell.img_user.layer.masksToBounds = YES;

     NSString *str_KarmaMeterPercent = [self get_KarmaMeterPercent_byGoodVotes:[obj.sty_goodvotes intValue] andBadVotes:[obj.sty_badvotes intValue]];
    
    float ff =[str_KarmaMeterPercent floatValue];
    cell.progressView.progress = (ff/100);
    
    // cell.img_user.contentMode = UIViewContentModeScaleAspectFit;
    
        cell.btn_preport.tag = indexPath.row;
        cell.btn_report.tag = indexPath.row;
        cell.btn_delete.tag = indexPath.row;
        cell.btn_confid.tag = indexPath.row;
        cell.btn_creport.tag = indexPath.row;
    
    if ([swipedCellIndexed containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]] ) {
        
        [self set_LeftFrame:indexPath andTVCell:cell];

    }

       [cell.btn_delete addTarget:self action:@selector(action_Delete:) forControlEvents:UIControlEventTouchUpInside];
    
       [cell.btn_report addTarget:self action:@selector(action_Report:) forControlEvents:UIControlEventTouchUpInside];
       [cell.btn_preport addTarget:self action:@selector(action_Report:) forControlEvents:UIControlEventTouchUpInside];
       [cell.btn_creport addTarget:self action:@selector(action_Report:) forControlEvents:UIControlEventTouchUpInside];
    
       [cell.btn_confid addTarget:self action:@selector(action_Confidential:) forControlEvents:UIControlEventTouchUpInside];
    
       cell.swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
       [cell.swipeGestureLeft addTarget:self action:@selector(handleSwipeGestureLeft:)];
    
       cell.swipeGestureRight.direction = UISwipeGestureRecognizerDirectionRight;
    
      [cell.swipeGestureRight addTarget:self action:@selector(handleSwipeGestureRight:)];
    
      return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    /*
     
     Modelclass *obj = [arrayTVData objectAtIndex:indexPath.row];

    StoryViewController *s=[[StoryViewController alloc]initWithNibName:@"StoryViewController" bundle:nil];
    s.tag_userId=obj.sub_user_userId;
    NSLog(@"Test1=%@",s.tag_userId);
    s.tag_pics=obj.tagstory_picUrl;
    NSLog(@"Test1=%@",s.tag_pics);
    s.tag_findtag=@"1";
    s.tag_categoryname=obj.tagstory_name;
    NSLog(@"Test1=%@",s.tag_categoryname);
    s.getStoryURL = BASE_URL_STROYSHOW;
    s.getStoryByTagId = obj.tagstory_tagid;
    NSLog(@"Test1=%@",s.getStoryByTagId);
    s.currentsearch_demo= @"story_by_categoryID";
    
    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_ISVC.topViewController = s;
    [self.navigationController pushViewController:obj_ISVC animated:NO];
    */
    
    
    StoryTVCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    
    int percent = cell.progressView.progress*100;

    NSString *karmaMeterPercent = [NSString stringWithFormat:@"%i",percent];
    

    StoryCommentsVC *storyCommentsVC=[[StoryCommentsVC alloc]initWithNibName:@"StoryCommentsVC" bundle:nil];
    
    NSArray *currentIndexStory =[arrayStory objectAtIndex:indexPath.row];
    
    storyCommentsVC.arrayStory = currentIndexStory;
    storyCommentsVC.karmaMeterPercent = karmaMeterPercent;
    storyCommentsVC.str_UserId = str_UserId;
    [self.navigationController pushViewController:storyCommentsVC animated:NO];


}


-(CGRect)get_TextFrame:(UILabel *)label{
    
    CGFloat fixedWidth = label.frame.size.width;
    CGSize newSize = [label sizeThatFits:CGSizeMake(fixedWidth, 44)];
    CGRect newFrame = label.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    
    label.frame = newFrame;
    
    return newFrame;
}


-(void)handleSwipeGestureLeft:(UISwipeGestureRecognizer *)sender{
    
    
    StoryTVCell *cell = (StoryTVCell *)sender.view;
    
    NSIndexPath *indexPath = [tv_ProfileStory indexPathForCell:cell];
    
    if (![swipedCellIndexed containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]] ) {
        
        [swipedCellIndexed addObject:[NSString stringWithFormat:@"%i",(int)indexPath.row]];
        
        NSLog(@"handleSwipeGesture Left called");
        
        [UIView beginAnimations:@"SwipeLeft" context:nil];
        [UIView setAnimationDelay:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        [self set_LeftFrame:indexPath andTVCell:cell];
        
        [UIView commitAnimations];
        
    }
    
}
-(void)set_LeftFrame:(NSIndexPath *)indexPath andTVCell:(StoryTVCell *)cell{

//-(void)set_LeftFrame:(CommentTVCell *)cell{
    
   // NSIndexPath *indexPath = [tv_ProfileStory indexPathForCell:cell];
        
    ModelClass *obj = [arrayTVData objectAtIndex:indexPath.row];
    NSString *authorUserID = obj.cat_user_userId;
    NSString *subjectUserID = obj.sub_user_userId;
    
    if([currentUserId intValue] == [authorUserID intValue]&& [currentUserId intValue] == [subjectUserID intValue]){
        // status=1;
        cell.btn_preport.hidden = true;
        [cell.cell_View setFrame:CGRectMake(-(cell.btn_delete.frame.size.width*3),0,cell.cell_View.frame.size.width, cell.cell_View.frame.size.height)];
        cell.btn_creport.hidden = true;
        
    }else if([currentUserId intValue] == [authorUserID intValue]){
        cell.btn_preport.hidden = true;
        cell.btn_creport.hidden = false;
        [cell.cell_View setFrame:CGRectMake(-(cell.btn_delete.frame.size.width*2),0, cell.cell_View.frame.size.width, cell.cell_View.frame.size.height)];
    }else{
        
        cell.btn_preport.hidden = false;
        cell.btn_creport.hidden = true;
        [cell.cell_View setFrame:CGRectMake(-(cell.btn_delete.frame.size.width),0,cell.cell_View.frame.size.width, cell.cell_View.frame.size.height)];
    }
    
}




-(void)handleSwipeGestureRight:(UISwipeGestureRecognizer *)sender{
    
    StoryTVCell *cell = (StoryTVCell *)sender.view;
    
    NSLog(@"handleSwipeGesture Right called");
    
    
    NSIndexPath *indexPath = [tv_ProfileStory indexPathForCell:cell];
    
    if ([swipedCellIndexed containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]] ) {
        
        [swipedCellIndexed removeObject:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
        
        [UIView beginAnimations:@"SwipeRight" context:nil];
        [UIView setAnimationDelay:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [cell.cell_View setFrame:CGRectMake(0,0, cell.cell_View.frame.size.width, cell.cell_View.frame.size.height)];
        [UIView commitAnimations];
        
    }
    
}

#pragma mark - UITableView Cell Actions
#pragma mark -


// DELETE_STORY Methods

-(void)action_Delete:(UIButton *)sender{
    
    ModelClass *obj = [arrayTVData objectAtIndex:sender.tag];
    currentStoryid =obj.sty_storyid;
    
    currentStoryIndex = [NSString stringWithFormat:@"%li",(long)sender.tag];

    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"Are you sure you want to delete?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Yes",@"No", nil];
    actionSheet.tag = 200;
    
    [actionSheet showInView:self.view];
}


// Report_STORY Methods


-(void)action_Report:(UIButton *)sender{
    
    ModelClass *obj = [arrayTVData objectAtIndex:sender.tag];
    currentStoryid = obj.sty_storyid;
    currentStoryIndex = [NSString stringWithFormat:@"%li",(long)sender.tag];

    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"inappropriate content",@"feels like spam/scam",@"inaccurate content", nil];
    actionSheet.tag = 300;
    actionSheet.tintColor = [WebService colorWithHexString:@"14B9D6"];
    
    [[UIButton appearanceWhenContainedIn:[UIAlertController class], nil] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [[UICollectionView appearanceWhenContainedIn:[UIAlertController class], nil] setTintColor:[UIColor redColor]];

    [actionSheet showInView:self.view];
}

// UPDATE_STORY Methods

-(void)action_Confidential:(UIButton *)sender{
    
    currentStoryIndex = [NSString stringWithFormat:@"%li",(long)sender.tag];
    NSLog(@"sender tag : %li",(long)sender.tag);

    [HUD show:YES];

    ModelClass *obj = [arrayTVData objectAtIndex:sender.tag];
    NSString *storyId = obj.sty_storyid;
    NSString *storyConfidential = obj.confidential;

    NSMutableDictionary *dictParam = [[NSMutableDictionary alloc]init];
    [dictParam setValue:obj.tags_ids_story forKey:@"tags"];
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
            
            [arrayTVData replaceObjectAtIndex:[currentStoryIndex intValue] withObject:[self parsing_DataintoModelCalss:dict]];
            
            [arrayStory replaceObjectAtIndex:[currentStoryIndex intValue] withObject:response];
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
    
        [tv_ProfileStory reloadData];
        
    }];
}



#pragma mark - Get Karma Meter Percent Methods
#pragma mark -


-(NSString *)get_KarmaMeterPercent_byGoodVotes:(int)goodVotes andBadVotes:(int)badVotes{
    
    float totalVotes = goodVotes + badVotes;
    
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




#pragma mark - UIAlertView Delegate
#pragma mark -

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   

}

#pragma mark - Call Delete Story API
#pragma mark -

-(void)call_DeleteStoryorAPI{
    
    [HUD show:YES];
    
    WebService *api=[[WebService alloc] init];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setValue:currentStoryid forKey:@"storyId"];
    
    [api call_API:dict andURL:DELETE andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
        [HUD hide:YES];
        
        [swipedCellIndexed removeObject:currentStoryIndex];
        [arrayTVData removeObjectAtIndex:[currentStoryIndex intValue]];
        [tv_ProfileStory reloadData];
        
    }];
}


#pragma mark - Call Report Story API
#pragma mark -

-(void)call_ReportStoryAPI:(NSString *)reportFor{
    
    [HUD show:YES];
    
    WebService *api=[[WebService alloc] init];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setValue:currentStoryid forKey:@"storyId"];
    [dict setObject:reportFor forKey:@"status"];
    
    [api call_API:dict andURL:REPORT andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
        [HUD hide:YES];
        
        [swipedCellIndexed removeObject:currentStoryIndex];
        [arrayTVData removeObjectAtIndex:[currentStoryIndex intValue]];
        [tv_ProfileStory reloadData];

    }];
}


#pragma mark - MBProgressHUD Load
#pragma mark -

-(void)progressBar
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.tag = 444;
    //HUD.labelText = @"Loading...";
    //HUD.detailsLabelText = @"Pdf..";
    HUD.square = YES;
    [HUD show:YES];
    HUD.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

    [self.view addSubview:HUD];

}

#pragma mark - toggle follow / followup Methods
#pragma mark -

-(IBAction)followup:(UIButton *)sender{
    
    if ([sender.titleLabel.text isEqualToString:@"+ follow"]||[sender.titleLabel.text isEqualToString:@"- follow"]) {
        [self toggle_Follower];
    }else{
        
        UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"Who can post stories about me:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"anyone",@"people i follow",@"only me", nil];
        actionSheet.tag = 100;
        [actionSheet showInView:self.view];
    }
    
}




#pragma mark - UIActionSheet Delegate
#pragma mark -


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.tag==100) { // toggle follow / followup
        
        NSString *title_AB = [actionSheet buttonTitleAtIndex:buttonIndex];
        
        if([title_AB isEqual:@"anyone"])
        {
            [btn_follows setTitle: @"anyone" forState: UIControlStateNormal];
            
        }else if([title_AB isEqual:@"people i follow"]){
            
            btn_follows.titleLabel.font =[UIFont systemFontOfSize:11];
            [btn_follows setTitle: @"people I follow" forState: UIControlStateNormal];
            
        }else if([title_AB isEqual:@"only me"]){
            [btn_follows setTitle: @"only me" forState: UIControlStateNormal];
            
        }else{
            
            
        }
    }
    
    if (actionSheet.tag==200) { // Delete Story

        if (buttonIndex==0) {
            [self call_DeleteStoryorAPI];
        }else if (buttonIndex==1){
          //  [self call_DeleteStoryorAPI];
        }else{
            
        }
    }
    
    
    if (actionSheet.tag==300) { // Report Story
        
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


#pragma mark - ADD STORY Methods
#pragma mark -


-(IBAction)Func_story:(id)sender
{
    AddStoryViewController *addStory=[[AddStoryViewController alloc]initWithNibName:@"AddStoryViewController" bundle:nil];
    
    addStory.profile_mag=@"1";
    addStory.profile_name=[NSString stringWithFormat:@"%@",user_ProfileName];
    addStory.profile_image=[NSString stringWithFormat:@"%@",user_ProfilePics];
    addStory.prf_karma=[NSString stringWithFormat:@"%@",str_counter];
    addStory.str_ProfileOwner = self.str_ProfileOwner;
    addStory.str_UserId = self.str_UserId;
    
    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_ISVC.topViewController = addStory;
    [self.navigationController pushViewController:obj_ISVC animated:NO];
}

#pragma mark -  Show My Profile Methons
#pragma mark -


-(IBAction)action_ShowMyProfile:(UIButton *)sender
{
    
    sender.showsTouchWhenHighlighted = true;
    
   // Profile *pro = [[Profile alloc]initWithNibName:@"Profile" bundle:nil];
    str_ProfileOwner = @"1";
    
    str_UserId = currentUserId;
    
    [self call_AllAPI];

//    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
//    obj_ISVC.topViewController = pro;
//    
//    [self.navigationController pushViewController:obj_ISVC animated:NO];
}

#pragma mark - Search People Methods
#pragma mark -

-(IBAction)search_People:(id)sender{
    
    CategoryList *obj_HVC=[[CategoryList alloc]initWithNibName:@"CategoryList" bundle:nil];
    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_ISVC.topViewController = obj_HVC;
    [self.navigationController pushViewController:obj_ISVC animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
