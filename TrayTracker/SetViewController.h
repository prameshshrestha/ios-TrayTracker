//
//  SetViewController.h
//  TrayTracker
//
//  Created by pramesh on 1/24/14.
//  Copyright (c) 2014 pramesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtServiceUrl;
@property (weak, nonatomic) IBOutlet UITextField *txtUser;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnUdid;
- (IBAction)generateUdid:(id)sender;

- (IBAction)Save:(id)sender;
@end
