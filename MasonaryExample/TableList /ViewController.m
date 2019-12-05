//
//  ViewController.m
//  MasonaryExample
//
//  Created by karthick on 12/05/19.
//  Copyright © 2019 karthick. All rights reserved.
//

#define MAS_SHORTHAND
#import "ViewController.h"
#import "PrefixHeader.pch"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *tableView;
    NSMutableArray *detailsArray;
    UIRefreshControl *refreshControl;
    UILabel *lblNodata;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self baseSetup];
    [self getAPIDetails];
}


   //TODO: refresh your data
- (void)refreshTable{
    [self getAPIDetails];
    [refreshControl endRefreshing];
    [tableView reloadData];
}

- (void)baseSetup {
    tableView = [UITableView new];
    tableView.backgroundColor = [UIColor clearColor];
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    tableView.allowsSelection = false;
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(@20);
    }];
    
    refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    if (@available(iOS 10.0, *)) {
        tableView.refreshControl = refreshControl;
    } else {
        [tableView addSubview:refreshControl];
    }
    
    [self setUpEmpty];
}

//Create noData label
-(void)setUpEmpty {
    
    lblNodata = [[UILabel alloc] init];
    lblNodata.tag = 200;
    lblNodata.numberOfLines = 2;
    lblNodata.textAlignment = NSTextAlignmentCenter;
    [lblNodata setHidden:true];
    lblNodata.textColor = [UIColor customThemeColor];
    [tableView addSubview:lblNodata];
    
    [lblNodata mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(@20);
    }];
    lblNodata.backgroundColor=[UIColor clearColor];
    lblNodata.textColor=[UIColor blackColor];
    lblNodata.font = [UIFont customEnglishTitleFont];
    lblNodata.text= @"No data found!. Please try Again or pull to refresh";
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
    return 1;
}

//TableView Row Count
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section {
    if ([detailsArray count] > 0 ) {
        [lblNodata setHidden:true];
        return [detailsArray count];
    } else {
        [lblNodata setHidden:false];
        return 0;
    }
}

//TableView Cell Height
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    // Similar to UITableViewCell, but
    UITableViewCell *cell = (UITableViewCell *)[theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    [[cell viewWithTag:100]removeFromSuperview];
    [[cell viewWithTag:200]removeFromSuperview];
    [[cell viewWithTag:300]removeFromSuperview];
    
    // Create Image View
    AsyncImageView *imageView = [[AsyncImageView alloc] init];
    imageView.tag = 100;
    imageView.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"imageHref"]objectAtIndex:indexPath.row]]];
    NSString *imgURL = [[detailsArray valueForKey:@"imageHref"]objectAtIndex:indexPath.row];
    imageView.image = [UIImage imageNamed:@"index.jpg"]; //Set Image PlaceHolder
    if ([GlobalClass isEmptyString:imgURL]){ //Image URL Empty
        imageView.image = [UIImage imageNamed:@"index.jpg"];
    } else {
        imageView.imageURL=[NSURL URLWithString:imgURL]; //Download image from URL
    }
    [cell addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@5);
        make.leading.equalTo(@10);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
        
    }];
    
    
    //Create Title label
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.tag = 200;
    lblTitle.numberOfLines = 2;
    
    [cell addSubview:lblTitle];
    
    [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_top).offset(10);
        make.leading.equalTo(imageView.mas_trailing).offset(10);
        //make.width.equalTo(@180);
        make.trailing.equalTo(@-10);
        make.height.equalTo(@30);
    }];
    lblTitle.backgroundColor=[UIColor clearColor];
    lblTitle.textColor = [UIColor customThemeColor];
    lblTitle.font = [UIFont customEnglishTitleFont];
    lblTitle.userInteractionEnabled=NO;
    
    NSString *titleStr = [[detailsArray valueForKey:@"title"]objectAtIndex:indexPath.row];
    if ([GlobalClass isEmptyString:titleStr]){ //Check Title Empty Or not
        lblTitle.text= @"Title";
    } else {
        lblTitle.text= titleStr;
    }
    
    //Create Descrption label
    UILabel *lblDescrption = [[UILabel alloc] init];
    lblDescrption.tag = 300;
    lblDescrption.numberOfLines = 0;
    lblDescrption.font = [UIFont customEnglishFontRegular16];
    [cell addSubview:lblDescrption];
    [lblDescrption mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblTitle.mas_bottom).mas_offset(0);
        make.leading.equalTo(lblTitle.mas_leading);
        //make.width.equalTo(@180);
        make.trailing.equalTo(@-10);
        make.height.greaterThanOrEqualTo(@60);
        make.bottom.equalTo(@-10);
    }];
    lblDescrption.backgroundColor=[UIColor clearColor];
    lblDescrption.textColor = [UIColor customThemeColor];
    lblDescrption.userInteractionEnabled=NO;
    [lblDescrption sizeToFit];
    NSString *descStr = [[detailsArray valueForKey:@"description"]objectAtIndex:indexPath.row];
    if ([GlobalClass isEmptyString:descStr]){ //Check description Empty Or not
        lblDescrption.text= @"Description";
    } else {
        lblDescrption.text= descStr;
    }
    
    return cell;
}

-(void)getAPIDetails{
    
    if ([GlobalClass networkConnectAvailable]){
        [GlobalClass showGlobalProgressHUDWithTitle:@"Please wait" controller:self.view];
        
        [[APICall sharedInstance]url:[NSString stringWithFormat:@"%@",deatilApi] user:@"" PostBody:nil method:@"GET" completion:^(NSDictionary *jsonDict){
            
            [GlobalClass dismissGlobalHUD:self.view];
            
            NSLog(@"dict = %@",jsonDict);
            self->detailsArray = [jsonDict objectForKey:@"rows"];
            self.title = [jsonDict valueForKey:@"title"];
            self->tableView.delegate = self;
            self->tableView.dataSource = self;
            [self->tableView reloadData];
        } error:^(NSString *errorStr) {
            
        }];
    }else{
        [GlobalClass showAlertwithtitle:@"Information" message:@"Please check your internetconnection" view:self];
    }
}

@end

