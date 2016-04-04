//
//  WebService.m
//  Mahesh Kumar Dhakad

//  Created by Mahesh Kumar Dhakad on 08/07/15.
//  Copyright (c) 2015 Mahesh Kumar Dhakad. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "WebService.h"

@implementation WebService : NSObject


-(void)call_API:(NSDictionary *)dict andURL:(NSString *)url andVC:(UIViewController *)viewController OnResultBlock:(void(^)(id,MDDataTypes ,NSString *))OnResultBlock{
    
    NSURL *baseURL = [NSURL URLWithString:url];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/json",@"application/json",@"text/javascript",@"text/html",nil]];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [client postPath:@"" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         NSInteger statusCode = operation.response.statusCode;

         if(statusCode  == 200)
         {
             NSDictionary *dictResponse = responseObject;
             
             NSArray *response = responseObject;
             
             if([responseObject isKindOfClass:[NSArray class]]){
                 //Is array
                 NSLog(@"Response is array");
                 if ([response containsObject:@"errors"])
                 {
                     NSDictionary *errors = [dictResponse valueForKey:@"errors"];
                   __block  NSString *mgs ;
                     
                     NSEnumerator *enumerator = [errors keyEnumerator];
                     id key;
                     // extra parens to suppress warning about using = instead of ==
                     while((key = [enumerator nextObject])){
                         
                         NSLog(@"key = %@ value = %@", key, [errors objectForKey:key]);
                         
                        // mgs = [errors objectForKey:key];
                     }
                     
                     [errors enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL* stop) {
                         
                         NSLog(@"%@ => %@", key, value);
                         
                          mgs = [errors objectForKey:key];
                     }];
                     
                     [self stop_Loading:viewController];
                     
                     [[[UIAlertView alloc] initWithTitle:@"Error" message:mgs delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];
                     
                 }else{
                     
                     OnResultBlock(dictResponse,resultData,@"");
                 }

             }else if([responseObject isKindOfClass:[NSDictionary class]]){
                 //is dictionary
                 NSLog(@"Response is dictionary");
                 
                 BOOL isError = false;
                 
                 for( NSString *aKey in [dictResponse allKeys] ){
                     if([aKey isEqualToString:@"errors"]){
                         
                         isError = true;
                     }
                     NSLog(@"aKey %@",aKey);
                 }
                 
                 
                 if (isError)
                 {
                     NSDictionary *errors = [dictResponse valueForKey:@"errors"];
                    __block NSString *mgs ;

                     NSEnumerator *enumerator = [errors keyEnumerator];
                     id key;
                     // extra parens to suppress warning about using = instead of ==
                     while((key = [enumerator nextObject])){
                         
                         NSLog(@"key = %@ value = %@", key, [errors objectForKey:key]);
                         
                        // mgs = [errors objectForKey:key];
                     }
                     
                     [errors enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL* stop) {
                         
                         NSLog(@"%@ => %@", key, value);
                         
                         mgs = [errors objectForKey:key];
                     }];
                     
                     NSString *sts = [NSString stringWithFormat:@"%@",[dictResponse valueForKey:@"status"]];
                     
                     if ([sts intValue] == -1) {
                         
                         [self fb_Logout];
                         [viewController.navigationController popToRootViewControllerAnimated:NO];
                     }else{
                         
                         [self stop_Loading:viewController];

                         [[[UIAlertView alloc] initWithTitle:@"Error" message:mgs delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];
                     }
                 }else{
                   
                     
                     OnResultBlock(dictResponse,resultData,@"");
                 }
                 
             }else if([responseObject isKindOfClass:[NSNull class]]){
                 
                 [self stop_Loading:viewController];

             }else{
                 //is something else
                 NSLog(@"Response is something");
             //    OnResultBlock(dictResponse,resultData,@"");
                 [self stop_Loading:viewController];
             }
            
         }else{
             
             [self stop_Loading:viewController];
         }
         
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error){
         
         NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
         NSInteger statusCode = operation.response.statusCode;
         
         NSString *responseString =  operation.responseString;
         
         if(statusCode  == 200)
         {
             
         }

         [dict setValue:@"false" forKey:@"status"];
         
         [dict setValue:@"Connection timeout, try later!" forKey:@"msg"];
        // OnResultBlock(dict,resultData,@"failure");
         
         [self stop_Loading:viewController];
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Connection timeout, try later!" delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
         [alert show];

       }
     ];
    
}


-(void) callWebservice : (NSDictionary *) dict : (id) obj : (NSString *) url : (NSString *) flagg {
    NSString *str=[url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *baseURL = [NSURL URLWithString:str];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/json",@"application/json",@"text/javascript",@"text/html",nil]];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [client postPath:@"" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //For registration class
     }
     //Failure Condition
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
    
     }
     ];
    
}



-(void)call_API:(NSString *)url OnResultBlock:(void(^)(id,MDDataTypes ,NSString *))OnResultBlock
{
    
    NSURL *baseUrl=[NSURL URLWithString:url];
    NSURLRequest *req=[NSURLRequest requestWithURL:baseUrl];
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse *resp, NSData *data, NSError *err){
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) resp;
         NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
         NSString *code = [NSString stringWithFormat:@"%ld",(long)[httpResponse statusCode]];
         NSMutableDictionary *dictionary1 =[NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
         OnResultBlock(dictionary1,resultData,code);
         
     }];
}


-(void)stop_Loading:(UIViewController *)viewController{
    
    for ( UIView *subview in viewController.view.subviews ) {
        
        if ([subview  isKindOfClass:[MBProgressHUD class]] ) {
            
             MBProgressHUD *hud = (MBProgressHUD *)[subview viewWithTag:444];
            
            [hud hide:YES];
            
        }
    }
   
}


