//
//  WAPTranslatorHelper.m
//  WeatherApp
//
//  Created by Renzo Crisostomo on 10/03/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

#import "WAPTranslatorHelper.h"

@implementation WAPTranslatorHelper

+ (id)translateCollectionFromJSON:(NSDictionary *)JSON
                        withClass:(Class)modelClass
{
    NSParameterAssert(modelClass != nil);
    if ([JSON isKindOfClass:[NSArray class]]) {
        NSValueTransformer *valueTransformer = [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:modelClass];
        NSArray *collection = [valueTransformer transformedValue:JSON];
        return collection;
    }
    return nil;
}

@end
