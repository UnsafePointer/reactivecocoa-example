//
//  WAPCitiesViewModel.h
//  WeatherApp
//
//  Created by Renzo Crisostomo on 11/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WAPCountryModel;

@interface WAPCitiesViewModel : RVMViewModel

@property (nonatomic, strong, readonly) NSArray *model;
@property (nonatomic, strong, readonly) RACCommand *loadCitiesCommand;

- (id)initWithCountry:(WAPCountryModel *)country;

@end
