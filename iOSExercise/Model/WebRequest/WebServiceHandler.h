//
//  WebServiceHandler.h
//  iOSExercise
//
//  Created by Manasa Parida on 31/12/14.
//  Copyright (c) 2014 Manas Parida. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebServiceHandlerDelegate <NSObject>

-(void)webServiceSuccessResponse:(id)success;
-(void)webServiceFailResponse:(id)fail;

@end

@interface WebServiceHandler : NSObject
{
    
}

// Delegate Instance for Communication purpose
@property (nonatomic, retain) id<WebServiceHandlerDelegate> delegate;

// Class Methods
+ (WebServiceHandler *)getInstance;
+(void)releaseInstance;


// Service Call related Services
- (void)webServiceCallWithURL:(NSString*)url withParameter:(id)parameter;

@end
