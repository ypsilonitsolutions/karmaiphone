//
//  AddStoryViewController.m
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 05/07/15.
//  Copyright (c) 2012 MKD. All rights reserved.
//

#import "AddStoryViewController.h"



@interface AddStoryViewController ()
{
   

}

@end

@implementation AddStoryViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"AddStoryViewController";
            storyTagCellNibName = @"StoryTagCell";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"AddStoryViewController";
            storyTagCellNibName = @"StoryTagCell";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"AddStoryViewController_iPhone6";
            storyTagCellNibName = @"StoryTagCell_iPhone6";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"AddStoryViewController_iPhone6Plus";
            storyTagCellNibName = @"StoryTagCell_iPhone6Plus";
        }
    }
    else
    {
        nibName=@"AddStoryViewController_iPad";
        storyTagCellNibName = @"StoryTagCell_iPad";
    }
    
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self progressBar];
   // [[IQKeyboardManager sharedManager] setEnable:NO];
    [self load_CustomActionSheet];
    currentUserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"LOGIN_USER_ID"];
    
    [self setUp_StorySubjectUserProfileInfo];
    
    view_teatarea.layer.cornerRadius = 3;
    view_teatarea.layer.masksToBounds = YES;
    txt_view.layer.cornerRadius = 3;
    txt_view.layer.masksToBounds = YES;
    txt_view.font = [UIFont fontWithName:@"Helvetica" size:14];
    txt_view.text = @"Write a story";
    txt_view.textColor = [UIColor lightGrayColor];
    txt_view.delegate = self;

    [collectionview registerNib:[UINib nibWithNibName:storyTagCellNibName bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    
    collectionview.backgroundColor=[UIColor clearColor];
    
    [self get_AddStoryTagList];

}

-(void)viewDidAppear:(BOOL)animated{
    
    
}

-(void)progressBar
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.tag = 444;
    [self.view addSubview:HUD];
    //HUD.labelText = @"Loading...";
    //HUD.detailsLabelText = @"Pdf..";
    HUD.square = YES;
    [HUD show:YES];
    
}

