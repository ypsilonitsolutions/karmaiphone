//
//  CALayer+ViewBorder.m
//  Farma
//
//  Created by Akhilesh Mourya on 03/10/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "CALayer+ViewBorder.h"

@implementation CALayer (ViewBorder)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
