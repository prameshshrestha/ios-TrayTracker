//
//  ViewController.m
//  TrayTracker
//
//  Created by pramesh on 11/20/13.
//  Copyright (c) 2013 pramesh. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"
#import "SettingsViewController.h"

@interface ViewController ()
{
    NSString *errorMessage;
    NSDictionary *trackInfo;
    NSMutableArray *name;
    NSMutableDictionary *dict;
    NSArray *temp;
    NSString *keey;
    NSString *knownString;
    NSString *urlTrackingPointsService;
    NSString *urlSendDataService;
    NSString *serviceUrl;
    NSString *udid;
}
@end
#define WcfServiceURL [NSURL URLWithString:@"http://192.168.2.25/Service1.svc/json/trackingpoints"];

@implementation ViewController
    uint16_t port = 5001;
    NSString *str;
    int rowNumber;
@synthesize btnTrackingPoints, btnSend, btnScan, host, lblResult, activityIndicator, btnWrist;

- (IBAction) scanButtonTapped
{
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    ZBarImageScanner *scanner = reader.scanner;
    [scanner    setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    [self presentViewController:reader animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)reeader didFinishPickingMediaWithInfo:(NSDictionary *)info{
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for (symbol in results)
        break;
    //txtScannedBarcode.text = symbol.data;
    //str = txtScannedBarcode.text;
    str = symbol.data;
    if (symbol.data != nil){
        [arrBarcode addObject:str];
    }
    //resultImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.myTableView reloadData];
    [reeader dismissViewControllerAnimated:YES completion:nil];
}

//- (IBAction)scanComputer
//{
    //ZBarReaderController *reeader = [ZBarReaderController new];
    //reeader.readerDelegate = self;
    //if ([ZBarReaderController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    //    reeader.sourceType = UIImagePickerControllerSourceTypeCamera;
    //[reeader.scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    //[self presentViewController:reeader animated:YES completion:nil];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.myTableView.backgroundView = nil;
    //self.myTableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blue_gra.png"]];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"color_bg.png"]];
    [self.view addSubview:img];
    [self.view sendSubviewToBack:img];
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:mainQueue];
    arrBarcode = [[NSMutableArray alloc]init];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dfm_slogo.png"]];
    // Display btnTrackingPoints
    UIImage *imgTrackingPoints = [UIImage imageNamed:@"button_active.png"];
    [btnTrackingPoints setBackgroundImage:imgTrackingPoints forState:UIControlStateNormal];
    [btnTrackingPoints setTitle:@"Get Tracking Points" forState:UIControlStateNormal];
    [btnSend setEnabled:YES];
    // Display btnSend
    UIImage *imgSend = [UIImage imageNamed:@"button_active.png"];
    [btnSend setBackgroundImage:imgSend forState:UIControlStateNormal];
    [btnSend setTitle:@"Send" forState:UIControlStateNormal];
    // Display btnScan
    UIImage * imgScan = [UIImage imageNamed:@"button_active.png"];
    [btnScan setBackgroundImage:imgScan forState:UIControlStateNormal];
    [btnScan setTitle:@"Scan" forState:UIControlStateNormal];
    // Display btnWrist
    UIImage *imgWrist = [UIImage imageNamed:@"button_active.png"];
    [btnWrist setBackgroundImage:imgWrist forState:UIControlStateNormal];
    [btnWrist setTitle:@"Wrist" forState:UIControlStateNormal];
    
    // Display Scan Computer Button
    //UIImage *imgScanComputer = [UIImage imageNamed:@"button_active.png"];
    //[btnScanComputer setBackgroundImage:imgScanComputer forState:UIControlStateNormal];
    //[btnScanComputer setTitle:@"Scan Computer" forState:UIControlStateNormal];
    
    // Adding Navigation bar and buttons programatically
    //   UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    //navbar.backgroundColor = [UIColor grayColor];
    //[navbar setBackgroundImage:[UIImage imageNamed:@"bg_fade.png"] forBarMetrics:UIBarMetricsDefault];
 //   UINavigationItem *item = [[UINavigationItem alloc]initWithTitle:@"Tray Tracker"];
    
    /*
    UIBarButtonItem *showSettings = [[UIBarButtonItem alloc]initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:
                                @selector(showSettingsAction:)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:self action:
                                   @selector(saveAction:)];
    UIBarButtonItem *add = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    item.leftBarButtonItem = showSettings;
    item.rightBarButtonItem = rightButton;
    NSMutableArray *buttonArray = [[NSMutableArray alloc]initWithCapacity:2];
    [buttonArray addObject:rightButton];
    [buttonArray addObject:add];
    item.rightBarButtonItems = buttonArray;
    [navbar pushNavigationItem:item animated:NO];
    */
 //   navbar.items = @[item];
 //   [self.view addSubview:navbar];
    
    // Using Toolbar at the top programmatically
    /*
    UIToolbar *toolbar = [[UIToolbar alloc]init];
    toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    NSMutableArray *items = [[NSMutableArray alloc]init];
    [items addObject:[[UIBarButtonItem alloc]init]];
    [toolbar setItems:items animated:NO];
    [self.view addSubview:toolbar];
    */
    // To add toolbar to the screen
    //[self addToolbar];
 //   host = self.txtServiceUrl.text;
       //portNoTextField.text = tempPortNo;
  //  self.title = @"Tray Tracker";
  //  self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor colorWithRed:0.2 green:0.2 blue:0.8 alpha:1.0] forKey:NSForegroundColorAttributeName];
    [btnWrist setHidden:YES];
}

