//
//  MainTabBarController.h
//  Weather
//
//  Created by Shaun on 23/08/2017.
//  Copyright © 2017 Shaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "ForecastViewController.h"

@interface MainTabBarController : UITabBarController

- (void)addNewCity:(NSDictionary *)data;

@end
