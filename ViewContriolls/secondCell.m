//
//  secondCell.m
//  CoreDataTest
//
//  Created by MacPro.com on 14-8-7.
//  Copyright (c) 2014年 lihongtao. All rights reserved.
//

#import "secondCell.h"

@implementation secondCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
