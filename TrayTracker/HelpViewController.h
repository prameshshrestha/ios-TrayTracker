//
//  HelpViewController.h
//  TrayTracker
//
//  Created by pramesh on 12/16/13.
//  Copyright (c) 2013 pramesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsViewController.h"

@interface HelpViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)IBOutlet UITableView *myTableView;
@end
