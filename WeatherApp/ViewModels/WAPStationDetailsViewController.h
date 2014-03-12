//
//  WAPStationDetailsViewController.h
//  WeatherApp
//
//  Created by Renzo Crisostomo on 12/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WAPStationModel;

@interface WAPStationDetailsViewController : UITableViewController

@property (nonatomic, strong) WAPStationModel *station;

@property (nonatomic, weak) IBOutlet UILabel *lblTemperature;
@property (nonatomic, weak) IBOutlet UILabel *lblPressure;
@property (nonatomic, weak) IBOutlet UILabel *lblHumidity;

@end
