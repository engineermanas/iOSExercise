//
//  WebServiceHandler.m
//  iOSExercise
//
//  Created by Manasa Parida on 02/01/15.
//  Copyright (c) 2014 Manas Parida. All rights reserved.
//

#import "WebServiceHandler.h"
#import "Contsant.h"
#import "JSONKit.h"


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

- (void)webServiceCallWithURL:(NSString *)url withParameter:(id)parameter
{
    NSURL *serviceURL = [NSURL URLWithString:url];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:serviceURL];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    __block NSDictionary *jsonObject = nil;
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
        if ([data length] > 0 && error == nil)
        {
            NSString *stringResponse = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSData *convertToData = [stringResponse dataUsingEncoding:NSUTF8StringEncoding];
            jsonObject = [NSJSONSerialization JSONObjectWithData:convertToData options:0 error:&error];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(webServiceSuccessResponse:)])
                [self.delegate webServiceSuccessResponse:jsonObject];
        }
        else
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(webServiceSuccessResponse:)])
            [self.delegate webServiceFailResponse:jsonObject];
        }
    }];
}

/* - (void)webServiceCallWithURL:(NSString*)url withParameter:(id)parameter
{
    __block NSDictionary *jsonObject = nil;
    
    NSURL *serviceURL = [NSURL URLWithString:url];
    NSURLSessionDataTask *downloadDataTask = [[NSURLSession sharedSession]
                                              dataTaskWithURL:serviceURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                  
                                                  NSString *stringResponse = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                                  NSData *convertToData = [stringResponse dataUsingEncoding:NSUTF8StringEncoding];
                                                  jsonObject = [NSJSONSerialization JSONObjectWithData:convertToData options:0 error:&error];
                                                  
                                                  if (self.delegate && [self.delegate respondsToSelector:@selector(webServiceSuccessResponse:)])
                                                  {
                                                      [self.delegate webServiceSuccessResponse:jsonObject];
                                                  }
                                                  else
                                                  {
                                                      [self.delegate webServiceFailResponse:jsonObject];
                                                  }
                                                  
                                              }];
    [downloadDataTask resume];
    
 } */

@end