-(void)setUp_StorySubjectUserProfileInfo{
    
    checkimage.hidden=YES;
    img_userdef.hidden=YES;
    
    btn_Addstory.backgroundColor=[UIColor colorWithRed:0.663 green:0.663 blue:0.659 alpha:1];
    btn_Addstory.layer.cornerRadius = 3;
    btn_Addstory.layer.masksToBounds = YES;
    
    img_userimage.layer.cornerRadius = img_userimage.frame.size.width / 2;
    img_userimage.layer.masksToBounds = YES;
    
    // Do any additional setup after loading the view from its nib.
    
    int userType =[_str_ProfileOwner intValue];
    
    if(userType == 0)
    {
        btn_HideIdentity.hidden = true;
        collectionview.frame = CGRectMake(collectionview.frame.origin.x,collectionview.frame.origin.y-btn_HideIdentity.frame.size.height,collectionview.frame.size.width,collectionview.frame.size.height+btn_HideIdentity.frame.size.height);
    }else{
        
        [btn_HideIdentity setTitle: @"Hide Identity" forState: UIControlStateNormal];
        
        [btn_HideIdentity setBackgroundImage:[UIImage imageNamed:@"red_border_box.png"] forState:UIControlStateNormal];
        [btn_HideIdentity setTitleColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
    }
    
    confidential = @"0";
    
    NSString *a = self.profile_mag;
    
    if([a isEqualToString:@"1"]){
        
        lbl_name.text=self.profile_name;
        
        NSURL *URL=[NSURL URLWithString:self.profile_image];
       // [img_userimage setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"default_img_story.png"]];
        
        img_userimage.imageURL = URL;

        NSString *karmaMeterValue =self.prf_karma;
        if([karmaMeterValue intValue] > 0){
            img_userbg.image=[UIImage imageNamed:@"blue_user_image_default.png"];
            [lbl_counter setTextColor:[UIColor whiteColor]];
            lbl_counter.text=[NSString stringWithFormat:@"%@",karmaMeterValue];
            
            img_userbg.transform = CGAffineTransformMakeRotation(-[karmaMeterValue floatValue] * M_PI/180);

        }else if([karmaMeterValue intValue] < 0){
            
            img_userbg.image=[UIImage imageNamed:@"pink_user_image_default.png"];
            [lbl_counter setTextColor:[UIColor whiteColor]];
            lbl_counter.text=[NSString stringWithFormat:@"%@",karmaMeterValue];
            
            img_userbg.transform = CGAffineTransformMakeRotation(-[karmaMeterValue floatValue] * M_PI/180);
        }else{
            
            img_userbg.image=[UIImage imageNamed:@"rad_blue_border_img.png"];
            [lbl_counter setTextColor:[UIColor blackColor]];
            }
        
    }else{
        
        NSUserDefaults *VIP =[NSUserDefaults standardUserDefaults];
        
        NSString *current_name = [VIP valueForKey:@"current_fname"];
        NSString *current_lname =[VIP valueForKey:@"current_lname"];
        
        NSString *current_userpic =[VIP valueForKey:@"current_profilePicUrl"];
        lbl_name.text=[NSString stringWithFormat:@"%@ %@",current_name,current_lname];
        NSURL *URL=[NSURL URLWithString:current_userpic];
       // [img_userimage setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"profile_pic.png"]];
        img_userimage.imageURL = URL;

        NSString *current_karam=[VIP valueForKey:@"current_karma"];
        if([current_karam intValue] > 0){
            
            img_userbg.image=[UIImage imageNamed:@"blue_user_image_default.png"];
            [lbl_counter setTextColor:[UIColor whiteColor]];
            lbl_counter.text=[NSString stringWithFormat:@"%@",current_karam];
            
            img_userbg.transform = CGAffineTransformMakeRotation(-[current_karam floatValue] * M_PI/180);

        }else if([current_karam intValue] < 0){
            
            img_userbg.image=[UIImage imageNamed:@"pink_user_image_default.png"];
            [lbl_counter setTextColor:[UIColor whiteColor]];
            lbl_counter.text=[NSString stringWithFormat:@"%@",current_karam];
            
            img_userbg.transform = CGAffineTransformMakeRotation(-[current_karam floatValue] * M_PI/180);

        }else{
            
            img_userbg.image=[UIImage imageNamed:@"rad_blue_border_img.png"];
            [lbl_counter setTextColor:[UIColor blackColor]];
            lbl_counter.text=[NSString stringWithFormat:@"%@",current_karam];
        }
        
    }
    
    
    
}

#pragma mark - get_AddStoryTagList Methods
#pragma mark -

-(void)get_AddStoryTagList{
    
    [HUD show:YES];
    
    arraySelectedTags = [[NSMutableArray alloc]init];
    array_Tags = [[NSMutableArray alloc]init];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    WebService *api = [[WebService alloc] init];
    
    [api call_API:dict andURL:GET_TAGS andVC:self  OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
        [HUD hide:YES];

        NSArray *arr_Response = response ;
        
        for (int i =0; i<[arr_Response count]; i++) {
            
            NSDictionary *dict=[arr_Response objectAtIndex:i];
            ModelClass *obj=[[ModelClass alloc]init];
            obj.Tag_tagIdlist=[NSString stringWithFormat:@"%@",[dict valueForKey:@"tagId"]];
            
            obj.Tag_picUrllist=[NSString stringWithFormat:@"%@",[dict valueForKey:@"picUrl"]];
            obj.Tag_namelist=[NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
            
            [array_Tags addObject:obj];
            [arraySelectedTags addObject:@"-1"];
        }

        [collectionview reloadData];

    
    }];
    
}

#pragma mark - add_NewStory Methods
#pragma mark -


-(IBAction)action_AddStory:(id)sender{
    
    [txt_view resignFirstResponder];
    
    NSMutableString *strLL1 =[[NSMutableString alloc] init];
    
    for (int i = 0;i < arraySelectedTags.count ; i++) {
        
        NSString *arr = [arraySelectedTags objectAtIndex:i];
        
        if([arr isEqualToString:@"-1"])
        {
            
        }else{
            
            NSString *strTempLL = [NSString stringWithFormat:@"%@,",arr];
            [strLL1 appendString:[NSString stringWithFormat:@"%@",strTempLL]];
        }
    }
    
    NSString *stringTag;
    
    if (strLL1.length > 0) {
        
        stringTag = [strLL1 substringToIndex:[strLL1 length]-1];
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    nsud = [NSUserDefaults standardUserDefaults];
    
    NSString *current_userid = [nsud valueForKey:@"LOGIN_USER_ID"];

    if([_str_UserId intValue] != [current_userid intValue])
    {
        [dict setObject:_str_UserId forKey:@"userBySubjectUserId.userId"];
        confidential = @"0";
    }else{
        
        [dict setObject:current_userid forKey:@"userBySubjectUserId.userId"];
    }
    
    [dict setValue:stringTag forKey:@"tags"];
    [dict setObject:confidential forKey:@"confidential"];
    [dict setObject:txt_view.text forKey:@"content"];
    
    
    NSString *st = youTubeURL;
    
    if ([st isEqualToString:@""]||[st length]==0) {
        
        [dict setObject:@"" forKey:@"picUrl"];
        
    }else{
        
        [dict setObject:youTubeURL forKey:@"picUrl"];
        
    }
    
    if([strLL1 isEqualToString:@""])
    {
        [HUD hide:YES];
        _AlertView_WithOut_Delegate(@"",@"Please select the category",@"Ok", nil);
        return;
        
    }else if([txt_view.text isEqualToString:@"Write a story"]){
        
        [HUD hide:YES];
        _AlertView_WithOut_Delegate(@"",@"Please enter a story",@"Ok", nil);
        return;
        
    }else{
        
        // call Webservice Add New Story
        [self add_NewStory:dict];
    }
    
}


-(void)add_NewStory:(NSMutableDictionary *)dictionary{
    
    [HUD show:YES];
    
    WebService *api = [[WebService alloc] init];
    
    [api call_API:dictionary andURL:ADD_STORY andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *Status){
        
        NSArray *arr_Response = response ;
        
        NSString *status=[arr_Response valueForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            NSString *ss;
           // NSString *status=[arr_Response valueForKey:@"status"];
            NSArray *msg=[arr_Response valueForKey:@"errors"];
            
            [HUD hide:YES];

            for(int i =0;i<[msg count];i++){
                
                ss =[msg valueForKey:@"title"];
            }
            if([ss isKindOfClass:[NSNull class]])
            {
             _AlertView_WithOut_Delegate(@"",@"Error",@"Ok", nil);
                return;
            }else{
                _AlertView_WithOut_Delegate(@"",ss,@"Ok", nil);
                return;
            }

        }else{
            
            
            for (int i =0; i<[arr_Response count]; i++)
            {
                ModelClass *obj=[[ModelClass alloc]init];
                NSArray *userBySubjectUserId =[arr_Response valueForKey:@"userBySubjectUserId"];
                obj.sub_user_userId=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"userId"]];
            }
            
            txt_view.text=@" ";
            
            imgView_Profile.image=[UIImage imageNamed:@""];
            storyId = [NSString stringWithFormat:@"%@",[arr_Response valueForKey:@"storyId"]];
            [collectionview reloadData];
            
            for (int i = 0;i < arraySelectedTags.count ; i++) {
                
                [arraySelectedTags replaceObjectAtIndex:i withObject:@"-1"];
            }
            
            if (isMediaType == 1)
            {
                [self upload_StoryPicture];
                
            }else{
                
               // [HUD hide:YES];
                
                [self performSelector:@selector(goes_ToStoryDetails:) withObject:arr_Response afterDelay:1 ];
            }
 
        }

    }];
    
}


