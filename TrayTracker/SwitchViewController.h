//
//  SwitchViewController.h
//  TrayTracker
//
//  Created by pramesh on 1/29/14.
//  Copyright (c) 2014 pramesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchViewController : UIViewController<ZBarReaderDelegate, NSURLConnectionDataDelegate, NSXMLParserDelegate>{
    NSMutableData *_responseData;
    NSXMLParser *xmlParser;
    NSString *curDescription;
}
@property (weak, nonatomic) IBOutlet UILabel *lblTicket;
@property (weak, nonatomic) IBOutlet UILabel *lblPatient;
@property (weak, nonatomic) IBOutlet UILabel *lblResult;
@property (weak, nonatomic) IBOutlet UIButton *btnScanTicket;
@property (weak, nonatomic) IBOutlet UIButton *btnScanPatientWrist;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckDiet;
@property (weak, nonatomic) IBOutlet UILabel *lblTest;

- (IBAction)btnScanTicket:(id)sender;
- (IBAction)btnScanPatientWrist:(id)sender;
- (IBAction)btnCheckDiet:(id)sender;


@end
