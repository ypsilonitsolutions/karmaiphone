//
//  CustomUIASView.h
//  CustomUIASView
//
//  Created by Mahesh Kumar Dhakad on 05/07/15.
//  Copyright (c) 2012 MKD. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomUIASView : UIView <UITextFieldDelegate> {
    

}

@property (nonatomic, retain) IBOutlet UIButton *btn_Dismiss;

@property (nonatomic, retain) IBOutlet UIButton *btn_Camera;
@property (nonatomic, retain) IBOutlet UIButton *btn_Library;
@property (nonatomic, retain) IBOutlet UIButton *btn_YouTube;
@property (nonatomic, retain) IBOutlet UIButton *btn_CancelBig;
@property (nonatomic, retain) IBOutlet UIButton *btn_Submit;
@property (nonatomic, retain) IBOutlet UIButton *btn_Cancel;

@property (nonatomic, retain) IBOutlet UIView *view_Contains;
@property (nonatomic, retain) IBOutlet UIView *view_SubContains;

@property (nonatomic, retain) IBOutlet UITextField *tf_VideoLink;


@end
