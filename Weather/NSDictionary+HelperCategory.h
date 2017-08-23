//
//  NSDictionary+HelperCategory.h
//  Weather
//
//  Created by Shaun on 23/08/2017.
//  Copyright © 2017 Shaun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface NSDictionary (HelperCategory)

- (NSNumber *) numberForKey:(NSString *)key;
- (NSString *) stringForKey:(NSString *)key;
- (NSNumber *) numberForKeys:(NSArray *)array;
- (NSString *) stringForKeys:(NSArray *)array;

@end
