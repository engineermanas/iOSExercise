//
//  StoreCustomCell.m
//  iOSExercise
//
//  Created by MANAS PARIDA on 31/12/14.
//  Copyright (c) 2014 Manas Parida. All rights reserved.
//

#import "TableCustomCell.h"

@implementation TableCustomCell

@synthesize title,description,iconImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
        title = [[UILabel alloc]init];
        title.font = [UIFont fontWithName:@"Helvetica" size:15];
        title.lineBreakMode = NSLineBreakByWordWrapping;
        title.textAlignment = NSTextAlignmentLeft;
        title.textColor = [UIColor blackColor];
        title.backgroundColor = [UIColor clearColor];
        
        description = [[UILabel alloc]init];
        description.font = [UIFont fontWithName:@"Helvetica" size:10];
        title.lineBreakMode = NSLineBreakByWordWrapping;
        description.textAlignment = NSTextAlignmentLeft;
        description.textColor = [UIColor blackColor];
        description.backgroundColor = [UIColor clearColor];
        
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
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    frame= CGRectMake(boundsX+0,0,0,0);
    iconImage.frame = frame;
}

- (void)dealloc {
    
    [title release];
    [description release];
    [iconImage release];
    [super dealloc];
}

@end
