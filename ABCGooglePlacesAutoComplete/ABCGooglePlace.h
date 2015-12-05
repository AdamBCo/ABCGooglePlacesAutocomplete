//
//  ABCGooglePlace.h
//  ABCGooglePlacesAutoComplete
//
//  Created by Adam Cooper on 12/5/15.
//  Copyright © 2015 Adam Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ABCGooglePlace : NSObject

@property (readonly) NSString *name;
@property (readonly) CLLocation *location;
@property (readonly) NSString *formatted_address;

-(instancetype)initWithJSONData:(NSDictionary *)jsonDictionary;

@end
