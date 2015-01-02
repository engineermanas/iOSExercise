//
//  StoreCustomCell.h
//  iOSExercise
//
//  Created by MANAS PARIDA on 31/12/14.
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
