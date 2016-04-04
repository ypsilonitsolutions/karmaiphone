 //
//  CategoryList.m
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 01/09/15.
//  Copyright (c) 2015 MaheshDhakad. All rights reserved.
//
#import "CategoryList.h"

@interface CategoryList ()
{
    IBOutlet UICollectionView *collectionview;
    
    NSMutableArray *arrayAllTags,*arraySearchResult;
    IBOutlet UIView *V_bg;
    IBOutlet UILabel *lbl_bg;
    int lastIndex;
    
    IBOutlet UIButton *btn_mentation;
    IBOutlet UIImageView *image_menu;
    
}
@end

@implementation CategoryList


@synthesize searchdisplaycontroller,txt_search,tv_Search;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"CategoryList";
            categoryCellNibName = @"CategoryListCell";

        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"CategoryList";
            categoryCellNibName = @"CategoryListCell";

        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"CategoryList_iPhone6";
            categoryCellNibName = @"CategoryListCell_iPhone6";

        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"CategoryList_iPhone6";
            
           categoryCellNibName = @"CategoryListCell_iPhone6";
        }
    }
    else
    {
         nibName=@"CategoryList_iPad";
        categoryCellNibName = @"CategoryListCell_iPad";

    }
    
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tv_Search setHidden:YES];
    
    btn_mentation.hidden=YES;
    
    V_bg.layer.cornerRadius = 6.0;
    V_bg.layer.masksToBounds = YES;
    V_bg.backgroundColor=[UIColor colorWithRed:0.71 green:0.725 blue:0.745 alpha:1];
    lbl_bg.layer.cornerRadius = 6.0;
    lbl_bg.layer.masksToBounds = YES;
    
    arraySearchResult=[[NSMutableArray alloc]init];
    
    currentUserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"LOGIN_USER_ID"];
    
    [collectionview registerNib:[UINib nibWithNibName:categoryCellNibName bundle:nil] forCellWithReuseIdentifier:@"CELL"];

    collectionview.backgroundColor=[UIColor clearColor];

    // Do any additional setup after loading the view from its nib.
    
    autocomplete = [[UITableView alloc] init];
    autocomplete.delegate = self;
    autocomplete.dataSource=self;
    autocomplete.scrollEnabled=YES;
    [self.view addSubview:autocomplete];
    
    [self progressBar];
    
    [self get_Tags];
    
    NSDictionary* dict= @{ @"animal_img.png" : @1  , @"food_img.png" : @1 };
    
    for (int i = 0; i < 2; i++) {
        
        ModelClass *obj=[[ModelClass alloc]init];
        obj.demo_img=[NSString stringWithFormat:@"%@",[dict valueForKey:@"1"]];
        [arrayAllTags addObject:obj];
    }
}

///slider menu
-(void)viewWillDisappear:(BOOL)animated{
    
}

-(void)viewWillLayoutSubviews{
    
    if(isMenuShow)
    {
        image_menu.image=[UIImage imageNamed:@"menu_icon.png"];
        isMenuShow = NO;
        [txt_search resignFirstResponder];
        
    }else{
        
        image_menu.image=[UIImage imageNamed:@"menu_icon.png"];
        isMenuShow = YES;
    }
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
    [txt_search resignFirstResponder];
    [self.slidingViewController anchorTopViewTo:MDRight];
}


#pragma mark - UICollectionView Delegates
#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [arrayAllTags count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        CGSize cellSize;
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            cellSize = CGSizeMake(154,154);
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            cellSize = CGSizeMake(154,154);
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            cellSize = CGSizeMake(182,182);
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            cellSize = CGSizeMake(201,201);
        }
        
        return cellSize;
        
    }
    else
        return CGSizeMake(250, 250);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
     if ([[UIScreen mainScreen] bounds].size.height==667){
         return 3.0;
    }else{
        return 4.0;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4.0;
}


