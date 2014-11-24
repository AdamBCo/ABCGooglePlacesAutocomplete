//
//  SelectedLocation.h
//  GooglePlacesAutocomplete
//
//  Created by Adam Cooper on 11/3/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface SelectedLocation : NSObject
@property NSString *name;
@property NSString *address;
@property CLLocationCoordinate2D locationCoordinates;

@end
