//
//  TextEntryCell.m
//  SmartReceipts
//
//  Created by Jaanus Siim on 30/04/15.
//  Copyright (c) 2015 Will Baumann. All rights reserved.
//

#import "TextEntryCell.h"

@interface TextEntryCell ()

@property (nonatomic, strong) IBOutlet UITextField *entryField;

@end

@implementation TextEntryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
