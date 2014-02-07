//
//  ViewController.h
//  TrayTracker
//
//  Created by pramesh on 11/20/13.
//  Copyright (c) 2013 pramesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncSocket.h"

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, ZBarReaderDelegate, UITextFieldDelegate, NSURLConnectionDataDelegate, NSXMLParserDelegate>
{
    GCDAsyncSocket *asyncSocket;
    //UIImageView *resultImage;
    UITextView  *txtScannedBarcode;
    NSMutableArray *arrBarcode;
    NSString *host;
    NSMutableData *_responseData;
    NSXMLParser *xmlParser;
    NSString *curDescription;
    bool *finished;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (retain, nonatomic) NSURLConnection *connection;
@property (weak, nonatomic) IBOutlet UILabel *lblResult;
//@property (weak, nonatomic) IBOutlet UILabel *humanText;
@property (nonatomic, retain) NSString *host;
//@property (nonatomic, retain) IBOutlet UIImageView *resultImage;
//@property (nonatomic, retain) IBOutlet UITextView *txtScannedBarcode;
//@property (strong, nonatomic) IBOutlet UIButton *btnConnect;
@property (strong, nonatomic)IBOutlet UIButton *btnTrackingPoints;
@property (strong, nonatomic) IBOutlet UIButton *btnSend;
@property (strong, nonatomic) IBOutlet UIButton *btnScan;
@property (weak, nonatomic) IBOutlet UIButton *btnWrist;
//@property (strong, nonatomic) IBOutlet UIButton *btnScanComputer;
@property (nonatomic, retain) IBOutlet UITableView *myTableView;
- (IBAction) scanButtonTapped;
//- (IBAction)scanComputer;
- (IBAction)getTrackingPoints:(id)sender;
- (IBAction)send:(id)sender;
- (IBAction)btnWrist:(id)sender;
//- (IBAction)settingsButtonPressed:(id)sender;
@end
