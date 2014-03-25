//
//  WAPStationsViewController.m
//  WeatherApp
//
//  Created by Renzo Crisostomo on 12/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import "WAPStationsViewController.h"
#import "WAPStationsViewModel.h"
#import "WAPStationCell.h"
#import "WAPStationDetailsViewController.h"

@interface WAPStationsViewController ()

@end

@implementation WAPStationsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @weakify(self);
    [RACObserve(self.viewModel, model) subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.rac_command = self.viewModel.loadStationsCommand;
    [self setRefreshControl:refreshControl];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"DetailsSegue"]) {
        NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
        WAPStationModel *station = self.viewModel.model[selectedIndexPath.row];
        WAPStationDetailsViewController *destination = [segue destinationViewController];
        destination.station = station;
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
    static NSString *CellIdentifier = @"StationCell";
    WAPStationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                           forIndexPath:indexPath];
    cell.stationModel = self.viewModel.model[indexPath.row];
    return cell;
}

@end
