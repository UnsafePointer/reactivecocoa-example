//
//  WAPTranslatorHelper.h
//  WeatherApp
//
//  Created by Renzo Crisostomo on 10/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAPTranslatorHelper : NSObject

+ (id)translateCollectionFromJSON:(NSDictionary *)JSON
                        withClass:(Class)modelClass;

@end
