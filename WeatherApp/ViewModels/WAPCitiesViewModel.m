//
//  WAPCitiesViewModel.m
//  WeatherApp
//
//  Created by Renzo Crisostomo on 11/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import "WAPCitiesViewModel.h"
#import "WAPWeatherAPIHelper.h"

@interface WAPCitiesViewModel ()

@property (nonatomic, strong, readwrite) NSArray *model;
@property (nonatomic, strong, readwrite) RACCommand *loadCitiesCommand;

@end

@implementation WAPCitiesViewModel
{
}

#pragma mark - Public Methods

- (id)initWithCountry:(WAPCountryModel *)country
{
    if (self = [super init]) {
        @weakify(self);
        self.loadCitiesCommand = [[RACCommand alloc] initWithSignalBlock:^(id value) {
            return [[[WAPWeatherAPIHelper getCitiesWithCountry:country] logError] catchTo:[RACSignal empty]];
        }];
        RAC(self, model) = [self.loadCitiesCommand.executionSignals switchToLatest];
        [[RACObserve(self, active) take:1] subscribeNext:^(id x) {
            @strongify(self);
            [self.loadCitiesCommand execute:nil];
        }];
    }
    return self;
}

@end
