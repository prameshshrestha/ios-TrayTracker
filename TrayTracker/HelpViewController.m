//
//  HelpViewController.m
//  TrayTracker
//
//  Created by pramesh on 12/16/13.
//  Copyright (c) 2013 pramesh. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()
@property (strong, nonatomic) NSArray *arrayData;
@end

@implementation HelpViewController
@synthesize myTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    //self.myTableView.backgroundView = nil;
    //self.myTableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blue_gra.png"]];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"color_bg.png"]];
    [self.view addSubview:img];
    [self.view sendSubviewToBack:img];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dfm_slogo.png"]];
    //self.myTableView.backgroundColor = [UIColor redColor];
    //self.view.backgroundColor = [UIColor greenColor];
    self.arrayData = [[NSArray alloc]initWithObjects:
                      @"How to scan?                                                                         Click Scan button which will bring up the built-in camera. Face the camera to the barcode. Once the camera is able to read the barcode, the camera will close and print the barcode to the screen.",
                      @"What is service url?                                                                 The service url is the IP address or the name of the machine where the Service is located at. You will only need to type http://IPofthemachine on the service url textbox and rest will be taken care by the app.",
                      @"How to get Tracking Points?                                                                   Click getTrackingPoints button. Make sure the service url textbox is filled with the IP of the machine where the service is located at. Once you click the button, a service call is made by the app and returns all the selected tracking points.",
                      @"Send data to service?                                                                Before you click the Send button, make sure one of the tracking points and barcode is selected. Once that is done, wait for the response message.", nil];
    //self.title = @"Tray Tracker";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell Identifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString *help = [self.arrayData objectAtIndex:[indexPath row]];
    
    // Create custom color
    UIColor *color = [UIColor colorWithRed:0/255.0f green:150/255.0f blue:225/255.0f alpha:1.0f];
    
    cell.textLabel.textColor = color;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.textLabel setText:help];
    [cell.detailTextLabel setText:@"DFM"];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *detailsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    detailsViewController.help = [self.arrayData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailsViewController animated:YES];
}
/*
-(UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellAccessoryDisclosureIndicator;
}
 */
@end
