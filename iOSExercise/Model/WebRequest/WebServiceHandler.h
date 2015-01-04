//
//  WebServiceHandler.h
//  iOSExercise
//
//  Created by Manasa Parida on 02/01/15.
//  Copyright (c) 2014 Manas Parida. All rights reserved.
//

#import <Foundation/Foundation.h>

// Define the WebServiceHandlerDelegate
@protocol WebServiceHandlerDelegate <NSObject>

@required
-(void)webServiceSuccessResponse:(NSDictionary*)successDictionary;
-(void)webServiceFailResponse:(NSDictionary*)failDictionary;

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
