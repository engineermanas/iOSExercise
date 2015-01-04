//
//  Contsant.h
//  iOSExercise
//
//  Created by Manasa Parida on 02/01/15.
//  Copyright (c) 2014 Manas Parida. All rights reserved.
//

#define ServiceEndPointURL @"https://dl.dropboxusercontent.com/u/746330/facts.json"


#define  CellTitleColor [UIColor colorWithRed:58.0f/255.0f green:89.0f/255.0f blue:145.0f/255.0f alpha:1.0f]
#define  CellBackgroundColor [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]

#define  FontNameHelveticaBold   @"Helvetica-Bold"
#define  FontNameHelvetica       @"Helvetica"
#define  LogoImageName           @"Logo.png"
#define  TableCell               @"Cell"

#define TittleContentSize        CGSizeMake(300, FLT_MAX)
#define TittleFrame              CGRectMake(10, 2, titleSize.width,titleSize.height)
#define DescriptionContentSize   CGSizeMake(190, FLT_MAX)
#define DescriptionFrame         CGRectMake(10, titleSize.height+1, descriptionSize.width, descriptionSize.height)
#define iConImageDefaultFrame    CGRectMake(190+10, 17, 110, cell.bounds.size.height-cell.title.frame.size.height-3)
#define iConImageDynamicFrame    CGRectMake(190+10, 17, 110, descriptionSize.height)

#define NillString              @""
#define RowKey                  @"rows"
#define TitleKey                @"title"
#define DescriptionKey          @"description"
#define ImageHrefKey            @"imageHref"

#define AlertTitle              @"OOPS!!"
#define AlertBody               @"Sorry!! Work in Progress"
#define AlertOptionsOk          @"OK"