-(void)goes_ToStoryDetails:(NSArray *)createdStory{
    
    [HUD hide:YES];
    
    NSString *goodVotes = [NSString stringWithFormat:@"%@",[createdStory valueForKey:@"goodVotes"]];
    NSString *badVotes = [NSString stringWithFormat:@"%@",[createdStory valueForKey:@"badVotes"]];
    
    NSString *str_KarmaMeterPercent = [self get_KarmaMeterPercent_byGoodVotes:[goodVotes intValue] andBadVotes:[badVotes intValue]];
    
    float percent =[str_KarmaMeterPercent floatValue];

    NSString *karmaMeterPercent = [NSString stringWithFormat:@"%f",percent];
    
    StoryCommentsVC *storyCommentsVC=[[StoryCommentsVC alloc]initWithNibName:@"StoryCommentsVC" bundle:nil];
    
    storyCommentsVC.arrayStory = createdStory;
    storyCommentsVC.karmaMeterPercent = karmaMeterPercent;
    storyCommentsVC.str_UserId = _str_UserId;
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


-(void)upload_StoryPicture{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:storyId forKey:@"storyId"];
    
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",ADD_STORY_IMAGE]];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:nil parameters:dict constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        
       NSData *storyImageData = UIImageJPEGRepresentation(pickImage,0);
        
        [formData appendPartWithFileData:storyImageData name:@"file" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
    }];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError *error = nil;
        
        //[HUD hide:YES];

        NSArray  *res = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        
        if (error) {
            
            NSLog(@"Error serializing %@", error);
        }
        
        if ([[res valueForKey:@"status"]isEqualToString:SUCCESS_RESPONSE])
        {
            NSArray *arr_Response = res ;
            
            for (int i =0; i<[arr_Response count]; i++)
            {
                ModelClass *obj=[[ModelClass alloc]init];
                NSArray *userBySubjectUserId =[arr_Response valueForKey:@"userBySubjectUserId"];
                obj.sub_user_userId=[NSString stringWithFormat:@"%@",[userBySubjectUserId valueForKey:@"userId"]];
            }
            txt_view.text=@" ";
            image_camera.hidden = NO;

            imgView_Profile.image=[UIImage imageNamed:@""];
            storyId = [NSString stringWithFormat:@"%@",[arr_Response valueForKey:@"storyId"]];
            [collectionview reloadData];
            
            //[self goes_ToStoryDetails:arr_Response];
            

            [self performSelector:@selector(goes_ToStoryDetails:) withObject:arr_Response afterDelay:1 ];

            }
        else{
            
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }
     ];
    [operation start];
}

