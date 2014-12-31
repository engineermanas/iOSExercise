//
//  WebServiceHandler.m
//  iOSExercise
//
//  Created by Manasa Parida on 31/12/14.
//  Copyright (c) 2014 Manas Parida. All rights reserved.
//

#import "WebServiceHandler.h"
#import "Contsant.h"

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
    __block NSDictionary *currentObject = nil;
    
    NSURL *serviceURL = [NSURL URLWithString:url];
    
    /*********** start thread for check download ***********/
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURLSessionDataTask *downloadDataTask = [[NSURLSession sharedSession]
                                              dataTaskWithURL:serviceURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                  
                                                  NSString *stringResponse = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                                  currentObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                              }];
        [downloadDataTask resume];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(webServiceSuccessResponse:)])
            {
                [self.delegate webServiceSuccessResponse:currentObject];
            }
            else
            {
                [self.delegate webServiceFailResponse:currentObject];
            }

        });
    });
}

@end
