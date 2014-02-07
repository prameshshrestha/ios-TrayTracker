//
//  SetViewController.m
//  TrayTracker
//
//  Created by pramesh on 1/24/14.
//  Copyright (c) 2014 pramesh. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()

@end

@implementation SetViewController{
   BOOL isWristEnabled;
}
@synthesize txtUser, txtServiceUrl, btnSave, btnUdid;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"color_bg.png"]];
    [self.view addSubview:img];
    [self.view sendSubviewToBack:img];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dfm_slogo.png"]];
    // create a uiswitch programatically
    UISwitch *yourSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(240, 180, 0, 0)];
    [yourSwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:yourSwitch];
    // Display btnSave
    UIImage *imgSave = [UIImage imageNamed:@"button_active.png"];
    [btnSave setBackgroundImage:imgSave forState:UIControlStateNormal];
    [btnSave setTitle:@"Save" forState:UIControlStateNormal];
    // Display btnUdid
    UIImage *imgUdid = [UIImage imageNamed:@"button_active.png"];
    [btnUdid setBackgroundImage:imgUdid forState:UIControlStateNormal];
    [btnUdid setTitle:@"Generate Unique ID" forState:UIControlStateNormal];
    // nsuserdefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tempServiceUrl = [defaults objectForKey:@"tempServiceUrl"];
    NSString *iosUser = [defaults objectForKey:@"iosUser"];
    isWristEnabled = [defaults boolForKey:@"isWristEnabled"];
    txtServiceUrl.text = tempServiceUrl;
    txtUser.text = iosUser;
    
    if (isWristEnabled){
        [yourSwitch setOn:YES animated:YES];
        //[yourSwitch isOn];
        NSLog(@"switch is on");
    }
}

-(void)changeSwitch:(id)sender{
    if ([sender isOn]){
        isWristEnabled = YES;
    }
    else{
        isWristEnabled = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)generateUdid:(id)sender {
    // create udid
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)
                      uuidStringRef];
    txtUser.text = uuid;
}

- (IBAction)Save:(id)sender
{
    [txtServiceUrl resignFirstResponder];
    [txtUser resignFirstResponder];
    // Save data using NSUserDefault
    NSString *tempServiceUrl = [txtServiceUrl text];
    NSString *iosUser = [txtUser text];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:tempServiceUrl forKey:@"tempServiceUrl"];
    [defaults setObject:iosUser forKey:@"iosUser"];
    //[defaults setBool:isWristEnabled forKey:@"isWristEnabled"];
    [defaults setBool:isWristEnabled forKey:@"isWristEnabled"];
    [defaults synchronize];
    // alert the user that the data has been saved
    UIAlertView *saveAlert = [[UIAlertView alloc]initWithTitle:@"Data Saved"
                                                       message:@"Data has been successfully saved" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [saveAlert show];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [txtServiceUrl resignFirstResponder];
    [txtUser resignFirstResponder];
    return true;
}
@end
