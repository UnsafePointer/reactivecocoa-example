//
//  WAPCityModel.h
//  WeatherApp
//
//  Created by Renzo Crisostomo on 11/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAPCityModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *lat;
@property (nonatomic, copy, readonly) NSString *lng;

@end
