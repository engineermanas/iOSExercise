//
//  TableViewController.m
//  iOSExercise
//
//  Created by Manasa Parida on 31/12/14.
//  Copyright (c) 2014 Manas Parida. All rights reserved.
//

#import "TableViewController.h"
#import "RowsClass.h"
#import "Contsant.h"
#import "TableCustomCell.h"

@interface TableViewController ()
{
    UIAlertView *alertPopUp;
    WebServiceHandler *serviceHandler;
    NSMutableArray *mutblArrayData;
    UIActivityIndicatorView *actIndiView;
}

@end


@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    actIndiView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(140, 180, 50, 50)];
    actIndiView.backgroundColor = [UIColor lightGrayColor];
    [actIndiView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [actIndiView startAnimating];
    [self.view addSubview:actIndiView];
    
    serviceHandler = [WebServiceHandler getInstance];
    [serviceHandler webServiceCallWithURL:ServiceEndPointURL withParameter:nil];
    serviceHandler.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark - WebServiceHandler Delegate

-(void)webServiceSuccessResponse:(NSDictionary*)successDictionary
{
    NSArray *rowsInfo = [successDictionary valueForKey:@"rows"];
    
    mutblArrayData = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary *localDictionary in rowsInfo)
    {
        RowsClass *rowData = [[RowsClass alloc] init];
        
        // Null check for title
        if(![[localDictionary valueForKey:@"title"] isKindOfClass:[NSNull class]]){
            rowData.title = [localDictionary valueForKey:@"title"];
        }else{
            rowData.title =@"";
        }
        
        // Null Check for description
        if(![[localDictionary valueForKey:@"description"] isKindOfClass:[NSNull class]]){
            rowData.description = [localDictionary valueForKey:@"description"];
        }else{
            rowData.description =@"";
        }
        
        // Null Check for imageHref
        if(![[localDictionary valueForKey:@"imageHref"] isKindOfClass:[NSNull class]]){
            rowData.imageHref = [localDictionary valueForKey:@"imageHref"];
        }else{
            rowData.imageHref =@"";
        }
        
        [mutblArrayData addObject:rowData];
        NSLog(@" Mutbl Array Data==>>%@",mutblArrayData);
        rowData = nil;
    }
    
    if (actIndiView.isAnimating)
        [actIndiView stopAnimating];
    [actIndiView removeFromSuperview];
    
    [self.tableView reloadData];
    
}
-(void)webServiceFailResponse:(NSDictionary*)failDictionary
{
    NSLog(@"Failure Response==>>%@",failDictionary);

}

#pragma mark
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return  17;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //RowsClass *dataList = [mutblArrayData objectAtIndex:indexPath.row];
    //CGSize textSize = [dataList.description sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(240, 20000) lineBreakMode: NSLineBreakByWordWrapping]; //Assuming your width is 240
    
    //float heightToAdd = MIN(textSize.height, 100.0f); //Some fix height is returned if height is small or change it to MAX(textSize.height, 150.0f); // whatever best fits for you
    
    //return heightToAdd;
    //CGSize titleSize = [self getContentSizeWithString:dataList.title WithFont:[UIFont boldSystemFontOfSize:10] withTextSize:CGSizeMake(150, FLT_MAX)];
    //CGSize descriptionSize = [self getContentSizeWithString:dataList.description WithFont:[UIFont boldSystemFontOfSize:10] withTextSize:CGSizeMake(250, FLT_MAX)];

    return 60;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [mutblArrayData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    TableCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = nil;
    if (cell == nil) {
        cell = [[[TableCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    RowsClass *dataList = [mutblArrayData objectAtIndex:indexPath.row];

    //CGSize titleSize = [self getContentSizeWithString:dataList.title WithFont:[UIFont boldSystemFontOfSize:15] withTextSize:CGSizeMake(150, FLT_MAX)];
    
    //CGSize descriptionSize = [self getContentSizeWithString:dataList.description WithFont:[UIFont boldSystemFontOfSize:10] withTextSize:CGSizeMake(250, FLT_MAX)];
    //CGRect contentRect = self.view.bounds;
    //CGFloat boundX = contentRect.origin.x;
    //CGFloat boundY = contentRect.origin.y;
    
    cell.title.frame = CGRectMake(10, 2, 180,15);
    //cell.title.backgroundColor = [UIColor greenColor];
    cell.title.textColor = [UIColor blueColor];
    cell.title.text = dataList.title;
    
    cell.description.frame = CGRectMake(10, 19, 200, 25);
    //cell.description.backgroundColor = [UIColor blueColor];
    cell.title.textColor = [UIColor blackColor];
    cell.description.text = dataList.description;
    
    cell.iconImage.frame = CGRectMake(210, 19, 95, 60);
    cell.iconImage.image = [UIImage imageNamed:@"StaticiCon.png"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void) dealloc
{
    [super dealloc];
    [WebServiceHandler releaseInstance];
}

- (CGSize)getContentSizeWithString:(NSString*)currentText WithFont:(UIFont *)fontSize withTextSize:(CGSize)textSize
{
    CGSize returnTextSize = [currentText sizeWithFont:fontSize constrainedToSize:textSize lineBreakMode:NSLineBreakByWordWrapping];
    
    return returnTextSize;
}

@end
