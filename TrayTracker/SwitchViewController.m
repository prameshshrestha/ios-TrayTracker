//
//  SwitchViewController.m
//  TrayTracker
//
//  Created by pramesh on 1/29/14.
//  Copyright (c) 2014 pramesh. All rights reserved.
//

#import "SwitchViewController.h"

@interface SwitchViewController (){
    
    NSString *ticketBarcode;
    NSString *patientBarcode;
    NSString *serviceUrl;
    NSString *urlSendDataService;
    NSString *errorMessage;
    
}
@end

@implementation SwitchViewController
{
    NSString *str;
    BOOL patient;
}
@synthesize lblResult, btnScanPatientWrist, btnScanTicket, btnCheckDiet, lblPatient, lblTicket;

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
    // create a btnScanTicket programatically
    UIImage * imgScan = [UIImage imageNamed:@"button_active.png"];
    [btnScanTicket setBackgroundImage:imgScan forState:UIControlStateNormal];
    [btnScanTicket setTitle:@"Scan Ticket" forState:UIControlStateNormal];
    // create btnScanPatientWrist programatically
    [btnScanPatientWrist setBackgroundImage:imgScan forState:UIControlStateNormal];
    [btnScanPatientWrist setTitle:@"Scan Wrist" forState:UIControlStateNormal];
    // create btnCheckDiet programatically
    [btnCheckDiet setBackgroundImage:imgScan forState:UIControlStateNormal];
    [btnCheckDiet setTitle:@"Check Diet" forState:UIControlStateNormal];
}

- (void) viewDidAppear:(BOOL)animated
{
    //host = self.txtServiceUrl.text;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tempServiceUrl = [defaults objectForKey:@"tempServiceUrl"];
    serviceUrl = tempServiceUrl;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)btnScanTicket:(id)sender {
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
    str = symbol.data;
    if (symbol.data != nil){
        if (patient) {
            lblPatient.text = str;
            patientBarcode = lblPatient.text;
        }
        else{
            lblTicket.text = str;
            ticketBarcode = lblTicket.text;
        }
    }
    [reeader dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnScanPatientWrist:(id)sender {
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    ZBarImageScanner *scanner = reader.scanner;
    [scanner    setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    [self presentViewController:reader animated:YES completion:nil];
    patient = YES;
}

- (IBAction)btnCheckDiet:(id)sender {
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<CheckDiet xmlns=\"http://tempuri.org/\">\n"
                             "<ticketBarcode>%@</ticketBarcode><patientBarcode>%@</patientBarcode>"
                             "</CheckDiet>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",ticketBarcode, patientBarcode
                             ];
    urlSendDataService = [NSString stringWithFormat:@"%@/RoomService.svc", serviceUrl];
    NSURL *url = [NSURL URLWithString:urlSendDataService];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    [theRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:@"http://tempuri.org/IRoomService/CheckDiet" forHTTPHeaderField:@"soapaction"];
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
    if([elementName isEqual:@"CheckDiet"])
    {
        lblResult.text = curDescription;
        NSLog(@"%@", curDescription);
    }
    
}
@end
