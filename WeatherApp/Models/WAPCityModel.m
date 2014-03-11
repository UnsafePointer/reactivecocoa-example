//
//  WAPCityModel.m
//  WeatherApp
//
//  Created by Renzo Crisostomo on 11/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import "WAPCityModel.h"

@implementation WAPCityModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"name" : @"name",
             @"lat" : @"lat",
             @"lng" : @"lng"
             };
}

@end
