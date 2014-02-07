//
//  TableCellView.h
//  TrayTracker
//
//  Created by pramesh on 12/17/13.
//  Copyright (c) 2013 pramesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCellView : UITableViewCell
{
    IBOutlet UILabel *cellText;
}
-(void)setLabelText:(NSString *)_text;
@end
