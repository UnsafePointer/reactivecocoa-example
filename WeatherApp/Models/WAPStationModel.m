//
//  WAPStationModel.m
//  WeatherApp
//
//  Created by Renzo Crisostomo on 12/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import "WAPStationModel.h"

@implementation WAPStationModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"name" : @"name",
             @"temp" : @"main.temp",
             @"pressure" : @"main.pressure",
             @"humidity" : @"main.humidity"
             };
}

@end