#pragma mark - Story Media Add Methods
#pragma mark -

-(IBAction)action_ProfileImageAdd:(id)sender
{
    [txt_view resignFirstResponder];

    [self presentView];
    
    /*
    tapbtn=1;
    UIActionSheet *ActionSheet=[[UIActionSheet alloc]initWithTitle:@"Add photo or video from:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"camera",@"library",@"YouTube", nil];
    
    UITextField  *txtReminderTitle= [[UITextField alloc] initWithFrame:CGRectMake(20.0, 180, 280.0, 40.0)];
    [txtReminderTitle setTag:99];
    [txtReminderTitle setBackgroundColor:[UIColor whiteColor]];
    [txtReminderTitle setFont:[UIFont boldSystemFontOfSize:17]];
    [txtReminderTitle setBorderStyle:UITextBorderStyleNone];
    [txtReminderTitle setTextAlignment:NSTextAlignmentCenter];
    txtReminderTitle.borderStyle = UITextBorderStyleRoundedRect;
    txtReminderTitle.keyboardType = UIKeyboardTypeDefault;
    txtReminderTitle.returnKeyType = UIReturnKeyDone;
    txtReminderTitle.delegate = self;
    txtReminderTitle.placeholder = @"Enter youtube url here...";
    //[ActionSheet addSubview:txtReminderTitle];
    
    [ActionSheet insertSubview:txtReminderTitle atIndex:3];

    [ActionSheet showInView:self.view];
    */
}



#pragma mark - Custom Action Sheet lifecycle
#pragma mark -

