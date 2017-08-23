//
//  NetDataDispatcher.h
//  Weather
//
//  Created by Shaun on 23/08/2017.
//  Copyright © 2017 Shaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDictionary+HelperCategory.h"

@interface NetDataDispatcher : NSObject

+ (NSDictionary *)getWeatherForId:(NSNumber *)cityId;

+ (NSDictionary *)getWeatherForCity:(NSString *)cityName;

+ (UIImage *)getIconForId:(NSString *)iconId;

@end
