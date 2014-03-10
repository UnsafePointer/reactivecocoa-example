//
//  WAPCountry.h
//  WeatherApp
//
//  Created by Renzo Crisostomo on 10/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import "MTLModel.h"

@interface WAPCountryModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *countryName;
@property (nonatomic, copy, readonly) NSString *countryCode;

@end
