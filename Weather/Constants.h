//
//  Constants.h
//  All constants that will be shared between view controllers.
//
//  Created by Shaun on 23/08/2017.
//  Copyright © 2017 Shaun. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DEBUG 1

#if DEBUG
	#define DLog(fmt,...) NSLog(fmt, ##__VA_ARGS__);
#else
	#define DLog(fmt,...)
#endif

@interface Constants : NSObject

extern NSString *const STR_TIME_STAMP;
extern NSString *const STR_ID;
extern NSString *const STR_DATA;

extern NSString *const STR_LIST;
extern NSString *const STR_MAIN;
extern NSString *const STR_TEMP;
extern NSString *const STR_TEMP_MIN;
extern NSString *const STR_TEMP_MAX;
extern NSString *const STR_MIN;
extern NSString *const STR_MAX;
extern NSString *const STR_ICON;
extern NSString *const STR_DESCRIPTION;
extern NSString *const STR_WIND;
extern NSString *const STR_SPEED;;
extern NSString *const STR_DEG;
extern NSString *const STR_CITY;
extern NSString *const STR_NAME;
extern NSString *const STR_SYS;
extern NSString *const STR_COUNTRY;
extern NSString *const STR_WEATHER;
extern NSString *const STR_DT;
extern NSString *const STR_DT_TXT;

extern NSTimeInterval CACHE_AGE_LIMIT;

@end
