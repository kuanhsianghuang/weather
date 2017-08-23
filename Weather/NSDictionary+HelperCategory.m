//
//  NSDictionary+HelperCategory.m
//  Weather
//
//  Created by Shaun on 23/08/2017.
//  Copyright © 2017 Shaun. All rights reserved.
//

#import "NSDictionary+HelperCategory.h"

@implementation NSDictionary (HelperCategory)

- (NSNumber *) numberForKey:(NSString *)key
{
    return [self objectType:[NSNumber class] forKey:key];
}

- (NSString *) stringForKey:(NSString *)key
{
    return [self objectType:[NSString class] forKey:key];
}

- (id)objectType:(Class) c forKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    
    if([obj isKindOfClass:c])
        return obj;
    else
    	return nil;
}

- (NSString *) stringForKeys:(NSArray *)array
{
    return [self objectOfType:[NSString class] forKeys:array];
}

- (NSNumber *) numberForKeys:(NSArray *)array
{
    return [self objectOfType:[NSNumber class] forKeys:array];
}

- (id)objectOfType:(Class)c forKeys:(NSArray *)array
{
    if(array && [array count] > 0)
    {
        id dict = self;
        
        @try {
            
            for(NSString *key in array)
            {
                dict = [dict objectForKey:key];
            }
            
            if([dict isKindOfClass:c])
                return dict;
        }
        @catch (NSException *exception) {
            DLog(@"Dictionary Pathing Failed with %@: %@", [exception name], [exception  reason]);
        }
        
    }
    
    return nil;
}

@end
