//
//  CitySearchCell.m
//  Weather
//
//  Created by Shaun on 23/08/2017.
//  Copyright © 2017 Shaun. All rights reserved.
//

#import "CitySearchCell.h"

@implementation CitySearchCell

- (void)setCity:(NSString *)city Country:(NSString *)country andIcon:(UIImage *)img
{
    [_CityNameLabelView setText:city];
    [_CountryNameLabelView setText:country];
    [_WeatherIconImageView setImage:img];
}

@end
