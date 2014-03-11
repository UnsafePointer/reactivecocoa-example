//
//  WAPCitiesViewModel.m
//  WeatherApp
//
//  Created by Renzo Crisostomo on 11/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import "WAPCitiesViewModel.h"
#import "WAPWeatherAPIHelper.h"
#import "WAPCountryModel.h"

@interface WAPCitiesViewModel ()

- (RACSignal *)getCitiesSignalWithCountry:(WAPCountryModel *)country;

@end

@implementation WAPCitiesViewModel
{
}

#pragma mark - Public Methods

- (id)initWithCountry:(WAPCountryModel *)country
{
    if (self = [super init]) {
        RAC(self, model) = [self getCitiesSignalWithCountry:country];
    }
    return self;
}

#pragma mark - Private Methods

- (RACSignal *)getCitiesSignalWithCountry:(WAPCountryModel *)country
{
    return [[[WAPWeatherAPIHelper getCitiesWithCountry:country] logError] catchTo:[RACSignal empty]];
}

@end
