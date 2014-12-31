//
//  WebServiceHandler.m
//  iOSExercise
//
//  Created by Manasa Parida on 31/12/14.
//  Copyright (c) 2014 Manas Parida. All rights reserved.
//

#import "WebServiceHandler.h"

static WebServiceHandler *sharedInstance = nil;

@implementation WebServiceHandler


+ (WebServiceHandler *)getInstance
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


+(void)releaseInstance
{
    if(sharedInstance)
    {
        [sharedInstance release];
    }
    sharedInstance = nil;
}



- (void)webServiceCallWithURL:(NSString*)url withParameter:(id)parameter
{
    
}

@end
