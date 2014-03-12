//
//  WAPStationModel.h
//  WeatherApp
//
//  Created by Renzo Crisostomo on 12/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAPStationModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSNumber *temp;
@property (nonatomic, copy, readonly) NSNumber *pressure;
@property (nonatomic, copy, readonly) NSNumber *humidity;

@end