-(void)fb_Logout
{
    [FBSession.activeSession closeAndClearTokenInformation];
    [FBSession.activeSession close];
}

// For Call APi where you want



/*
 
 
 NSURL *baseUrl=[NSURL URLWithString:url];
 NSURLRequest *req=[NSURLRequest requestWithURL:baseUrl];
 [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:
 ^(NSURLResponse *resp, NSData *data, NSError *err){
 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) resp;
 NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
 NSString *code = [NSString stringWithFormat:@"%ld",(long)[httpResponse statusCode]];
 NSMutableDictionary *dictionary1 =[NSJSONSerialization JSONObjectWithData:data
 options:NSJSONReadingMutableContainers
 error:nil];
 OnResultBlock(dictionary1,resultData,code);
 
 
 
 
 }];
 
 
 
 
 
 
 
 
 
 WebService *api = [WebService alloc];
 
 [api call_API:dict andURL:GET_CATEGORY_API OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {
 
 NSDictionary *dic = response ;
 
 NSString *sts=[dic objectForKey:@"status"];
 
 if ([sts isEqualToString:@"true"]) {
 
 }else{
 
 }
 }];
 
 */





#pragma mark - colorWithHexString Methods
#pragma mark -


+(UIColor *)colorWithHexString:(NSString *)colorString
{
    colorString = [colorString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    if (colorString.length == 3)
        colorString = [NSString stringWithFormat:@"%c%c%c%c%c%c",
                       [colorString characterAtIndex:0], [colorString characterAtIndex:0],
                       [colorString characterAtIndex:1], [colorString characterAtIndex:1],
                       [colorString characterAtIndex:2], [colorString characterAtIndex:2]];
    
    if (colorString.length == 6)
    {
        int r, g, b;
        sscanf([colorString UTF8String], "%2x%2x%2x", &r, &g, &b);
        return [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0];
    }
    return nil;
}


#pragma mark - extractYoutubeIdFromLink Methods
#pragma mark -

+ (NSString *)extractYoutubeIdFromLink:(NSString *)link {
    
    NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *array = [regExp matchesInString:link options:0 range:NSMakeRange(0,link.length)];
    if (array.count > 0) {
        NSTextCheckingResult *result = array.firstObject;
        return [link substringWithRange:result.range];
    }
    return nil;
}


// get Video Normal URL from Youtube URL

+ (NSString *)submitYouTubeURL:(NSString*)stringURL {
    
   __block NSString *URLString = nil;

    NSURL *url = [NSURL URLWithString:stringURL];
    
    [MDYoutubeParser thumbnailForYoutubeURL:url thumbnailSize:YouTubeThumbnailDefaultHighQuality completeBlock:^(UIImage *image, NSError *error) {
        
        if (!error) {
            
            [MDYoutubeParser h264videosWithYoutubeURL:url completeBlock:^(NSDictionary *videoDictionary, NSError *error) {
                
                NSDictionary *qualities = videoDictionary;
                
                if ([qualities objectForKey:@"small"] != nil) {
                    URLString = [qualities objectForKey:@"small"];
                }
                else if ([qualities objectForKey:@"live"] != nil) {
                    URLString = [qualities objectForKey:@"live"];
                }
                else {
                    [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Couldn't find youtube video" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];
                   // return;
                }
                
            }];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alert show];
        }
    }];
    
    return URLString;
}



#pragma mark - For Border / CALayer Set Methods
#pragma mark -

+(CALayer *)setBorderWithFrame:(CGRect)frame andColor:(UIColor *)color{
    
    CALayer *border = [CALayer layer];
    border.frame = frame;
    //CGRectMake(0.0f, 0, self.frame.size.width, 1.0f);
    border.backgroundColor = color.CGColor;
    return border;
    
    // [self.view.layer addSublayer:border];

}

- (void)embedYouTube:(NSString*)url frame:(CGRect)frame
{
    if (!([url rangeOfString:@"youtube.com" options:NSCaseInsensitiveSearch].location ==NSNotFound))
    {
        
        
        NSString *htmlString = [NSString stringWithFormat:@"\
                                <html>\
                                <body style='margin:0px;padding:0px;'>\
                                <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
                                <script type='text/javascript'>\
                                function onYouTubeIframeAPIReady()\
                                {\
                                ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
                                }\
                                function onPlayerReady(a)\
                                { \
                                a.target.playVideo(); \
                                }\
                                </script>\
                                <iframe id='playerId' type='text/html' width='%f' height='%f' src='%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'>\
                                </body>\
                                </html>", frame.size.width ,frame.size.height, url];
        
        UIWebView *videoView = [[UIWebView alloc] initWithFrame:frame];
        
        [videoView loadHTMLString:htmlString baseURL:nil];
         videoView.scrollView.bounces = NO;
       // [view_FullStoryImage addSubview:videoView];
        
    }else{
        
        NSMutableString *link =[url mutableCopy];
        
        [link replaceOccurrencesOfString:@"http://" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[link length])];
        
        if([url rangeOfString:@"https://" ].location!=NSNotFound){
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]]];
        }else {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",url]]];
        }
    }
    
    
    
}

#pragma mark - Get TextHeight
#pragma mark -

+ (CGFloat)get_TextHeight:(NSString *)text minimumHeight:(CGFloat)minimumHeight textViewFrame:(CGRect)textViewFrame{
    
    CGRect textViewSize = [text boundingRectWithSize:CGSizeMake(285, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size:16]} context:nil];
    
    const CGFloat additionalSpace = minimumHeight - textViewFrame.size.height + 10;
    
    CGFloat rowHeight = textViewSize.size.height + additionalSpace;
    
    return rowHeight;
}

#pragma mark - @end

#pragma mark -

@end

