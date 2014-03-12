//
//  WAPWeatherAPIHelper.m
//  WeatherApp
//
//  Created by Renzo Crisostomo on 10/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import "WAPWeatherAPIHelper.h"
#import "WAPTranslatorHelper.h"
#import "WAPCountryModel.h"
#import "WAPCityModel.h"
#import "WAPStationModel.h"
#import "WAPRequestOperationConfigModel.h"
#import "Definitions.h"

@interface WAPWeatherAPIHelper ()

+ (AFHTTPRequestOperation *)createHTTPRequestOperationWithConfiguration:(RequestOperationConfigBlock)configuration;

@end

@implementation WAPWeatherAPIHelper
{
}

#pragma mark - Private Methods

+ (AFHTTPRequestOperation *)createHTTPRequestOperationWithConfiguration:(RequestOperationConfigBlock)configuration
{
    NSParameterAssert(configuration != nil);
    WAPRequestOperationConfigModel* requestOperationConfig = [[WAPRequestOperationConfigModel alloc] init];
    if (configuration) {
        configuration(requestOperationConfig);
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[requestOperationConfig URL]];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = requestOperationConfig.responseSerializer;
    return requestOperation;
}

#pragma mark - Public Methods

+ (RACSignal *)getCountries
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation *requestOperation = [WAPWeatherAPIHelper createHTTPRequestOperationWithConfiguration:^(WAPRequestOperationConfigModel *config) {
            config.URL = [NSURL URLWithString:@"http://api.geonames.org/countryInfoJSON?username=WeatherApp"];
            config.responseSerializer = [AFJSONResponseSerializer serializer];
        }];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *countries = [WAPTranslatorHelper translateCollectionFromJSON:[responseObject objectForKey:@"geonames"]
                                                                        withClass:[WAPCountryModel class]];
            [[RACSignal return:countries] subscribe:subscriber];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        [[NSOperationQueue mainQueue] addOperation:requestOperation];
        return [RACDisposable disposableWithBlock:^{
			[requestOperation cancel];
		}];
    }] replayLazily];
}

+ (RACSignal *)getCitiesWithCountry:(WAPCountryModel *)country
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation *requestOperation = [WAPWeatherAPIHelper createHTTPRequestOperationWithConfiguration:^(WAPRequestOperationConfigModel *config) {
            config.URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.geonames.org/searchJSON?country=%@&username=WeatherApp", country.countryCode]];
            config.responseSerializer = [AFJSONResponseSerializer serializer];
        }];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *countries = [WAPTranslatorHelper translateCollectionFromJSON:[responseObject objectForKey:@"geonames"]
                                                                        withClass:[WAPCityModel class]];
            [[RACSignal return:countries] subscribe:subscriber];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        [[NSOperationQueue mainQueue] addOperation:requestOperation];
        return [RACDisposable disposableWithBlock:^{
			[requestOperation cancel];
		}];
    }] replayLazily];
}

+ (RACSignal *)getStationsWithCity:(WAPCityModel *)city
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation *requestOperation = [WAPWeatherAPIHelper createHTTPRequestOperationWithConfiguration:^(WAPRequestOperationConfigModel *config) {
            config.URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/find?lat=%.2f&lon=%.2f", [city.lat floatValue], [city.lng floatValue]]];
            config.responseSerializer = [AFJSONResponseSerializer serializer];
        }];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *stations = [WAPTranslatorHelper translateCollectionFromJSON:[responseObject objectForKey:@"list"]
                                                                       withClass:[WAPStationModel class]];
            [[RACSignal return:stations] subscribe:subscriber];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        [[NSOperationQueue mainQueue] addOperation:requestOperation];
        return [RACDisposable disposableWithBlock:^{
			[requestOperation cancel];
		}];
    }] replayLazily];
}

@end
