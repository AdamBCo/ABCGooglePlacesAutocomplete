//
//  SearchTableViewController.m
//  GooglePlacesAutocomplete
//
//  Created by Adam Cooper on 11/3/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//


#import "SearchTableViewController.h"

NSString *const apiURI = @"https://maps.googleapis.com/maps/api/place/autocomplete/output?parameters";
NSString *const apiKey = @"YOUR_API_KEY_GOES_HERE";

@interface SearchTableViewController () <UISearchBarDelegate>


@property (weak, nonatomic) IBOutlet UISearchBar *searchTextField;
@property NSMutableArray *savedSearchQueries;
@property NSMutableArray *googleSearchAutoCompletes;

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.googleSearchAutoCompletes = [NSMutableArray array];
    self.savedSearchQueries = [NSMutableArray array];
    self.searchTextField.delegate = self;


}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (![self.savedSearchQueries containsObject:self.searchTextField.text]) {
        [self.savedSearchQueries addObject:self.searchTextField.text];
    }
    [self.tableView reloadData];
}

- (void)searchAutocompleteLocationsWithSubstring:(NSString *)substring{
    [self.googleSearchAutoCompletes removeAllObjects];
    NSLog(@"Sub: %@", substring);

    [self retrieveGooglePlaceInformation:substring withCompletion:^(NSArray * results) {
        [self.googleSearchAutoCompletes addObjectsFromArray:results];
        [self.tableView reloadData];
    }];
    NSLog(@"Search numbers: %lu", (unsigned long)self.googleSearchAutoCompletes.count);

    for(NSString *pastSearch in self.googleSearchAutoCompletes) {
        NSRange substringRange = [pastSearch rangeOfString:substring];
        if (substringRange.location == 0) {
            [self.googleSearchAutoCompletes addObject:pastSearch];

        }
    }
}

#pragma mark UITextFieldDelegate methods

-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *substring = [NSString stringWithString:self.searchTextField.text];
    substring= [substring stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    substring = [substring stringByReplacingCharactersInRange:range withString:text];
    [self searchAutocompleteLocationsWithSubstring:substring];
    return YES;
}


#pragma mark - Google API Requests

-(void)retrieveGooglePlaceInformation:(NSString*)searchWord withCompletion:(void (^)(NSArray *))complete{

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=geocode&language=en&key=%@",searchWord,apiKey]];

    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLSessionDataTask *task = [delegateFreeSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *jSONresult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *results = [jSONresult valueForKey:@"predictions"];

        NSLog(@"We got %lu locations from google.",(unsigned long)results.count);
        complete(results);

    }];
    [task resume];

}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.googleSearchAutoCompletes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *searchResult = [self.googleSearchAutoCompletes objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
    cell.textLabel.text = [searchResult objectForKey:@"description"];

    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *footerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 500, 320, 70)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"powered-by-google-on-white"]];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    imageView.frame = CGRectMake(110,10,100,12);
    [footerView addSubview:imageView];

    self.tableView.tableFooterView = footerView;
    
    return footerView;
    
}



@end
