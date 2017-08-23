//
//  ForecastCell.h
//  Weather
//
//  Created by Shaun on 23/08/2017.
//  Copyright © 2017 Shaun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *WeatherLabel;
@property (weak, nonatomic) IBOutlet UIImageView *WeatherIconView;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *TempHighLabel;
@property (weak, nonatomic) IBOutlet UILabel *TempLowLabel;
@property (weak, nonatomic) IBOutlet UILabel *WindSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *WindDirectionLabel;

@end
