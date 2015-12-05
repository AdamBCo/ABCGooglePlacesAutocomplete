//
//  PXFGoogleAutoCompleteResult.m
//  ABCGooglePlacesAutoComplete
//
//  Created by Adam Cooper on 12/5/15.
//  Copyright © 2015 Adam Cooper. All rights reserved.
//

#import "ABCGoogleAutoCompleteResult.h"

@implementation ABCGoogleAutoCompleteResult {
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
    if([_jsonDictionary[@"terms"] objectAtIndex:0][@"value"] != [NSNull null]){
        name = [_jsonDictionary[@"terms"] objectAtIndex:0][@"value"];
    }
    return name;
}

-(NSString *)description {
    NSString *description = [NSString new];
    if(_jsonDictionary[@"description"] != [NSNull null]){
        description = _jsonDictionary[@"description"];
    }
    return description;
}

-(NSString *)placeID {
    NSString *placeID = [NSString new];
    if(_jsonDictionary[@"place_id"] != [NSNull null]){
        placeID = _jsonDictionary[@"place_id"];
    }
    return placeID;
}


@end
