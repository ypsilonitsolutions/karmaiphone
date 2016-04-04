//
//  MDImageRotate.h
//  Karma
//
//  Created by MaheshDhakad on 25/08/15.
//  Copyright (c) 2015 MaheshDhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIImage (fixOrientation)

+(UIImage *)scaleAndRotateImage :(UIImage*)image;
+ (UIImage *)fixOrientation:(UIImage *)image;

@end
