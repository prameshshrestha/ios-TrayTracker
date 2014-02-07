//
//  ScanInfo.h
//  TrayTracker
//
//  Created by pramesh on 12/4/13.
//  Copyright (c) 2013 pramesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScanInfo : NSObject{
    NSString *recordNumber_;
    NSDate *scanDate_;
}

@property (retain) NSString *recordNumber;
@property (retain) NSDate *scanDate;

- (NSString*)formatForDisplayInCell;
- (NSString*)formatForProcessor;

@end
