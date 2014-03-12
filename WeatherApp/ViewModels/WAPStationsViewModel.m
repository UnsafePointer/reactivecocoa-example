//
//  WAPStationsViewModel.m
//  WeatherApp
//
//  Created by Renzo Crisostomo on 12/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import "WAPStationsViewModel.h"
#import "WAPWeatherAPIHelper.h"

@interface WAPStationsViewModel ()

- (RACSignal *)getStationsSignalWithCity:(WAPCityModel *)city;

@end

@implementation WAPStationsViewModel
{
}

#pragma mark - Public Methods

- (id)initWithCity:(WAPCityModel *)city;
{
    if (self = [super init]) {
        RAC(self, model) = [self getStationsSignalWithCity:city];
    }
    return self;
}

#pragma mark - Private Methods

- (RACSignal *)getStationsSignalWithCity:(WAPCityModel *)city
{
    return [[[WAPWeatherAPIHelper getStationsWithCity:city] logError] catchTo:[RACSignal empty]];
}

@end
