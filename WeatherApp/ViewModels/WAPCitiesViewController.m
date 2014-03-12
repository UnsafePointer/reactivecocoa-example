//
//  WAPCitiesViewController.m
//  WeatherApp
//
//  Created by Renzo Crisostomo on 11/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import "WAPCitiesViewController.h"
#import "WAPCitiesViewModel.h"
#import "WAPCityCell.h"
#import "WAPStationsViewModel.h"
#import "WAPStationsViewController.h"

@interface WAPCitiesViewController ()

@end

@implementation WAPCitiesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @weakify(self);
    [RACObserve(self.viewModel, model) subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"StationSegue"]) {
        NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
        WAPCityModel *city = self.viewModel.model[selectedIndexPath.row];
        WAPStationsViewModel *stationsViewModel = [[WAPStationsViewModel alloc] initWithCity:city];
        WAPStationsViewController *destination = [segue destinationViewController];
        destination.viewModel = stationsViewModel;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.viewModel.active = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.viewModel.active = NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.model.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CityCell";
    WAPCityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                        forIndexPath:indexPath];
    cell.cityModel = self.viewModel.model[indexPath.row];
    return cell;
}

@end
