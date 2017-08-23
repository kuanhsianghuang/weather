//
//  DataCache.h
//  Weather
//
//  Created by Shaun on 23/08/2017.
//  Copyright © 2017 Shaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface DataCache:NSObject
+ (void) init;
+ (void) clear;
+ (void) saveCache;
+ (void) loadCache;

+ (NSDictionary *)getWeatherDataForId:(NSNumber *)cityId;
+ (void)setWeatherData:(NSDictionary *)data forKey:(NSNumber *)cityId;

+ (NSDictionary *)getCitySearchResult:(NSString *)name;
+ (void)setCitySearchResult:(NSDictionary *)data forKey:(NSString *)name;


+ (UIImage *)getIcon:(NSString *)iconId;
+ (void)setIcon:(UIImage *)img forKey:(NSString *)iconId;


@end
