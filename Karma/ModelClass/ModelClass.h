//
//  ModelClass.h
//  Karma
//
//  Created by Mahesh Kumar Dhakad on 14/07/15.
//  Copyright (c) 2015 Mahesh Kumar Dhakad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelClass : NSObject



@property(strong,nonatomic) NSString *N_privacy;
@property(strong,nonatomic) NSString *N_email;
@property(strong,nonatomic) NSString *N_follows;
@property(strong,nonatomic) NSString *N_fname;
@property(strong,nonatomic) NSString *N_lname;
@property(strong,nonatomic) NSString *N_karma;
@property(strong,nonatomic) NSString *N_propics;
@property(strong,nonatomic) NSString *N_story;
@property(strong,nonatomic) NSString *N_userid;
@property(strong,nonatomic) NSString *N_content;
@property(strong,nonatomic) NSString *N_create;

@property(strong,nonatomic) NSString *com_content;
@property(strong,nonatomic) NSString *com_create;

@property(strong,nonatomic) NSString *N_noti;


@property(strong,nonatomic) NSString *createdate;
@property(strong,nonatomic) NSString *countid;

@property(strong,nonatomic) NSString *sty_goodbadvotes;
@property(strong,nonatomic) NSString *story_describe;
@property(strong,nonatomic) NSString *Tag_namelist;
@property(strong,nonatomic) NSString *Tag_tagIdlist;
@property(strong,nonatomic) NSString *Tag_picUrllist;


@property(strong,nonatomic) NSString *Tag_name;
@property(strong,nonatomic) NSString *Tag_order;
@property(strong,nonatomic) NSString *Tag_picUrl;
@property(strong,nonatomic) NSString *Tag_tagId;

@property(strong,nonatomic) NSString *S_privacy;
@property(strong,nonatomic) NSString *S_email;
@property(strong,nonatomic) NSString *S_follows;
@property(strong,nonatomic) NSString *S_fname;
@property(strong,nonatomic) NSString *S_lname;
@property(strong,nonatomic) NSString *S_karma;
@property(strong,nonatomic) NSString *S_propics;
@property(strong,nonatomic) NSString *S_story;
@property(strong,nonatomic) NSString *S_userid;
@property(strong,nonatomic) NSString *voteType;


@property(strong,nonatomic) NSString *demo_img;
@property(strong,nonatomic) NSString *demo_img1;

@property(strong,nonatomic) NSString *Voteforstoryid;


@property(strong,nonatomic) NSString *cat_user_name;
@property(strong,nonatomic) NSString *cat_user_email;
@property(strong,nonatomic) NSString *cat_user_firstName;
@property(strong,nonatomic) NSString *cat_user_profilePicUrl;
@property(strong,nonatomic) NSString *cat_user_userId;
@property(strong,nonatomic) NSString *cat_user_stories;
@property(strong,nonatomic) NSString *cat_user_map;
@property(strong,nonatomic) NSString *cat_user_storyid;
@property(strong,nonatomic) NSString *cat_user_lastname;
@property(strong,nonatomic) NSString *cat_user_karma;
@property(strong,nonatomic) NSString *confidential;
@property(strong,nonatomic) NSString *cat_user_follow;

@property(strong,nonatomic) NSString *tagstory_name;
@property(strong,nonatomic) NSString *tagstory_picUrl;
@property(strong,nonatomic) NSString *tagstory_tagid;
@property(strong,nonatomic) NSArray *tags_story;
@property(strong,nonatomic) NSString *tags_ids_story;

@property(strong,nonatomic) NSString *sub_user_name;
@property(strong,nonatomic) NSString *sub_user_email;
@property(strong,nonatomic) NSString *sub_user_firstName;
@property(strong,nonatomic) NSString *sub_user_profilePicUrl;
@property(strong,nonatomic) NSString *sub_user_userId;
@property(strong,nonatomic) NSString *sub_user_stories;
@property(strong,nonatomic) NSString *sub_user_map;
@property(strong,nonatomic) NSString *sub_user_storyid;
@property(strong,nonatomic) NSString *sub_user_lastname;
@property(strong,nonatomic) NSString *sub_user_karma;

@property(strong,nonatomic) NSString *sub_user_follow;

@property(strong,nonatomic) NSString *sty_confidences;
@property(strong,nonatomic) NSString *sty_badvotes;
@property(strong,nonatomic) NSString *sty_goodvotes;
@property(strong,nonatomic) NSString *sty_commentvotes;
@property(strong,nonatomic) NSString *sty_contentvotes;
@property(strong,nonatomic) NSString *sty_storyid;
@property(strong,nonatomic) NSString *sty_picUrl;


@property(strong,nonatomic) NSString *ratting_a_percent;
@property(strong,nonatomic) NSString *ratting_a_user;
@property(strong,nonatomic) NSString *ratting_c_percent;
@property(strong,nonatomic) NSString *ratting_c_user;
@property(strong,nonatomic) NSString *ratting_p_percent;
@property(strong,nonatomic) NSString *ratting_p_user;


