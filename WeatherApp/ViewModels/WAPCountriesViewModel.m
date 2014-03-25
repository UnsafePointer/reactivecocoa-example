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

@property (nonatomic, strong, readwrite) NSArray *model;
@property (nonatomic, strong, readwrite) RACCommand *loadCountriesCommand;

@end

@implementation WAPCountriesViewModel
{
}

#pragma mark - Public Methods

- (id)init {
    if (self = [super init]) {
        self.loadCountriesCommand = [[RACCommand alloc] initWithSignalBlock:^(id value) {
            return [[[WAPWeatherAPIHelper getCountries] logError] catchTo:[RACSignal empty]];
        }];
        RAC(self, model) = [self.loadCountriesCommand.executionSignals switchToLatest];
    }
    return self;
}

@end
