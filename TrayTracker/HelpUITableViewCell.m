//
//  HelpUITableViewCell.m
//  TrayTracker
//
//  Created by pramesh on 12/17/13.
//  Copyright (c) 2013 pramesh. All rights reserved.
//

#import "HelpUITableViewCell.h"

@implementation HelpUITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setLabelText:(NSString *)_text
{
    cellText.text = _text;
}
@end
