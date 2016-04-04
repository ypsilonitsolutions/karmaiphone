//
//  UIImage+ImageWithUIView.m
//  MKDSlidingViewController
//
//  Created by Mahesh Kumar Dhakad on 12/23/12.
//  Copyright (c) 2012 MKD. All rights reserved.
//

#import "UIImage+ImageWithUIView.h"

@implementation UIImage (ImageWithUIView)
#pragma mark -
#pragma mark TakeScreenShot

+ (UIImage *)imageWithUIView:(UIView *)view
{
  CGSize screenShotSize = view.bounds.size;
  UIImage *img;  
  UIGraphicsBeginImageContext(screenShotSize);
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  [view drawLayer:view.layer inContext:ctx];
  img = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return img;
}
@end
