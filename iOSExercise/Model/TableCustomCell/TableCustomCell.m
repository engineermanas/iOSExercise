//
//  StoreCustomCell.m
//  iOSExercise
//
//  Created by Manasa Parida on 02/01/15.
//  Copyright (c) 2014 Manas Parida. All rights reserved.
//

#import "TableCustomCell.h"
#import "Contsant.h"

@implementation TableCustomCell

@synthesize title,description,iconImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
        title = [[UILabel alloc]init];
        title.font = [UIFont fontWithName:FontNameHelveticaBold size:15];
        title.numberOfLines = 2;
        title.lineBreakMode = NSLineBreakByWordWrapping;
        title.textAlignment = NSTextAlignmentLeft;
        title.textColor = CellTitleColor;
        
        description = [[UILabel alloc]init];
        description.font = [UIFont fontWithName:FontNameHelvetica size:12];
        description.numberOfLines = 10;
        title.lineBreakMode = NSLineBreakByWordWrapping;
        description.textAlignment = NSTextAlignmentLeft;
        description.textColor = [UIColor blackColor];
        
        iconImage = [[UIImageView alloc]init];

        [self.contentView addSubview:title];
        [self.contentView addSubview:description];
        [self.contentView addSubview:iconImage];
    }
    return self;
}
 
- (void)layoutSubviews 
{
    [super layoutSubviews];
}

- (void)dealloc {
    
    [title release];
    [description release];
    [iconImage release];
    [super dealloc];
}

@end
