//
//  DataCache.m
//  Centralized data cache for easier management
//
//  Created by Shaun on 23/08/2017.
//  Copyright © 2017 Shaun. All rights reserved.
//

#import "DataCache.h"

static NSMutableDictionary *WeatherDataStatic;
static NSMutableDictionary *CitySearchDataStatic;
static NSMutableDictionary *IconDataStatic;


@implementation DataCache
+ (void) init
{
    if(!WeatherDataStatic)
    {
        WeatherDataStatic = [[NSMutableDictionary alloc] initWithCapacity:3];
    }
    
    if(!IconDataStatic)
    {
        IconDataStatic = [[NSMutableDictionary alloc] initWithCapacity:10];
    }
    
    if(!CitySearchDataStatic)
    {
        CitySearchDataStatic = [[NSMutableDictionary alloc] initWithCapacity:5];
    }
}

+ (void) clear
{
    [WeatherDataStatic removeAllObjects];
    [CitySearchDataStatic removeAllObjects];
    [IconDataStatic removeAllObjects];
}

+ (void) saveCache  
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:CitySearchDataStatic forKey:STR_CITY];
    [defaults setObject:WeatherDataStatic forKey:STR_MAIN];
    [defaults setObject:IconDataStatic forKey:STR_ICON];
    
    [defaults synchronize];
}

+ (void) loadCache
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    @autoreleasepool {
        [DataCache check:STR_CITY andAddTo:CitySearchDataStatic inDefault:defaults];
        [DataCache check:STR_MAIN andAddTo:WeatherDataStatic inDefault:defaults];
        [DataCache check:STR_ICON andAddTo:IconDataStatic inDefault:defaults];
    }
}

+ (void)check:(NSString *)key andAddTo:(NSMutableDictionary *)dict inDefault:(NSUserDefaults *)defaults
{
    NSDictionary *data = [defaults objectForKey:key];
    if(data)
    {
        [dict addEntriesFromDictionary:data];
    }
}

+ (NSDictionary *)getWeatherDataForId:(NSNumber *)cityId
{
    NSDictionary *data = [WeatherDataStatic objectForKey:cityId];
    
    NSDate *date = [data objectForKey:STR_TIME_STAMP];
    
    if([date timeIntervalSinceNow] > 0)
    {
        return data;
    }
    else
    {
    	return nil;
    }
}

+ (void)setWeatherData:(NSDictionary *)data forKey:(NSNumber *)cityId
{
    [WeatherDataStatic setObject:data forKey:cityId];
}


+ (NSDictionary *)getCitySearchResult:(NSString *)name
{
    NSDictionary *data = [CitySearchDataStatic objectForKey:name];
    
    NSDate *date = [data objectForKey:STR_TIME_STAMP];
    
    if([date timeIntervalSinceNow] > 0)
    {
        return data;
    }
    else
    {
        return nil;
    }
}

+ (void)setCitySearchResult:(NSDictionary *)data forKey:(NSString *)name
{
    if(data)
    {
    	[CitySearchDataStatic setObject:data forKey:name];
    }
}


+ (UIImage *)getIcon:(NSString *)iconId
{
    return [IconDataStatic objectForKey:iconId];
}

+ (void)setIcon:(UIImage *)img forKey:(NSString *)iconId
{
    if(img)
    {
    	[IconDataStatic setObject:img forKey:iconId];
    }
}


@end