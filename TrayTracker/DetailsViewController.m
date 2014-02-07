//
//  DetailsViewController.m
//  TrayTracker
//
//  Created by pramesh on 12/17/13.
//  Copyright (c) 2013 pramesh. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

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
	[self.labelOutlet setText:self.help];
    [self.labelOutlet setTextColor:[UIColor whiteColor]];
    
    // Create a custom color
     UIColor *color = [UIColor colorWithRed:0/255.0f green:150/255.0f blue:225/255.0f alpha:1.0f];
    [self.labelOutlet setBackgroundColor:color];
    
    [self.labelOutlet setFont:[UIFont fontWithName:@"Helvetica" size:20.0]];
    self.title = @"Tray Tracker";
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"color_bg.png"]];
    [self.view addSubview:img];
    [self.view sendSubviewToBack:img];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dfm_slogo.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
