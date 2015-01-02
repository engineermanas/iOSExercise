//
//  RowsClass.m
//  iOSExercise
//
//  Created by Manasa Parida on 02/01/15.
//  Copyright (c) 2015 Manas Parida. All rights reserved.
//

#import "RowsClass.h"

@implementation RowsClass

@synthesize title,description,imageHref;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        
        title = nil;
        description = nil;
        imageHref = nil;
    }
    
    return self;
}


- (void)dealloc {
    
    [super dealloc];
    [title release];
    [description release];
    [imageHref release];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    
}

@end
