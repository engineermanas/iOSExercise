//
//  TableViewController.m
//  iOSExercise
//
//  Created by Manasa Parida on 31/12/14.
//  Copyright (c) 2014 Manas Parida. All rights reserved.
//

#import "TableViewController.h"
#import "Contsant.h"

@interface TableViewController ()
{
    UIAlertView *alertPopUp;
    WebServiceHandler *serviceHandler;
}

@end


@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    serviceHandler = [WebServiceHandler getInstance];
    [serviceHandler webServiceCallWithURL:ServiceEndPointURL withParameter:nil];
    serviceHandler.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark - WebServiceHandler Delegate

-(void)webServiceSuccessResponse:(id)success
{
    alertPopUp = [[UIAlertView alloc] initWithTitle:@"JSON" message:[NSString stringWithFormat:@"%@",success] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertPopUp show];
}
-(void)webServiceFailResponse:(id)fail
{
    alertPopUp = [[UIAlertView alloc] initWithTitle:@"JSON" message:[NSString stringWithFormat:@"%@",fail] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertPopUp show];

}

#pragma mark
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
