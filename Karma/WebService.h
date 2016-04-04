//
//  WebService.h
//  Mahesh Kumar Dhakad 

//  Created by Mahesh Kumar Dhakad on 08/07/15.
//  Copyright (c) 2015 Mahesh Kumar Dhakad. All rights reserved.
//

#include "Constant.h"

typedef enum {
    resultData=0,
    
    errorData,
    
    timeOut,
    
    resultOk
    
} MDDataTypes;

@interface WebService : NSObject
{
   //MBProgressHUD *HUD;
}
-(void)call_API:(NSDictionary *)dict andURL:(NSString *)url andVC:(UIViewController *)viewController OnResultBlock:(void(^)(id,MDDataTypes ,NSString *))OnResultBlock;

//-(void)call_API:(NSDictionary *)dict andURL:(NSString *)url OnResultBlock:(void(^)(id,MDDataTypes ,NSString *))OnResultBlock;

-(void) callWebservice : (NSDictionary *) dict : (id) obj : (NSString *) url : (NSString *) flagg;

+(UIColor *)colorWithHexString:(NSString *)colorString;
+ (NSString *)extractYoutubeIdFromLink:(NSString *)link ;

+(CALayer *)setBorderWithFrame:(CGRect)frame andColor:(UIColor *)color;

+ (NSString *)submitYouTubeURL:(NSString*)stringURL;


@end
