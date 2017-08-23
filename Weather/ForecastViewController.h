//
//  ForecastViewController.h
//  Weather
//
//  Created by Shaun on 23/08/2017.
//  Copyright © 2017 Shaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "NetDataDispatcher.h"
#import "NSDictionary+HelperCategory.h"

@interface ForecastViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *CurrentWeatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *CityLabel;
@property (weak, nonatomic) IBOutlet UILabel *CountryLabel;
@property (weak, nonatomic) IBOutlet UILabel *StationIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *TempHighLabel;
@property (weak, nonatomic) IBOutlet UILabel *TempLowLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *TempUnit;
@property (weak, nonatomic) IBOutlet UILabel *WindSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *WindDirectionLabel;
@property (weak, nonatomic) IBOutlet UITableView *ForeCastTableView;
@property (weak, nonatomic) IBOutlet UITabBarItem *TabBarItem;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Spinner;

@property (strong, nonatomic) NSDictionary *cityDictionary;
@property (strong, nonatomic) NSDictionary *forecastDictionary;
@property (strong, nonatomic) NSArray *forecastList;

- (IBAction)closeView:(id)sender;
- (IBAction)changeTempUnit:(id)sender;

@end
