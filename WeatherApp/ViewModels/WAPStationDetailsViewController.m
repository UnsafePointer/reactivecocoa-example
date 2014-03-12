//
//  WAPStationDetailsViewController.m
//  WeatherApp
//
//  Created by Renzo Crisostomo on 12/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import "WAPStationDetailsViewController.h"
#import "WAPStationModel.h"

@interface WAPStationDetailsViewController ()

- (void)setupView;

@end

@implementation WAPStationDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Methods

- (void)setupView
{
    [[self lblHumidity] setText:[NSString stringWithFormat:@"%.1f %%", [_station.humidity floatValue]]];
    [[self lblPressure] setText:[NSString stringWithFormat:@"%.1f hpa", [_station.pressure floatValue]]];
    [[self lblTemperature] setText:[NSString stringWithFormat:@"%.1f °K", [_station.temp floatValue]]];
}

@end
