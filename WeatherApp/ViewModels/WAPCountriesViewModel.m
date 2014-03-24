//
//  WAPCitiesViewModel.m
//  WeatherApp
//
//  Created by Renzo Crisostomo on 10/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import "WAPCountriesViewModel.h"
#import "WAPWeatherAPIHelper.h"

@interface WAPCountriesViewModel ()

@end

@implementation WAPCountriesViewModel
{
}

#pragma mark - Public Methods

- (id)init {
    if (self = [super init]) {
        RAC(self, model) = [self getCountriesSignal];
    }
    return self;
}

#pragma mark - Private Methods

- (RACSignal *)getCountriesSignal
{
    return [[[WAPWeatherAPIHelper getCountries] logError] catchTo:[RACSignal empty]];
}

@end
