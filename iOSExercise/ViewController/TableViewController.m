//
//  TableViewController.m
//  iOSExercise
//
//  Created by Manasa Parida on 02/01/15.
//  Copyright (c) 2014 Manas Parida. All rights reserved.
//

#import "TableViewController.h"
#import "RowsClass.h"
#import "Contsant.h"
#import "TableCustomCell.h"

@interface TableViewController ()
{
    UIAlertView* alertView;
    WebServiceHandler *serviceHandler;
    NSMutableArray *mutblArrayData;
    UIActivityIndicatorView *actIndiView;
}

@end


@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Refresh Button
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor purpleColor];
    [self.refreshControl addTarget:self
                            action:@selector(webServiceCall)
                  forControlEvents:UIControlEventValueChanged];
    
    // Activity Indicator
    actIndiView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(140, 180, 50, 50)];
    actIndiView.backgroundColor = [UIColor lightGrayColor];
    [actIndiView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [actIndiView startAnimating];
    [self.view addSubview:actIndiView];
    
    [self webServiceCall];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"Memory Warning Recieved");

}

-(void)webServiceCall
{
    // Service handler Instance to make
    serviceHandler = [WebServiceHandler getInstance];
    serviceHandler.delegate = self;
    [serviceHandler webServiceCallWithURL:ServiceEndPointURL withParameter:nil];

}
#pragma mark
#pragma mark - WebServiceHandler Delegate

-(void)webServiceSuccessResponse:(NSDictionary*)successDictionary
{
    NSArray *rowsInfo = [successDictionary valueForKey:RowKey];
    
    mutblArrayData = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary *localDictionary in rowsInfo)
    {
        RowsClass *rowData = [[RowsClass alloc] init];
        
        // Null check for title
        if(![[localDictionary valueForKey:TitleKey] isKindOfClass:[NSNull class]]){
            rowData.title = [localDictionary valueForKey:TitleKey];
        }else{
            rowData.title = NillString;
        }
        
        // Null Check for description
        if(![[localDictionary valueForKey:DescriptionKey] isKindOfClass:[NSNull class]]){
            rowData.description = [localDictionary valueForKey:DescriptionKey];
        }else{
            rowData.description = NillString;
        }
        
        // Null Check for imageHref
        if(![[localDictionary valueForKey:ImageHrefKey] isKindOfClass:[NSNull class]]){
            rowData.imageHref = [localDictionary valueForKey:ImageHrefKey];
        }else{
            rowData.imageHref = NillString;
        }
        // Add the final data to mutblArrayData
        [mutblArrayData addObject:rowData];
        rowData = nil;
    }
    
    if (actIndiView.isAnimating)
        [actIndiView stopAnimating];
    [actIndiView removeFromSuperview];
    [self.refreshControl endRefreshing];
    
    // Get the main queue to reload the tableview
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        self.navigationController.navigationBar.topItem.title = [successDictionary valueForKey:TitleKey];
    });
    
}
-(void)webServiceFailResponse:(NSDictionary*)failDictionary
{
    alertView = [[UIAlertView alloc] initWithTitle:AlertTitle message:[NSString stringWithFormat:@"%@",[failDictionary allKeys]] delegate:self cancelButtonTitle:AlertOptionsOk otherButtonTitles:nil];
    [alertView show];
    [alertView release];

}

#pragma mark
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

//-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return  17;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RowsClass *dataList = [mutblArrayData objectAtIndex:indexPath.row];
    CGSize descriptionSize = [self getContentSizeWithString:dataList.description WithFont:[UIFont boldSystemFontOfSize:12] withTextSize:CGSizeMake(190, FLT_MAX)];
    
    return descriptionSize.height+30;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [mutblArrayData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Cell indentifie Instance
    static NSString *CellIdentifier = TableCell;
    
    // Customizable Cell Instance which is going to use as ReusableCell
    TableCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Cell object validation if there or not
    if (cell == nil) {
        
        cell = [[[TableCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // Cell background color
        cell.backgroundColor = CellBackgroundColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Get the RowsClass instnce to set the Cell Index All Value
    RowsClass *dataList = [mutblArrayData objectAtIndex:indexPath.row];
    
    // Get the tittle and description content size dynamicaly to set the Frame Size
    CGSize titleSize = [self getContentSizeWithString:dataList.title WithFont:[UIFont boldSystemFontOfSize:15] withTextSize:TittleContentSize];
    CGSize descriptionSize = [self getContentSizeWithString:dataList.description WithFont:[UIFont boldSystemFontOfSize:12] withTextSize:DescriptionContentSize];
    
    // Set the title frame according to the content size width and height from titleSize
    cell.title.frame = TittleFrame;
    cell.title.text = dataList.title;
    
    // Set the description frame according to the content size width and height descriptionSize
    cell.description.frame = DescriptionFrame;
    cell.description.text = dataList.description;

    /************* Questions About Image Size ?? Dynamic or Static Size *************/
    // This check for setting the iconImage frame
    // if the description doesn't have data then also descriptionSize wil return the height
    // But the icon height we are calulating as per the descriptionSize height so that it will be dynamic as per the value returns from services
    // we can make it Static BUT we can also change the requirement
    
    if (descriptionSize.height <= 18)
    {
        cell.iconImage.frame = iConImageDefaultFrame;
    } else {
        cell.iconImage.frame = iConImageDynamicFrame;
    }
    cell.iconImage.contentMode = UIViewContentModeScaleAspectFill;
    cell.iconImage.clipsToBounds = YES;
    
    /**************** Table View Lazy Loading ***************/

    // Image download will happen on background so that main thread will not break the UI
    // When user will scroll the TableCell initialy it will display as Lazy Loading Concept
    // I set one placeholder image instead of blank screen
    // Once image download completed then cell icon image will display the original image which returns from service
    // if service returns nil or null then i am setting static image which is in resource bundle
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);
    dispatch_async(queue, ^{
        
        NSURL *imageURL = [NSURL URLWithString:dataList.imageHref];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        if (imageData) {
            
            // Once image download completed call the main queue to set the downloaded image
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                cell.iconImage.image = [UIImage imageWithData:imageData];
            });
        } else {
            // If there is no downloaded data set the default image as placeholder
            cell.iconImage.image = [UIImage imageNamed:LogoImageName];
        }
    });
    
    // Initial image loading from resource bundle
    cell.iconImage.image = [UIImage imageNamed:LogoImageName];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    alertView = [[UIAlertView alloc] initWithTitle:AlertTitle message:AlertBody delegate:self cancelButtonTitle:AlertOptionsOk otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

// Get the Content Size According to the Current Object, Font Size and the CGSize Value
- (CGSize)getContentSizeWithString:(NSString*)currentText WithFont:(UIFont *)fontSize withTextSize:(CGSize)textSize
{
    CGSize returnTextSize = [currentText sizeWithFont:fontSize constrainedToSize:textSize lineBreakMode:NSLineBreakByWordWrapping];
    
    return returnTextSize;
}

- (void) dealloc
{
    [super dealloc];
    [WebServiceHandler releaseInstance];
    [actIndiView release];
    [self.refreshControl release];
}

@end