- (void) viewDidAppear:(BOOL)animated
{
    //host = self.txtServiceUrl.text;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tempServiceUrl = [defaults objectForKey:@"tempServiceUrl"];
    NSString *iosUser = [defaults objectForKey:@"iosUser"];
    bool isWristEnabled = [defaults boolForKey:@"isWristEnabled"];
    
    if (!isWristEnabled){
        [btnWrist setHidden:YES];
    }
    else{
        [btnWrist setHidden:NO];
    }
    serviceUrl = tempServiceUrl;
    host = serviceUrl;
    udid = iosUser;
}

/*
-(BOOL)hidesBottomBarWhenPushed{
    if (!isWristEnabled){
        return NO;
    }
    else{
        return YES;
    }
}
*/

- (void)valueChanged:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 0)
    {
        knownString = [name objectAtIndex:0];
        temp = [dict allKeysForObject:knownString];
        keey = [temp lastObject];
        lblResult.text = [NSString stringWithFormat:@" %@ ", keey];
    }
    else if (segment.selectedSegmentIndex == 1)
    {
        knownString = [name objectAtIndex:1];
        temp = [dict allKeysForObject:knownString];
        keey = [temp lastObject];
        lblResult.text = [NSString stringWithFormat:@" %@ ", keey];
    }
    else if (segment.selectedSegmentIndex == 2)
    {
        knownString = [name objectAtIndex:2];
        temp = [dict allKeysForObject:knownString];
        keey = [temp lastObject];
        lblResult.text = [NSString stringWithFormat:@" %@ ", keey];
    }
    else if (segment.selectedSegmentIndex == 3)
    {
        knownString = [name objectAtIndex:3];
        temp = [dict allKeysForObject:knownString];
        keey = [temp lastObject];
        lblResult.text = [NSString stringWithFormat:@" %@ ", keey];
    }
}

 -(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
 {
     [_responseData setLength: 0];
 }
 
 -(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
 {
     [_responseData appendData:data];
     NSString *strData = [[NSString alloc]initWithData:_responseData encoding:NSUTF8StringEncoding];
     NSLog(@"%@", strData);
 }
 
 -(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
 {
     NSLog(@"%@", error);
     errorMessage = [error localizedDescription];
     lblResult.text = errorMessage;
     UIAlertView *didFailWithErrorMessage = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Cannot connect to the server" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
     [didFailWithErrorMessage show];
 }
 
 -(void)connectionDidFinishLoading:(NSURLConnection *)connection
 {
     NSLog(@"DONE. Received Bytes: %d", [_responseData length]);
     NSString *theXML = [[NSString alloc] initWithBytes: [_responseData mutableBytes] length:[_responseData length] encoding:NSUTF8StringEncoding];
     NSLog(@"%@",theXML);
     NSData *myData = [theXML dataUsingEncoding:NSUTF8StringEncoding];
     xmlParser = [[NSXMLParser alloc]initWithData:myData];
     xmlParser.delegate = self;
     bool parsingResult = [xmlParser parse];
 }
 
 - (void)didReceiveMemoryWarning
 {
     [super didReceiveMemoryWarning];
 }
 
 -(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
 attributes:(NSDictionary *)attributeDict
 {
     NSString *currentDescription = [NSString alloc];
 }
 
 -(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
 {
     curDescription = string;
 }
 
 -(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
 {
     if([elementName isEqual:@"InsertTicketDetailsResult"]){
         lblResult.text = curDescription;
         NSLog(@"%@", curDescription);
     }
     
     
 }

//- (IBAction)showSettingsAction:(id)sender
//{
    /*SettingsViewController *settingsViewController = [[SettingsViewController alloc]init];
    if (settingsViewController)
    {
        settingsViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        settingsViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:settingsViewController animated:YES completion:NULL];
        showSettings = YES;
    }
    */
    // Programmatically showing ViewControllers using Push
    /*
    SettingsViewController *settingsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsViewController"];
    [self.navigationController pushViewController:settingsViewController animated:YES];
    */
//}
//- (IBAction)saveAction:(id)sender{}
//- (IBAction)addAction:(id)sender{}

- (IBAction)getTrackingPoints:(id)sender
{
    [self.activityIndicator startAnimating];
    
    dispatch_async(dispatch_get_global_queue((DISPATCH_QUEUE_PRIORITY_BACKGROUND), 0), ^
                   {
                       for (int i = 0; i < 100; i++)
                       {
                           [NSThread sleepForTimeInterval:.05];
                       }
                       dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [self.activityIndicator stopAnimating];
                       });
                   });
        
    
    
    
    
    
    // json call to wcf service to get all tracking points
    urlTrackingPointsService = [NSString stringWithFormat:@"%@/RoomService.svc/json/json/trackingpoints", serviceUrl];
    //NSURL *restUrl = [NSURL URLWithString:@"http://192.168.2.25/Service1.svc/json/trackingpoints"];
    NSURL *restUrl = [NSURL URLWithString:urlTrackingPointsService];
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:restUrl options:NSDataReadingUncached error:&error];
    if(!error)
    {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSMutableArray *array = [json objectForKey:@"GetAllTrackingPointsResult"];
        
        dict = [[NSMutableDictionary alloc]init];
        for (int i = 0; i < array.count; i++)
        {
            trackInfo = [array objectAtIndex:i];
            NSString *ttype = [trackInfo objectForKey:@"TType"];
            NSString *tname = [trackInfo objectForKey:@"TName"];
            [dict setValue:tname forKey:ttype];
        }
        name = [[NSMutableArray alloc]init];
        for (id key in dict)
        {
            id value = [dict objectForKey:key];
            [name addObject:value];
        }
    }
    else
    {
        [self.activityIndicator stopAnimating];
        UIAlertView *err = [[UIAlertView alloc]initWithTitle:@"Server Error" message:@"Cannot connect to the server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [err show];
    }
    // UISegmentControl
    UISegmentedControl *control = [[UISegmentedControl alloc]initWithItems:name];
    control.frame = CGRectMake(3, 250, 312, 40);
    UIColor *color = [UIColor colorWithRed:0/255.0f green:150/255.0f blue:225/255.0f alpha:1.0f];
    //control.tintColor = [UIColor colorWithRed:0.3f green:0.3f blue:0.7f alpha:1.0f];
    //[control setTintColor:color];
    [[UISegmentedControl appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:color} forState:UIControlStateNormal];
    [control addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:control];
    
    // Code for connect goes here
    /*
    if ([serverIpTextField.text isEqualToString:@""])
    {
        UIAlertView *serverErrorMessage = [[UIAlertView alloc]initWithTitle:@"Server Error" message:@"Server IP cannot be empty" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [serverErrorMessage show];
    }
    else if ([portNoTextField.text isEqualToString:@""])
    {
        UIAlertView *portErrorMessage = [[UIAlertView alloc]initWithTitle:@"Port No Empty" message:@"Port No cannot be mpty" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [portErrorMessage show];
    }
    else
    {
        // Connect method goes here
        NSError *error = nil;
        if (![asyncSocket connectToHost:serverIpTextField.text onPort:port error:&error])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not Connected" message:@"Could not connect to Server App, Try Again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
        else
        {
            [btnTrackingPoints setTitle:@"Connected" forState:UIControlStateNormal];
            [btnTrackingPoints setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnTrackingPoints setEnabled:NO];
        }
    }
     */
    [self.activityIndicator stopAnimating];
}

- (IBAction)send:(id)sender{
    // send data using socket
    //NSString *string = [[NSString alloc] initWithFormat:@"%@",str];
    //[asyncSocket writeData:[string dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    // soap request
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<InsertTicketDetails xmlns=\"http://tempuri.org/\">\n"
                             "<scanpt>%@</scanpt><barcode>%@</barcode>"
                             "</InsertTicketDetails>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n", keey, str
                             ];
    urlSendDataService = [NSString stringWithFormat:@"%@/RoomService.svc", serviceUrl];
    //NSURL *url = [NSURL URLWithString:@"http://192.168.2.25/RoomService.svc"];
    NSURL *url = [NSURL URLWithString:urlSendDataService];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    [theRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:@"http://tempuri.org/IRoomService/InsertTicketDetails" forHTTPHeaderField:@"soapaction"];
    [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *theConnection = [[NSURLConnection alloc]initWithRequest:theRequest delegate:self];
    
    // check the connection
    if (theConnection)
    {
        _responseData = [NSMutableData alloc];
    }
    else
    {
        UIAlertView *connectionAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Cannot connect to the service" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [connectionAlert show];
    }
    
    // check for response
    //NSData *compareData = [[NSData alloc]init];
    //if ([compareData isEqualToData:_responseData])
    if (_responseData == nil)
    {
        UIAlertView *noDataAlert = [[UIAlertView alloc]initWithTitle:@"Service Error" message:@"Cannot send data to the service" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noDataAlert show];
    }
    else
    {
        UIAlertView *successfullDataInsertAlert = [[UIAlertView alloc]initWithTitle:@"Connecting........." message:@"Connecting to server, press OK to continue" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [successfullDataInsertAlert show];
    }
    // check null here
    /*
    if ([keey length] != 0)
    {
        if ([str length] == 0)
        {
            UIAlertView *strAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Please, select a barcode to send" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [strAlert show];
        }
        else
        {
            
        }
    }
    else
    {
        UIAlertView *keeyAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Please, select a Tracking Point" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [keeyAlert show];
    }
     */
    //[NSThread isMainThread];
    //dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //dispatch_get_main_queue() == dispatch_get_current_queue();
}

- (IBAction)btnWrist:(id)sender {
}

//- (IBAction)settingsButtonPressed:(id)sender {}


-(NSInteger)numberOfSectionsInTableView: (UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@" %i ", arrBarcode.count);
    return [arrBarcode count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell Identifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *barcode = [arrBarcode objectAtIndex:[indexPath row]];
    // Create custom color
    UIColor *color = [UIColor colorWithRed:0/255.0f green:150/255.0f blue:225/255.0f alpha:1.0f];
    cell.textLabel.textColor = color;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];    [cell.textLabel setText:barcode];
    [cell setBackgroundColor:[UIColor clearColor]];
    //UIButton *btn = [[UIButton alloc]init];
    //btn.frame = CGRectMake(200, 5.0, 50, 30);
    //btn.backgroundColor = [UIColor blackColor];
    //[btn setTitle:@"Send" forState:UIControlStateNormal];
    //[cell addSubview:btn];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UIColor *color = [UIColor colorWithRed:0/255.0f green:150/255.0f blue:225/255.0f alpha:1.0f];
    view.tintColor = color;
    //text color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
}

// Set the identation for rows in UITableView
-(NSInteger) tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 5;
}

// Set the cell click
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    rowNumber = indexPath.row;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    str = cell.textLabel.text;
}
// Set the scroll in UITableView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    float reload_distance = 10;
    if (y > h + reload_distance)
    {
        [self.myTableView reloadData];
    }
}
// Delete the data in each cell in UITableView
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [arrBarcode removeObjectAtIndex:indexPath.row];
        [self.myTableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//- (void) addToolbar{
    //UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //UIBarButtonItem *customItem1 = [[UIBarButtonItem alloc]initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(toolbarItem1:)];
    //UIBarButtonItem *customItemScan = [[UIBarButtonItem alloc]initWithTitle:@"Scan" style:UIBarButtonItemStyleBordered target:self action:@selector(toolbarItemScan:)];
    //UIBarButtonItem *customItemScan = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"scan_lens.png"] landscapeImagePhone:[UIImage imageNamed:@"scan_lens.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarItemScan:)];
    //UIBarButtonItem *customItemScanPhone = [[UIBarButtonItem alloc]initWithTitle:@"Scan Phone" style:UIBarButtonItemStyleBordered target:self action:@selector(toolbarItemScanPhone:)];
    // UIBarButtonItem with image
    /*
    UIBarButtonItem *customItemSettings = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"settingsicon.png"] landscapeImagePhone:[UIImage imageNamed:@"settingsicon@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarItemSettings:)];
    */
    //UIBarButtonItem *customItemConnect = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"connect_database.png"] landscapeImagePhone:[UIImage imageNamed:@"connect_database.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarItemConnect:)];
    //UIBarButtonItem *customItemConnect = [[UIBarButtonItem alloc]initWithTitle:@"Connect" style:UIBarButtonItemStyleBordered target:self action:@selector(toolbarItemConnect:)];
    //UIBarButtonItem *customItemSend = [[UIBarButtonItem alloc]initWithTitle:@"Send" style:UIBarButtonItemStyleBordered target:self action:@selector(toolbarItemSend:)];
    //UIBarButtonItem *customItemSend = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"send_data.png"] landscapeImagePhone:[UIImage imageNamed:@"send_data.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toolbarItemSend:)];
    //NSArray *toolbarItems = [NSArray arrayWithObjects:customItemScan,spaceItem, customItemScanPhone, spaceItem, customItemConnect, spaceItem, customItemSend, nil];
    // create a UIToolbar programatically
    //UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0,438, 320, 44.0f)];
    //toolbar.barStyle = UIBarStyleBlackOpaque;
    //[toolbar sizeToFit];
    //[self.view addSubview:toolbar];
    //[toolbar setItems:toolbarItems];
//}

//- (IBAction)toolbarItemScan:(id)sender{}
//- (IBAction)toolbarItemScanPhone:(id)sender{}
//- (IBAction)toolbarItemConnect:(id)sender{}
//- (IBAction)toolbarItemSend:(id)sender{}

- (BOOL)prefersStatusBarHidden{
    // This will hide the UIStatusBar
    return NO;
}
@end
