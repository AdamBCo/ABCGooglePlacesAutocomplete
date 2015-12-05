//
//  ABCGooglePlace.m
//  ABCGooglePlacesAutoComplete
//
//  Created by Adam Cooper on 12/5/15.
//  Copyright © 2015 Adam Cooper. All rights reserved.
//

#import "ABCGooglePlace.h"

@implementation ABCGooglePlace {
    NSDictionary *_jsonDictionary;
}

-(instancetype)initWithJSONData:(NSDictionary *)jsonDictionary {
    self = [super init];
    if (self) {
        _jsonDictionary = jsonDictionary;
    }
    return self;
}

#pragma mark - Properties

-(NSString *)name{
    NSString *name = [NSString new];
    if(_jsonDictionary[@"name"] != [NSNull null]){
        name = _jsonDictionary[@"name"];
    }
    return name;
}

-(NSString *)formatted_address {
    NSString *description = [NSString new];
    if(_jsonDictionary[@"formatted_address"] != [NSNull null]){
        description = _jsonDictionary[@"formatted_address"];
    }
    return description;
}


-(CLLocation *)location {
    
    CLLocation *location = [[CLLocation alloc] init];
    if(_jsonDictionary[@"geometry"] != [NSNull null] && _jsonDictionary[@"geometry"][@"location"] != [NSNull null]){
        
        NSNumber *latitude = _jsonDictionary[@"geometry"][@"location"][@"lat"];
        NSNumber *longitude = _jsonDictionary[@"geometry"][@"location"][@"lng"];

        location = [[CLLocation alloc] initWithLatitude:latitude.doubleValue longitude:longitude.doubleValue];
    }
    return location;
    
}


@end
