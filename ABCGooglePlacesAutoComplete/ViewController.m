//
//  ViewController.m
//  ABCGooglePlacesAutoComplete
//
//  Created by Adam Cooper on 12/5/15.
//  Copyright © 2015 Adam Cooper. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"
#import "ABCGooglePlacesSearchViewController.h"

@interface ViewController () <ABCGooglePlacesSearchViewControllerDelegate>


@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *coordinatesLabel;


@property (nonatomic, strong) UIButton *startButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.startButton];
    
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.addressLabel];
    [self.view addSubview:self.coordinatesLabel];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ABCGooglePlacesSearchViewControllerDelegate Methods

-(void)searchViewController:(ABCGooglePlacesSearchViewController *)controller didReturnPlace:(ABCGooglePlace *)place {
    
    [self.nameLabel setText:place.name];
    [self.addressLabel setText:place.formatted_address];
    
    NSString *coordinatesString = [NSString stringWithFormat:@"(%f,%f)",place.location.coordinate.latitude, place.location.coordinate.longitude];
    [self.coordinatesLabel setText:coordinatesString];

}


#pragma mark - Actions

-(void)onStartButtonPressed:(UIButton *)sender {
    
    ABCGooglePlacesSearchViewController *searchViewController = [[ABCGooglePlacesSearchViewController alloc] init];
    [searchViewController setDelegate:self];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

#pragma mark - Properties

-(UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
        [_nameLabel setTextAlignment:NSTextAlignmentCenter];
        [_nameLabel setCenter:self.view.center];
        [_nameLabel setText:@"Location Name"];
    }
    return _nameLabel;
}

-(UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.nameLabel.bottom, self.view.width, 44)];
        [_addressLabel setTextAlignment:NSTextAlignmentCenter];
        [_addressLabel setText:@"Location Address"];
    }
    return _addressLabel;
}

-(UILabel *)coordinatesLabel {
    if (!_coordinatesLabel) {
        _coordinatesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.addressLabel.bottom, self.view.width, 44)];
        [_coordinatesLabel setTextAlignment:NSTextAlignmentCenter];
        [_coordinatesLabel setText:@"Location Coordinates"];
    }
    return _coordinatesLabel;
}


-(UIButton *)startButton {
    if (!_startButton) {
        _startButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height - 44, self.view.width, 44)];
        [_startButton setTitle:@"START" forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_startButton setBackgroundColor:[UIColor redColor]];
        [_startButton addTarget:self action:@selector(onStartButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

@end
