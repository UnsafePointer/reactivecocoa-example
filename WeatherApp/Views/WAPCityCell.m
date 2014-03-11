//
//  WAPCityCell.m
//  WeatherApp
//
//  Created by Renzo Crisostomo on 11/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import "WAPCityCell.h"
#import "WAPCityModel.h"

@implementation WAPCityCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        RAC(self.textLabel, text) = [[RACObserve(self, cityModel) ignore:nil]
                                     map:^id(WAPCityModel *cityModel) {
                                         return cityModel.name;
                                     }];
    }
    return self;
}

@end
