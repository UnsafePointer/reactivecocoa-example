//
//  WAPCountryCell.m
//  WeatherApp
//
//  Created by Renzo Crisostomo on 10/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import "WAPCountryCell.h"
#import "WAPCountryModel.h"

@implementation WAPCountryCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        RAC(self.textLabel, text) = [[RACObserve(self, countryModel) ignore:nil]
                                     map:^id(WAPCountryModel *countryModel) {
                                         return countryModel.countryName;
                                     }];
    }
    return self;
}

@end
