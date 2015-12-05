//
//  ResultsTableViewController.h
//  HotelTonightChallenge
//
//  Created by Adam Cooper on 3/17/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABCGooglePlace.h"

@class ABCGooglePlacesSearchViewController;

@protocol ABCGooglePlacesSearchViewControllerDelegate <NSObject>

-(void)searchViewController:(ABCGooglePlacesSearchViewController *)controller didReturnPlace:(ABCGooglePlace *)place;


@end

@interface ABCGooglePlacesSearchViewController : UIViewController

@property (nonatomic) id<ABCGooglePlacesSearchViewControllerDelegate> delegate;

@end
