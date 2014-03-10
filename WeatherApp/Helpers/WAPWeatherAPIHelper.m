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

@interface WAPWeatherAPIHelper ()

+ (NSURLRequest *)countriesURLRequest;
+ (RACSignal *)requestContryData;

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

@end