@property(strong,nonatomic) NSString *promises_id;
@property(strong,nonatomic) NSString *promises_sector_id;
@property(strong,nonatomic) NSString *promises_descriptions;
@property(strong,nonatomic) NSString *promises_image;
@property(strong,nonatomic) NSString *promises_title;

@property(strong,nonatomic) NSString *progress_id;
@property(strong,nonatomic) NSString *progress_sector_id;
@property(strong,nonatomic) NSString *progress_descriptions;
@property(strong,nonatomic) NSString *progress_image;
@property(strong,nonatomic) NSString *progress_title;

@property(strong,nonatomic) NSString *outfit_id;
@property(strong,nonatomic) NSString *outfit_sector_id;
@property(strong,nonatomic) NSString *outfit_descriptions;
@property(strong,nonatomic) NSString *outfit_image;
@property(strong,nonatomic) NSString *outfit_promise_title;

@property(strong,nonatomic) NSString *sector_title;
@property(strong,nonatomic) NSString *sector__id;
@property(strong,nonatomic) NSString *sector_sub_title;
@property(strong,nonatomic) NSString *sector_image;
@property(strong,nonatomic) NSString *sectors_status;


@property(strong,nonatomic) NSString *rep_title;
@property(strong,nonatomic) NSString *rep_id;
@property(strong,nonatomic) NSString *rep_active;
@property(strong,nonatomic) NSString *rep_image;
@property(strong,nonatomic) NSString *rep_msg;

@property(strong,nonatomic) NSString *mini_title;
@property(strong,nonatomic) NSString *mini_id;
@property(strong,nonatomic) NSString *mini_sectors_id;
@property(strong,nonatomic) NSString *mini_image;

@property(strong,nonatomic) NSString *mini_cellno;
@property(strong,nonatomic) NSString *mini_fax_number;

@property(strong,nonatomic) NSString *mini_email;
@property(strong,nonatomic) NSString *mini_location_address;
@property(strong,nonatomic) NSString *mini_office_address;
@property(strong,nonatomic) NSString *mini_politician_logo;



@property(strong,nonatomic) NSString *mt_name;
@property(strong,nonatomic) NSString *mt_position;
@property(strong,nonatomic) NSString *mt_desc;
@property(strong,nonatomic) NSString *mt_image;

@property(strong,nonatomic) NSString *mt_Con_address;
@property(strong,nonatomic) NSString *mt_cur_ele_partyName;
@property(strong,nonatomic) NSString *mt_department;
@property(strong,nonatomic) NSString *mt_minister_id;

@property(strong,nonatomic) NSString *mt_isActive;
@property(strong,nonatomic) NSString *mt_partyLogo;
@property(strong,nonatomic) NSString *mt_partyName;
@property(strong,nonatomic) NSString *mt_respresentatives_id;

@property(strong,nonatomic) NSString *deptment_id;

@property(strong,nonatomic) NSString *mt_name1;
@property(strong,nonatomic) NSString *mt_position1;
@property(strong,nonatomic) NSString *mt_desc1;
@property(strong,nonatomic) NSString *mt_image1;

@property(strong,nonatomic) NSString *mt_Con_address1;
@property(strong,nonatomic) NSString *mt_cur_ele_partyName1;
@property(strong,nonatomic) NSString *mt_department1;
@property(strong,nonatomic) NSString *mt_minister_id1;

@property(strong,nonatomic) NSString *mt_isActive1;
@property(strong,nonatomic) NSString *mt_partyLogo1;
@property(strong,nonatomic) NSString *mt_partyName1;
@property(strong,nonatomic) NSString *mt_respresentatives_id1;


@property(strong,nonatomic) NSString *conil_name1;
@property(strong,nonatomic) NSString *conil_position1;
@property(strong,nonatomic) NSString *conil_desc1;
@property(strong,nonatomic) NSString *conil_image1;

@property(strong,nonatomic) NSString *conil_Con_address1;
@property(strong,nonatomic) NSString *conil_cur_ele_partyName1;
@property(strong,nonatomic) NSString *conil_department1;
@property(strong,nonatomic) NSString *conil_minister_id1;
@property(strong,nonatomic) NSString *conil_user_id1;
@property(strong,nonatomic) NSString *conil_isActive1;
@property(strong,nonatomic) NSString *conil_partyLogo1;
@property(strong,nonatomic) NSString *conil_partyName1;
@property(strong,nonatomic) NSString *conil_respresentatives_id1;
///commentaires
@property(strong,nonatomic) NSString *Comm_id;
@property(strong,nonatomic) NSString *Comm_user_id;
@property(strong,nonatomic) NSString *Comm_descriptions;
@property(strong,nonatomic) NSString *Comm_dateTime;


@end
