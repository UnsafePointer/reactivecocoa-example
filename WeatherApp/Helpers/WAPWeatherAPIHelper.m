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

@interface WAPWeatherAPIHelper ()

+ (NSURLRequest *)countriesURLRequest;
+ (RACSignal *)requestContryData;
+ (NSURLRequest *)citiesURLRequestWithCountry:(WAPCountryModel *)country;
+ (RACSignal *)requestCityDataWithCountry:(WAPCountryModel *)country;
+ (NSURLRequest *)stationsURLRequestWithCity:(WAPCityModel *)city;
+ (RACSignal *)requestStationsDataWithCity:(WAPCityModel *)city;

@end

@implementation WAPWeatherAPIHelper
{
}

#pragma mark - Private Methods

+ (NSURLRequest *)countriesURLRequest
{
    return [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.geonames.org/countryInfoJSON?username=WeatherApp"]];
}

+ (RACSignal *)requestContryData
{
    return [[NSURLConnection rac_sendAsynchronousRequest:[self countriesURLRequest]]
            reduceEach:^id(NSURLResponse *response, NSData *data){
                return data;
            }];
}

+ (NSURLRequest *)citiesURLRequestWithCountry:(WAPCountryModel *)country
{
    return [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.geonames.org/searchJSON?country=%@&username=WeatherApp", country.countryCode]]];
}

+ (RACSignal *)requestCityDataWithCountry:(WAPCountryModel *)country
{
    return [[NSURLConnection rac_sendAsynchronousRequest:[self citiesURLRequestWithCountry:country]]
            reduceEach:^id(NSURLResponse *response, NSData *data){
                return data;
            }];
}

+ (NSURLRequest *)stationsURLRequestWithCity:(WAPCityModel *)city
{
    return [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/find?lat=%.2f&lon=%.2f", [city.lat floatValue], [city.lng floatValue]]]];
}

+ (RACSignal *)requestStationsDataWithCity:(WAPCityModel *)city
{
    return [[NSURLConnection rac_sendAsynchronousRequest:[self stationsURLRequestWithCity:city]]
            reduceEach:^id(NSURLResponse *response, NSData *data){
                return data;
            }];
}

#pragma mark - Public Methods

+ (RACSignal *)getCountries
{
    return [[[[[self requestContryData] deliverOn:[RACScheduler mainThreadScheduler]]
              map:^id(NSData *data) {
                  NSError *error;
                  id results = [NSJSONSerialization JSONObjectWithData:data
                                                               options:0
                                                                 error:&error];
                  if (error) {
                      return [RACSignal error:error];
                  }
                  id countries = [WAPTranslatorHelper translateCollectionFromJSON:[results objectForKey:@"geonames"]
                                                                        withClass:[WAPCountryModel class]];
                  return countries;
              }]
             publish]
            autoconnect];
}

+ (RACSignal *)getCitiesWithCountry:(WAPCountryModel *)country
{
    return [[[[[self requestCityDataWithCountry:country] deliverOn:[RACScheduler mainThreadScheduler]]
            map:^id(NSData *data) {
                NSError *error;
                id results = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:&error];
                if (error) {
                    return [RACSignal error:error];
                }
                id cities = [WAPTranslatorHelper translateCollectionFromJSON:[results objectForKey:@"geonames"]
                                                                   withClass:[WAPCityModel class]];
                return cities;
            }]
             publish]
            autoconnect];
}

+ (RACSignal *)getStationsWithCity:(WAPCityModel *)city
{
    return [[[[[self requestStationsDataWithCity:city] deliverOn:[RACScheduler mainThreadScheduler]]
              map:^id(NSData *data) {
                  NSError *error;
                  id results = [NSJSONSerialization JSONObjectWithData:data
                                                               options:0
                                                                 error:&error];
                  if (error) {
                      return [RACSignal error:error];
                  }
                  id cities = [WAPTranslatorHelper translateCollectionFromJSON:[results objectForKey:@"list"]
                                                                     withClass:[WAPStationModel class]];
                  return cities;
              }]
             publish]
            autoconnect];
}

@end
