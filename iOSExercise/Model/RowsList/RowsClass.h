//
//  RowsClass.h
//  iOSExercise
//
//  Created by Manasa Parida on 02/01/15.
//  Copyright (c) 2015 Manas Parida. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RowsClass : NSObject
{
    NSString *title;
    NSString *description;
    NSString *imageHref;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *imageHref;

@end
