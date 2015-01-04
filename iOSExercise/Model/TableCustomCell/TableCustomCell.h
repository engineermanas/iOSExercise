//
//  StoreCustomCell.h
//  iOSExercise
//
//  Created by Manasa Parida on 02/01/15.
//  Copyright (c) 2014 Manas Parida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCustomCell : UITableViewCell
{
    UILabel *title;
    UILabel *description;
    UIImageView *iconImage;
}

@property(nonatomic,retain)UILabel *title;
@property(nonatomic,retain)UILabel *description;
@property(nonatomic,retain)UIImageView *iconImage;

@end
