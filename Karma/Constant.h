//
//  Constant.h
//

// ********* All Alert ********* //

#define _AlertView_With_Delegate(title, msg, button, buttons...) {UIAlertView *__alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:button otherButtonTitles:buttons];[__alert show];}

#define _AlertView_WithOut_Delegate(title, msg, button, buttons...) {UIAlertView *__alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:button otherButtonTitles:buttons];[__alert show];}


#define FB_APP_ID @"751139751658667"


// ********* App All Color ********* \\

#define PINKCOLOR [UIColor colorWithRed:  0.941 green:0.196 blue:0.392 alpha:1]

#define BLUECOLOR [UIColor colorWithRed:0.392 green:0.784 blue:0.941 alpha:1]


#define STRIP [UIColor colorWithRed:0.831 green:0.929 blue:0.925 alpha:1]
#define SEPARATOR [UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1] 

#define HEADERTEXT [UIColor colorWithRed:0.443 green:0.882 blue:0.898 alpha:1]


#define PROFILE_HEADER [UIColor colorWithRed:0.016 green:0.016 blue:0.016 alpha:1]
#define PROFILE_SUBTITLE [UIColor colorWithRed:0.443 green:0.882 blue:0.898 alpha:1]
#define PROFILE_SUBTITLE1 [UIColor colorWithRed:0.039 green:0.6 blue:0.529 alpha:1]

#define PROFILE_COMMINATION [UIColor colorWithRed:0.004 green:0.043 blue:0.259 alpha:1]
#define PROFILE_NUMBER [UIColor colorWithRed:0 green:0.651 blue:0.318 alpha:1]


#define PROFILE_HEADERPOPULARITY [UIColor colorWithRed:0.831 green:0.929 blue:0.925 alpha:1]



// ********* Frameworks Import ********* \\

#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import <FacebookSDK/FacebookSDK.h>

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UITableView.h>
#import <UIKit/UIKitDefines.h>
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

// ********* Import ALL TableView Custom Cell ********* \\

#import "StoryTagCell.h"
#import "CategoryListCell.h"
#import "SearchTVCell.h"
#import "StoryTVCell.h"
#import "NotificationTVCell.h"
#import "ProfileFollowerCell.h"
#import "StoryCommentsTVCell.h"
#import "StoryTagCell.h"
//  ********* Import External Class ********* \\

#import "AFNetworking.h"
#import "MBProgressHUD.h"
//#import "CALayer+ViewBorder.h"
#import "IQKeyboardManager.h"
#import "MDImageView.h"
#import "MDYoutubeParser.h"
#import "UIImage+animatedGIF.h"
#import "MDGrowingTextView.h"
#import "MDImageRotate.h"
#import "DraggableView.h"
#import "CardView.h"
#import "KarmaMeterView.h"


#import "MDSlidingViewController.h"
#import "InitialSlidingViewController.h"
#import "MenuViewController.h"

// ********* Import GLOBLE CLASSES ********* \\

#import "WebService.h"
#import "Modelclass.h"

// ********* Import ALL CONTROLLER ********* \\

#import "AppDelegate.h"
#import "RootViewController.h"
#import "CategoryList.h"
#import "Profile.h"
#import "StoryViewController.h"
#import "StoryCommentsVC.h"
#import "AddStoryViewController.h"
#import "NotificationVC.h"



// ********* Web Services URLs ********* \\

#define BASE_URL @"http://72.167.41.165/noupays/webservices/api.php"

#define SEARCH_PEOPLE @"http://karma.vote:8080/api/search_people"

#define LOGIN @"http://karma.vote:8080/api/login"

#define GET_TAGS @"http://karma.vote:8080/api/get_tags"

#define GET_PROFILE @"http://karma.vote:8080/api/get_profile"

#define GET_STORIES @"http://karma.vote:8080/api/get_stories"

#define GET_TRENDING_STORIES @"http://karma.vote:8080/api/get_trending_stories"

#define GET_TRENDING_PEOPLE @"http://karma.vote:8080/api/get_trending_people"

#define UPDATE_PROFILE @"http://karma.vote:8080/api/update_profile"
#define UPDATE_PROFILE_IMAGE @"http://karma.vote:8080/api/update_profile_image"

#define ADD_STORY_IMAGE @"http://karma.vote:8080/api/add_story_image"

#define ADD_STORY @"http://karma.vote:8080/api/add_story"

#define GET_TAGS @"http://karma.vote:8080/api/get_tags"

#define TOGGLE_FOLLOWER @"http://karma.vote:8080/api/toggle_follower"

#define GET_FOLLOWERS @"http://karma.vote:8080/api/get_followers"

#define IS_FOLLOWING @"http://karma.vote:8080/api/is_following"


#define DELETE @"http://karma.vote:8080/api/delete"
#define REPORT @"http://karma.vote:8080/api/report"

#define DELETE_STORY @"http://karma.vote:8080/api/delete_story"
#define REPORT_STORY @"http://karma.vote:8080/api/report_story"

#define CLEAR_NOTIFICATIONS @"http://karma.vote:8080/api/clear_notifications"

#define GET_NOTIFICATIONS @"http://karma.vote:8080/api/get_notifications"

#define ADD_COMMENT @"http://karma.vote:8080/api/add_comment"

#define GET_COMMENTS @"http://karma.vote:8080/api/get_comments"

#define VOTE_STORY @"http://karma.vote:8080/api/vote_story"

#define UPDATE_STORY @"http://karma.vote:8080/api/update_story"


#define SUCCESS_RESPONSE @"A"



