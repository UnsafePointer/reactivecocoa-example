//
//  WAPCitiesViewController.m
//  WeatherApp
//
//  Created by Renzo Crisostomo on 10/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import "WAPCountriesViewController.h"
#import "WAPCountriesViewModel.h"
#import "WAPCountryCell.h"
#import "WAPCitiesViewController.h"
#import "WAPCitiesViewModel.h"

@interface WAPCountriesViewController ()

@property (nonatomic, strong) WAPCountriesViewModel *viewModel;

@end

@implementation WAPCountriesViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.viewModel = [[WAPCountriesViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @weakify(self);
    [[RACObserve(self.viewModel, model) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [[refreshControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
        @strongify(self);
        [[[self.viewModel getCountriesSignal] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSArray *cities) {
            self.viewModel.model = cities;
        } error:^(NSError *error) {
            @strongify(self);
            [[self refreshControl] endRefreshing];
        } completed:^{
            @strongify(self);
            [[self refreshControl] endRefreshing];
        }];
    }];
    [self setRefreshControl:refreshControl];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"CitySegue"]) {
        NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
        WAPCountryModel *country = self.viewModel.model[selectedIndexPath.row];
        WAPCitiesViewModel *citiesViewModel = [[WAPCitiesViewModel alloc] initWithCountry:country];
        WAPCitiesViewController *destination = [segue destinationViewController];
        destination.viewModel = citiesViewModel;
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
    static NSString *CellIdentifier = @"CountryCell";
    WAPCountryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                           forIndexPath:indexPath];
    cell.countryModel = self.viewModel.model[indexPath.row];
    return cell;
}

@end
