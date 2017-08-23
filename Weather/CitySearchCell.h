//
//  CitySearchCell.h
//  Weather
//
//  Created by Shaun on 23/08/2017.
//  Copyright © 2017 Shaun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitySearchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *WeatherLabel;
@property (weak, nonatomic) IBOutlet UIImageView *WeatherIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *CityNameLabelView;
@property (weak, nonatomic) IBOutlet UILabel *CountryNameLabelView;

- (void)setCity:(NSString *)city Country:(NSString *)country andIcon:(UIImage *)img;

@end
