//
//  ScanInfo.m
//  TrayTracker
//
//  Created by pramesh on 12/4/13.
//  Copyright (c) 2013 pramesh. All rights reserved.
//

#import "ScanInfo.h"

@implementation ScanInfo

@synthesize recordNumber = recordNumber_;
@synthesize scanDate = scanDate_;

- (void)dealloc {
    //RELEASE_SAFELY(recordNumber_);
    //RELEASE_SAFELY(scanDate_);
    
}

- (id)init{
    self = [super init];
    if (self){
        // Initialization code goes here
    }
    return self;
}

- (NSString*)formatForDisplayInCell{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"M/d/yy h:mm:ss a";
    NSString *scanDate = [formatter stringFromDate:self.scanDate];
    
    return [NSString stringWithFormat:@"%@ -> %@", self.recordNumber, self.scanDate];
}

- (NSString*)formatForProcessor{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *scanDate = [formatter stringFromDate:self.scanDate];
    return [NSString stringWithFormat:@"%@|%@|", self.recordNumber, self.scanDate];
}
@end
