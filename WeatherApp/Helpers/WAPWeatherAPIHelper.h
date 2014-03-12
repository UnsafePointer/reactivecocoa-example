//
//  WAPWeatherAPIHelper.h
//  WeatherApp
//
//  Created by Renzo Crisostomo on 10/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WAPCountryModel;
@class WAPCityModel;

@interface WAPWeatherAPIHelper : NSObject

+ (RACSignal *)getCountries;
+ (RACSignal *)getCitiesWithCountry:(WAPCountryModel *)country;
+ (RACSignal *)getStationsWithCity:(WAPCityModel *)city;

@end