- (CategoryListCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CategoryListCell *cell = [collectionview dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    ModelClass *obj=[arrayAllTags objectAtIndex:indexPath.row];
    
    if(indexPath.row == 0)
    {
        cell.imageview.image=[UIImage imageNamed:@"animal_img.png"];
        cell.cellLabel6.hidden=NO;
        cell.cellLabel11.hidden=YES;
        cell.cellLabel.hidden=YES;
        cell.cellLabel6.font = [UIFont fontWithName:@"Helvetica" size:14];
        cell.cellLabel6.text =@"People I Follow";
            
    }else if(indexPath.row == 1){
        
        cell.imageview.image=[UIImage imageNamed:@"food_img.png"];
        
        cell.cellLabel6.hidden=NO;
        cell.cellLabel11.hidden=YES;
        cell.cellLabel.hidden=YES;
        cell.cellLabel6.font = [UIFont fontWithName:@"Helvetica" size:14];
        cell.cellLabel6.text =@"Trending Stories";
        
    }else{

        cell.cellLabel6.hidden=YES;
    
        cell.imageview.tag = indexPath.row;
        NSURL *URL=[NSURL URLWithString:obj.Tag_picUrl];
    
        //[cell.imageview setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"default_img.png"]];
        //get image view
        MDImageView *imageView = (MDImageView *)[cell viewWithTag:indexPath.row];
        
        //cancel loading previous image for cell
        [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:imageView];

        imageView.imageURL = URL;
        
        cell.cellLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        cell.cellLabel.text =obj.Tag_name;
        NSString *a =[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        if([a isEqualToString:@"0"])
        {
            cell.cellLabel11.hidden=YES;
            cell.cellLabel.hidden=YES;
            cell.cellLabel6.hidden=YES;
            cell.cellLabel.backgroundColor = [UIColor clearColor];
            
        }else if([a isEqualToString:@"1"]){
            
            cell.cellLabel11.hidden=YES;
            cell.cellLabel.hidden=YES;
            cell.cellLabel.backgroundColor=[UIColor clearColor];
            
        }else if([a isEqualToString:@"9"]){
            
            cell.cellLabel11.hidden=NO;
            cell.cellLabel6.hidden =YES;
            cell.cellLabel11.text=@"";
            
            cell.cellLabel.hidden=NO;
            
        }else if([a isEqualToString:@"8"]){
            
            cell.cellLabel6.hidden =YES;
            cell.cellLabel11.hidden=NO;
            cell.cellLabel11.text=@"";
            
            cell.cellLabel.hidden=NO;
            
        }else{
            cell.cellLabel.hidden=NO;
            cell.cellLabel11.hidden=NO;
        }
    }
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    ModelClass *obj = [arrayAllTags objectAtIndex:indexPath.row];
    
    StoryViewController *s=[[StoryViewController alloc]initWithNibName:@"StoryViewController" bundle:nil];

    if(indexPath.row == 0)
    {
        
        s.tag_userId=obj.S_userid;
        s.tag_pics=obj.Tag_picUrl;
        s.tag_findtag=obj.Tag_tagId;
        s.tag_categoryname=obj.Tag_name;
        s.getStoryURL = GET_STORIES;
        s.currentsearch_demo= @"People_I_Follow";
        
    }else if (indexPath.row == 1){
        
        s.tag_userId=obj.S_userid;
        s.tag_pics=obj.Tag_picUrl;
        s.tag_findtag=obj.Tag_tagId;
        s.tag_categoryname=obj.Tag_name;
        s.getStoryURL = GET_TRENDING_STORIES;
        s.currentsearch_demo= @"get_trending";
        
    }else{
        
         s.tag_userId=obj.Tag_tagId;
         s.tag_pics=obj.Tag_picUrl;
         s.tag_findtag=@"1";
         s.tag_categoryname=obj.Tag_name;
         s.getStoryURL = GET_STORIES;
         s.getStoryByTagId = obj.Tag_tagId;
         s.currentsearch_demo= @"story_by_categoryID";
    }
    
    
    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_ISVC.topViewController = s;
    [self.navigationController pushViewController:obj_ISVC animated:NO];
    
}


#pragma mark - UITableView Delegates
#pragma mark -

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        
        if ([[UIScreen mainScreen] bounds].size.height <= 568)
        {
            return 83;

        }else{
            
            return 88;
        }
        
    }else{
                
        return 98;
    }
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arraySearchResult count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell.backgroundColor = [UIColor lightGrayColor];
    
    [cell.layer addSublayer:[WebService setBorderWithFrame:CGRectMake(0.0f, 0, cell.frame.size.width, 1.0f) andColor:[WebService colorWithHexString:@"d8d8d8"]]];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    SearchTVCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            if ([[UIScreen mainScreen] bounds].size.height==568)
            {
                NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"SearchTVCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            else if ([[UIScreen mainScreen] bounds].size.height==480)
            {
                NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"SearchTVCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];            }
            else if ([[UIScreen mainScreen] bounds].size.height==667)
            {
                NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"SearchTVCell_iPhone6" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            else if ([[UIScreen mainScreen] bounds].size.height==736)
            {
                NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"SearchTVCell_iPhone6" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
        }
        else
        {
            NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"SearchTVCell_iPad" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
  }
    
        ModelClass *obj=[arraySearchResult objectAtIndex:indexPath.row];
    
        cell.userimage_list.image=[UIImage imageNamed:obj.S_propics];
        NSURL *URL=[NSURL URLWithString:obj.S_propics];
        
        [cell.userimage_list setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"default_user_icon.png"]];
   
        if (URL != nil) {
           cell.userimage_list.imageURL = URL;
        }
    
    
        cell.userimage_list.contentMode = UIViewContentModeScaleAspectFill;
    
        [cell.btn_story setTag:indexPath.row];
        [cell.btn_story addTarget:self action:@selector(action_AddStory:) forControlEvents:UIControlEventTouchUpInside];
        cell.btn_story.backgroundColor=[UIColor colorWithRed:0.663 green:0.663 blue:0.659 alpha:1];
        
       // [NSString stringWithFormat:@"%@ followers",obj.sub_user_follow];
       // cell.lbl_story.text=[NSString stringWithFormat:@"%@ stories",obj.sub_user_stories]
        cell.followers.text=[NSString stringWithFormat:@"%@ followers",obj.S_follows];
        cell.stroy.text=[NSString stringWithFormat:@"%@ stories",obj.S_story];
        
        cell.lbl_karma.text =[NSString stringWithFormat:@"%@",obj.S_karma];
        
        NSString *lastname =obj.S_lname;
        NSString *firstname= obj.S_fname;
        NSString *fullName =[NSString stringWithFormat:@"%@ %@",firstname,lastname];
    
        cell.name.text = fullName ;
        
      //  S_lname
        
        NSString *strName = [NSString stringWithFormat:@"%@ %@",obj.S_fname,obj.S_lname];
        
        //Your entry string NSString *myString = @"I have to replace text 'Dr Andrew Murphy, John Smith' "; //Create mutable string from original one
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:strName];
        //Fing range of the string you want to change colour
        //If you need to change colour in more that one place just repeat it
        NSRange range = [strName rangeOfString:txt_search.text options:NSCaseInsensitiveSearch];
       
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.369 green:0.561 blue:0.871 alpha:1] range:range];
        //Add it to the label - notice its not text property but it's attributeText
        cell.name.attributedText = attString;
    
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
        cell.userInteractionEnabled = YES;
    
       [cell.btnShowProfile setTag:indexPath.row];
       [cell.btnShowProfile addTarget:self action:@selector(action_ShowProfile:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *karmaMeterValue = obj.S_karma;
    
    NSLog(@"karmaMeterValue : %@",karmaMeterValue);
    
    if([karmaMeterValue intValue] > 0){
        
        cell.bg_list.image=[UIImage imageNamed:@"blue_user_image_default.png"];
        [cell.lbl_karma setTextColor:[UIColor whiteColor]];
        
        cell.bg_list.transform = CGAffineTransformMakeRotation(-([karmaMeterValue floatValue]/4) * M_PI/180);

    }else if([karmaMeterValue intValue] < 0){
        
        cell.bg_list.image=[UIImage imageNamed:@"pink_user_image_default.png"];
        [cell.lbl_karma setTextColor:[UIColor whiteColor]];
        
        cell.bg_list.transform = CGAffineTransformMakeRotation(-([karmaMeterValue floatValue]/4) * M_PI/180);

        
    }else{
        cell.bg_list.image=[UIImage imageNamed:@"rad_blue_border_img.png"];
       [cell.lbl_karma setTextColor:[UIColor blackColor]];
        
    }
    cell.bg_list.image=[UIImage imageNamed:@"rad_blue_border_img.png"];

      return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   ModelClass *obj= [arraySearchResult objectAtIndex:indexPath.row];
    NSString *currentuserid = obj.S_userid;
    
    NSString *story=obj.S_story;
    
    if ([story isEqualToString:@"0"]) {
        StoryViewController *obj_HVC=[[StoryViewController alloc]initWithNibName:@"StoryViewController" bundle:nil];
        obj_HVC.getStoryByUserId = currentuserid;
        obj_HVC.currentsearch_userid = currentuserid;
        
        obj_HVC.currentsearch_demo= @"story_by_userID";
        obj_HVC.getStoryURL = GET_STORIES;
        
        InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        obj_ISVC.topViewController = obj_HVC;
        [self.navigationController pushViewController:obj_ISVC animated:NO];
    }else{
        
        
    StoryViewController *obj_HVC=[[StoryViewController alloc]initWithNibName:@"StoryViewController" bundle:nil];
    obj_HVC.getStoryByUserId = currentuserid;
    obj_HVC.currentsearch_userid = currentuserid;

    obj_HVC.currentsearch_demo= @"story_by_userID";
    obj_HVC.getStoryURL = GET_STORIES;

    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_ISVC.topViewController = obj_HVC;
        [self.navigationController pushViewController:obj_ISVC animated:NO];
    }
}


#pragma mark - action_ShowProfile Methons
#pragma mark -

-(void)action_ShowProfile:(UIButton*)sender{
    
    UIButton *abc=(UIButton *)sender;
    
    NSInteger i=abc.tag;
    
    ModelClass *obj=[arraySearchResult objectAtIndex:i];
    
    Profile *pro=[[Profile alloc]initWithNibName:@"Profile" bundle:nil];
    
    // Profile *pro=[[Profile alloc]init];
    NSString *str=[NSString stringWithFormat:@"%@",obj.S_userid];
    pro.str_UserId = str;
    pro.str_ProfileOwner = @"0";


    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_ISVC.topViewController = pro;
    [self.navigationController pushViewController:obj_ISVC animated:NO];
    
}

#pragma mark - action_AddStory Methons
#pragma mark -

-(void)action_AddStory:(UIButton*)sender{
    
    UIButton *abc=(UIButton *)sender;
    
    NSInteger i=abc.tag;
    
    ModelClass *obj=[arraySearchResult objectAtIndex:i];
    AddStoryViewController *addStory=[[AddStoryViewController alloc]initWithNibName:@"AddStoryViewController" bundle:nil];
      addStory.profile_mag=@"1";
    
      NSString *n=obj.S_fname;
      NSString *l=obj.S_lname;
    
      addStory.profile_name=[NSString stringWithFormat:@"%@ %@",n,l];
      addStory.profile_image=obj.S_propics;
      addStory.prf_karma=obj.S_karma;
    
    
    NSString *strUserid=obj.S_userid;
    
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

#pragma mark - get_Tags Methons
#pragma mark -

-(void)get_Tags{
   
    arrayAllTags=[[NSMutableArray alloc]init];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    WebService *api=[[WebService alloc] init];
    
    [api call_API:dict andURL:GET_TAGS andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {
        
        NSArray *arrTags = response;
        
        for (int i =0; i<[arrTags count]; i++) {
            
            NSDictionary *dict = [arrTags objectAtIndex:i];
            ModelClass *obj = [[ModelClass alloc]init];
            
            obj.Tag_name = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
            obj.Tag_order = [NSString stringWithFormat:@"%@",[dict valueForKey:@"order"]];
            obj.Tag_picUrl = [NSString stringWithFormat:@"%@",[dict valueForKey:@"picUrl"]];
            obj.Tag_tagId = [NSString stringWithFormat:@"%@",[dict valueForKey:@"tagId"]];
            
            [arrayAllTags addObject:obj];
        }
        
         [HUD hide:YES];
        
        [collectionview reloadData];
        
    }];
}

#pragma mark - Other Actions Methons
#pragma mark -

-(IBAction)searching:(id)sender{
   
    NSString * ss = self.txt_search.text;
    searchstring= self.txt_search.text;
    if([ss isEqualToString:@""]){
        
       [self.tv_Search setHidden:YES];

    }
    else{
        
        [self.tv_Search setHidden:NO];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        arraySearchResult =[[NSMutableArray alloc]init];
        [dict setValue:ss forKey:@"keyword"];
        [dict setValue:@"0" forKey:@"offset"];
        WebService *api=[[WebService alloc] init];
        // [obj callWebservice:dict : self :BASE_URL_TAG :@"tag"];
        
        [api call_API:dict andURL:SEARCH_PEOPLE andVC:self OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {
            
            arraySearchResult=[[NSMutableArray alloc]init];
            
            if([status isEqualToString:@"failure"])
            {
                
                [self.tv_Search setHidden:YES];
                NSString *msg=[response objectForKey:@"msg"];
                _AlertView_WithOut_Delegate(@"",msg , @"Ok", nil);
                return;
                
            }else{
            
                
            NSArray *Arr_Searchlist = response;
            
            for (int i =0; i<[Arr_Searchlist count]; i++) {
                
                NSDictionary *dict=[Arr_Searchlist objectAtIndex:i];
                ModelClass *obj=[[ModelClass alloc]init];
                
                obj.S_email=[NSString stringWithFormat:@"%@",[dict valueForKey:@"email"]];
                obj.S_fname=[NSString stringWithFormat:@"%@",[dict valueForKey:@"firstName"]];
                obj.S_follows=[NSString stringWithFormat:@"%@",[dict valueForKey:@"followers"]];
                obj.S_karma=[NSString stringWithFormat:@"%@",[dict valueForKey:@"karma"]];
                
                obj.S_lname=[NSString stringWithFormat:@"%@",[dict valueForKey:@"lastName"]];
                obj.S_privacy=[NSString stringWithFormat:@"%@",[dict valueForKey:@"privacy"]];
                obj.S_propics=[NSString stringWithFormat:@"%@",[dict valueForKey:@"profilePicUrl"]];
                obj.S_story=[NSString stringWithFormat:@"%@",[dict valueForKey:@"stories"]];
                obj.S_userid=[NSString stringWithFormat:@"%@",[dict valueForKey:@"userId"]];
                
                [arraySearchResult addObject:obj];
            }
            
            [tv_Search reloadData];
        }
         
        }];
        

    }
   }

-(IBAction)Cancel:(id)sender{
      self.txt_search.text=@"";
     [self.tv_Search setHidden:YES];
     [txt_search resignFirstResponder];
}
-(IBAction)hidekey:(id)sender{
    [txt_search resignFirstResponder];
}


-(void)progressBar
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.tag = 444;
    HUD.square = YES;
    [HUD show:YES];
    HUD.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;

    [self.view addSubview:HUD];
    //HUD.labelText = @"Loading...";
}


-(IBAction)action_ShowMyProfile:(UIButton *)sender
{
    sender.showsTouchWhenHighlighted = true;

     Profile *pro=[[Profile alloc]initWithNibName:@"Profile" bundle:nil];
    pro.str_ProfileOwner = @"1";
    
    pro.str_UserId = currentUserId;
    
    InitialSlidingViewController *obj_ISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    obj_ISVC.topViewController = pro;
    [self.navigationController pushViewController:obj_ISVC animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

