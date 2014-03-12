//
//  WAPStationsViewModel.h
//  WeatherApp
//
//  Created by Renzo Crisostomo on 12/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WAPCityModel;

@interface WAPStationsViewModel : RVMViewModel

@property (nonatomic, readonly, strong) NSArray *model;

- (id)initWithCity:(WAPCityModel *)city;

@end