- (void)load_CustomActionSheet {
    
    self.uiasView = [[CustomUIASView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.uiasView.hidden = true;
    [self.uiasView.btn_Dismiss addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];

    [self.uiasView.btn_Camera addTarget:self action:@selector(action_Camera) forControlEvents:UIControlEventTouchUpInside];
    [self.uiasView.btn_Library addTarget:self action:@selector(action_Library) forControlEvents:UIControlEventTouchUpInside];
    [self.uiasView.btn_YouTube addTarget:self action:@selector(action_YouTube) forControlEvents:UIControlEventTouchUpInside];

    [self.uiasView.btn_Cancel addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.uiasView.btn_Submit addTarget:self action:@selector(action_submit) forControlEvents:UIControlEventTouchUpInside];
    self.uiasView.tf_VideoLink.delegate = self;

    [self.uiasView.btn_CancelBig addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    
    _uiasView.view_Contains.frame = CGRectMake(self.uiasView.view_Contains.frame.origin.x, (self.uiasView.frame.size.height+100), self.uiasView.view_Contains.frame.size.width, self.uiasView.view_Contains.frame.size.height);
    
    self.uiasView.hidden =true;
    
    [self.view addSubview:self.uiasView];
   // [self dismissView];

}

#pragma mark - Custom Action Sheet Methods
#pragma mark -

- (void)presentView {
    
    self.uiasView.hidden = false;
    self.uiasView.btn_Dismiss.hidden = false;

    [UIView animateWithDuration:0.50f animations:^{
        
        CGRect uiasViewFrame   = self.uiasView.view_Contains.frame;
        uiasViewFrame.origin.y = (self.uiasView.frame.size.height - self.uiasView.view_Contains.frame.size.height-20);
        
        self.uiasView.view_Contains.frame = uiasViewFrame;
        
    } completion:^(BOOL finished) {
        
       // self.uiasView.btn_Dismiss.hidden = false;

    }];
    

}

- (void)dismissView {
    
    self.uiasView.btn_Dismiss.hidden = true;

    [self.uiasView.tf_VideoLink resignFirstResponder];
    
    [UIView animateWithDuration:0.50f animations:^{
        
        CGRect uiasViewFrame   = self.uiasView.view_Contains.frame;
        uiasViewFrame.origin.y = (self.uiasView.frame.size.height +100);
        
        self.uiasView.view_Contains.frame = uiasViewFrame;
        
    } completion:^(BOOL finished) {
             
        self.uiasView.hidden = true;
        
        if (self.uiasView.btn_YouTube.userInteractionEnabled==false) {
            
                CGRect uiasViewFrame   = self.uiasView.view_Contains.frame;
                uiasViewFrame.origin.y = (self.uiasView.view_Contains.frame.origin.y);
                uiasViewFrame.size.height = uiasViewFrame.size.height-47;
               self.uiasView.view_SubContains.frame = CGRectMake(self.uiasView.view_SubContains.frame.origin.x,self.uiasView.view_SubContains.frame.origin.y,self.uiasView.view_SubContains.frame.size.width, self.uiasView.view_SubContains.frame.size.height-47);

                self.uiasView.view_Contains.frame = uiasViewFrame;
                
                self.uiasView.btn_YouTube.userInteractionEnabled = true;
            
                if (self.uiasView.tf_VideoLink.text.length == 0) {
                    
                  //  youTubeURL = @"";
                }
                self.uiasView.tf_VideoLink.text = @"";

                self.uiasView.btn_CancelBig.hidden=false;
                self.uiasView.btn_Cancel.hidden=true;
                self.uiasView.btn_Submit.hidden=true;
        }

    }];
    
}



- (void)action_Camera {
    
    //youTubeURL = @"";
    self.uiasView.tf_VideoLink.text = @"";
    NSLog(@"Camera");
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    }else{
        
        imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)action_Library {
   // youTubeURL = @"";
    self.uiasView.tf_VideoLink.text = @"";
    NSLog(@"action_Library");
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = (id)self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];

}

- (void)action_YouTube {
    
   // youTubeURL = @"";
    self.uiasView.tf_VideoLink.text = @"";

    NSLog(@"YouTube");// 45
    
    [UIView animateWithDuration:0.2f animations:^{
        
        CGRect uiasViewFrame   = self.uiasView.view_Contains.frame;
        uiasViewFrame.origin.y = (self.uiasView.view_Contains.frame.origin.y-47);
        uiasViewFrame.size.height = uiasViewFrame.size.height+47;
        
        self.uiasView.btn_YouTube.userInteractionEnabled = false;
        
       // self.uiasView.view_SubContains.frame = CGRectMake(self.uiasView.view_SubContains.frame.origin.x,self.uiasView.view_SubContains.frame.origin.y,self.uiasView.view_SubContains.frame.size.width, self.uiasView.view_SubContains.frame.size.height+47);
        
        self.uiasView.view_Contains.frame = uiasViewFrame;

       // [_uiasView.view_SubContains setTranslatesAutoresizingMaskIntoConstraints:NO];

    } completion:^(BOOL finished) {
        
        self.uiasView.view_SubContains.frame = CGRectMake(self.uiasView.view_SubContains.frame.origin.x,self.uiasView.view_SubContains.frame.origin.y,self.uiasView.view_SubContains.frame.size.width, self.uiasView.view_SubContains.frame.size.height+47);

        self.uiasView.btn_Cancel.hidden=false;
        self.uiasView.btn_Submit.hidden=false;
        self.uiasView.btn_CancelBig.hidden=true;

    }];
    
}


- (void)action_submit {
    
    if (self.uiasView.tf_VideoLink.text.length>0) {
        
        youTubeURL = self.uiasView.tf_VideoLink.text;
        isMediaType = 0;
        
        NSString *youtubeID = [WebService extractYoutubeIdFromLink:youTubeURL];
        
        NSString *stringVideoURL =[NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg",youtubeID];
        NSURL *movieURL=[NSURL URLWithString:stringVideoURL];
        
        [imgView_Profile setImageWithURL:movieURL placeholderImage:[UIImage imageNamed:@"video.png"]];

        [self dismissView];
    }else{
        
        _AlertView_WithOut_Delegate(@"",@"Please enter YouTube link",@"Ok", nil);
    }

    NSLog(@"action_submit");
}


#pragma mark - UIImagePickerController Delegate
#pragma mark -

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    image_camera.hidden = YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    isMediaType = 1;
    UIImage *im=[info objectForKey:UIImagePickerControllerOriginalImage];
    pickImage = im;
  //  pickImage = [MDImageRotate scaleAndRotateImage:pickImage];
    
    pickImage = [UIImage fixOrientation:pickImage];

    imgView_Profile.image= pickImage;
    youTubeURL = @"";
    [self dismissView];

}

#pragma mark - All Action Methods
#pragma mark -

-(IBAction)back:(id)sender{
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)func_identy:(id)sender
{
    if([confidential intValue] == 0){
        
        lbl_counter.hidden=YES;
        lbl_name.text = @"Confidential";
        [btn_HideIdentity setTitle: @"Hide Identity" forState: UIControlStateNormal];
        [btn_HideIdentity setBackgroundImage:[UIImage imageNamed:@"red_box.png"] forState:UIControlStateNormal];
        checkimage.hidden=NO;
        [btn_HideIdentity setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        img_userbg.hidden=YES;
        img_userimage.hidden=YES;
        img_userdef.hidden=NO;
        confidential = @"1";
        
    }else{
        
        NSString *a=self.profile_mag;
        lbl_counter.hidden=NO;
        if([a isEqualToString:@"1"]){
          
            lbl_name.text=self.profile_name;
            
            img_userimage.image=[UIImage imageNamed:self.profile_image];
            NSURL *URL=[NSURL URLWithString:self.profile_image];
            //[img_userimage setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"profile_pic.png"]];
            img_userimage.imageURL = URL;
        }else{
            lbl_counter.hidden=NO;
            NSUserDefaults *VIP =[NSUserDefaults standardUserDefaults];
            
            NSString *current_name = [VIP valueForKey:@"current_fname"];
            
            NSString *current_userpic =[VIP valueForKey:@"current_profilePicUrl"];
            
            lbl_name.text = current_name;
            
            img_userimage.image=[UIImage imageNamed:current_userpic];
        }
        checkimage.hidden=YES;
        [btn_HideIdentity setTitle: @"Hide Identity" forState: UIControlStateNormal];
        
        [btn_HideIdentity setBackgroundImage:[UIImage imageNamed:@"red_border_box.png"] forState:UIControlStateNormal];
        [btn_HideIdentity setTitleColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
        img_userbg.hidden=NO;
        img_userimage.hidden=NO;
        img_userdef.hidden=YES;
        confidential = @"0";
    }
    
}



-(IBAction)func_ClearText:(id)sender{

    txt_view.text = @"";
}






#pragma mark - UICollectionView Delegate
#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [array_Tags count];
}

- (StoryTagCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    StoryTagCell *cell = [collectionview dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    ModelClass *obj = [array_Tags objectAtIndex:indexPath.row];
    
    NSString *name =obj.Tag_namelist;
    
    [cell.btn_tagstory setTitle:[NSString stringWithFormat:@"%@",name] forState: UIControlStateNormal];
    
    [cell.btn_tagstory setTitleColor:[UIColor colorWithRed:0.392 green:0.784 blue:0.941 alpha:1] forState:UIControlStateNormal];
    
    [cell.btn_tagstory setTag:indexPath.row];
    
    [cell.btn_tagstory addTarget:self action:@selector(action_AddTag:) forControlEvents:UIControlEventTouchUpInside];
    
    if([[arraySelectedTags objectAtIndex:indexPath.row] isEqualToString:@"-1"])
    {
        [cell.btn_tagstory setBackgroundImage:[UIImage imageNamed:@"box_img@3x.png"] forState:UIControlStateNormal];
    }else{
        [cell.btn_tagstory setBackgroundImage:[UIImage imageNamed:@"blue_box_img@3x.png"] forState:UIControlStateNormal];

    }


    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark -  action_AddTag Methons
#pragma mark -

-(void)action_AddTag:(UIButton *)sender{
    
    ModelClass *obj = [array_Tags objectAtIndex:sender.tag];
    
    NSString *tagID = obj.Tag_tagIdlist;
    
    //NSString *tagName = obj.Tag_namelist;
    
    if ([[NSString stringWithFormat:@"%@",[arraySelectedTags objectAtIndex:sender.tag]] isEqualToString:@"-1"]){
        
        [arraySelectedTags replaceObjectAtIndex:sender.tag withObject:tagID];
        
        [sender setBackgroundImage:[UIImage imageNamed:@"blue_box_img@3x.png"] forState:UIControlStateNormal];
        
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }else{
        
        [arraySelectedTags replaceObjectAtIndex:sender.tag withObject:@"-1"];
        
        [sender setBackgroundImage:[UIImage imageNamed:@"box_img@3x.png"] forState:UIControlStateNormal];
        
        [sender setTitleColor:[UIColor colorWithRed:0.392 green:0.784 blue:0.941 alpha:1] forState:UIControlStateNormal];
    }
   // [collectionview reloadData];

    
}

#pragma mark -  Show My Profile Methons
#pragma mark -

-(IBAction)action_ShowMyProfile:(id)sender
{
    Profile *pro=[[Profile alloc]initWithNibName:@"Profile" bundle:nil];
    pro.str_ProfileOwner = @"1";
   
    pro.str_UserId = currentUserId;
    
    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_ISVC.topViewController = pro;
    [self.navigationController pushViewController:obj_ISVC animated:NO];
}



#pragma mark - UITextView Delegate
#pragma mark -

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [[IQKeyboardManager sharedManager] setEnable:NO];
   // /*
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
          view_textvalue.frame = CGRectMake(0, 187,320,127);
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            view_textvalue.frame = CGRectMake(0, 187,320, 127);
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
             view_textvalue.frame = CGRectMake(0,230,375, 138);
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
           
        }
    }
    else
    {
        view_textvalue.frame = CGRectMake(0,510,768, 200);
    }
    
    [_scrollView  setContentSize:CGSizeMake(0, _scrollView.frame.size.height+(_scrollView.frame.size.height/1.5))];
    //*/
    if ([txt_view.text isEqualToString:@"Write a story"]) {
        txt_view.text = @"";
        txt_view.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [_scrollView  setContentSize:CGSizeMake(0, 0)];

   // /*
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            view_textvalue.frame = CGRectMake(0,441,320, 127);        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            view_textvalue.frame = CGRectMake(0,441,320, 127);
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            view_textvalue.frame = CGRectMake(0,529,375, 138);
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            
        }
    }
    else
    {
        view_textvalue.frame = CGRectMake(0,794,768, 200);
    }
    //*/
    if ([txt_view.text isEqualToString:@""])
    {
        txt_view.text = @"Write a story";
        txt_view.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
