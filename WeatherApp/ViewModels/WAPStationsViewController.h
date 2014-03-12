//
//  WAPStationsViewController.h
//  WeatherApp
//
//  Created by Renzo Crisostomo on 12/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WAPStationsViewModel;

@interface WAPStationsViewController : UITableViewController

@property (nonatomic, strong) WAPStationsViewModel *viewModel;

@end
