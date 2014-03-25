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

@property (nonatomic, strong, readwrite) NSArray *model;
@property (nonatomic, strong, readwrite) RACCommand *loadStationsCommand;

@end

@implementation WAPStationsViewModel
{
}

#pragma mark - Public Methods

- (id)initWithCity:(WAPCityModel *)city;
{
    if (self = [super init]) {
        @weakify(self);
        self.loadStationsCommand = [[RACCommand alloc] initWithSignalBlock:^(id value) {
            return [[[WAPWeatherAPIHelper getStationsWithCity:city] logError] catchTo:[RACSignal empty]];
        }];
        RAC(self, model) = [self.loadStationsCommand.executionSignals switchToLatest];
        [[RACObserve(self, active) take:1] subscribeNext:^(id x) {
            @strongify(self);
            [self.loadStationsCommand execute:nil];
        }];
    }
    return self;
}

@end
