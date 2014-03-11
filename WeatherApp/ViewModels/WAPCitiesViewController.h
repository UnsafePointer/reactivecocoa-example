//
//  WAPCitiesViewController.h
//  WeatherApp
//
//  Created by Renzo Crisostomo on 11/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WAPCitiesViewModel;

@interface WAPCitiesViewController : UITableViewController

@property (nonatomic, strong) WAPCitiesViewModel *viewModel;

@end
