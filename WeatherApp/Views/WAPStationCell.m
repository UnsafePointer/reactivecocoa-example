//
//  WAPStationCell.m
//  WeatherApp
//
//  Created by Renzo Crisostomo on 12/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import "WAPStationCell.h"
#import "WAPStationModel.h"

@implementation WAPStationCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        RAC(self.textLabel, text) = [[RACObserve(self, stationModel) ignore:nil]
                                     map:^id(WAPStationModel *stationModel) {
                                         return stationModel.name;
                                     }];
    }
    return self;
}

@end
