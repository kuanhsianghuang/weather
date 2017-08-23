//
//  ForecastViewController.m
//  Weather
//
//  Created by Shaun on 23/08/2017.
//  Copyright © 2017 Shaun. All rights reserved.
//

#import "ForecastViewController.h"
#import "ForecastCell.h"

BOOL isCelcius;

@implementation ForecastViewController


- (void)viewDidLoad
{    
    @try
    {
        NSString *imgId = [[[_cityDictionary objectForKey:STR_WEATHER] objectAtIndex:0] objectForKey:STR_ICON];
        UIImage *img = [NetDataDispatcher getIconForId:imgId];
        if(img)
        {
            [_CurrentWeatherIcon setImage:img];
        }
    }
    @catch (NSException *exception) {
        DLog(@"Icon Load Error %@ %@", exception.name, exception.description);
    }
    
    [_CityLabel setText:[_cityDictionary stringForKey:STR_NAME]];
    [_TabBarItem setTitle:_CityLabel.text];
    [_CountryLabel setText:[_cityDictionary stringForKeys:@[STR_SYS, STR_COUNTRY]]];
    [_StationIdLabel setText:[[_cityDictionary numberForKey:STR_ID] stringValue]];
    
    [self changeTempUnit:self];
    
    NSDictionary *dict = [_cityDictionary objectForKey:STR_WIND];
    [_WindSpeedLabel setText:[self stringForWindSpeed:[dict numberForKey:STR_SPEED]]];
    [_WindDirectionLabel setText:[self getWindDirection:[dict numberForKey:STR_DEG]]];
}

- (void)viewDidAppear:(BOOL)animated
{
    _Spinner.hidden = NO;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        self.forecastDictionary = [NetDataDispatcher getWeatherForId:[self.cityDictionary numberForKey:STR_ID]];
        self.forecastList = [_forecastDictionary objectForKey:STR_LIST];
        dispatch_async(dispatch_get_main_queue(), ^{
            _ForeCastTableView.dataSource = self;
            [_ForeCastTableView reloadData];
            _Spinner.hidden = YES;
            
        });
    });
    
}

- (NSString *)getTemperatureString:(NSNumber *)tempNumber
{
    double tempDouble = [tempNumber doubleValue];
    
    if(isCelcius) {
        tempDouble -= 273.15;
    }
    else{
        tempDouble = tempDouble *9 / 5 - 459.67;
    }
    
    return [NSString stringWithFormat:@"%.0lf", tempDouble];
}

/*
 Truncate the degrees into something that can be indexed to avoid nested if-else of doom
 N	NE	E	SE	S	SW	W	NW
 337.5	22.5	67.5	112.5	157.5	202.5	247.5	292.5
 22.5	67.5	112.5	157.5	202.5	247.5	292.5	337.5
 15	1	3	5	7	9	11	13
 1	3	5	7	9	11	13	15
 7.5	0.5	1.5	2.5	3.5	4.5	5.5	6.5
 0.5	1.5	2.5	3.5	4.5	5.5	6.5	7.5
 8	1	2	3	4	5	6	7
 1	2	3	4	5	6	7	8
 */

static NSString *const directions[] = {@"N", @"NE", @"E", @"SE", @"S", @"SW", @"W", @"NW", @"N"};

- (NSString *)getWindDirection:(NSNumber *)degree
{
    double d = [degree doubleValue] / 45 + 0.5;//22.5 /2 + 0.5;
    
    return directions[(int)d];
}

- (NSString *)stringForWindSpeed:(NSNumber *)speed
{
    return [NSString stringWithFormat:@"%.2lf", speed.doubleValue];
}

- (IBAction)changeTempUnit:(id)sender
{
    isCelcius = (_TempUnit.selectedSegmentIndex == 0);
    
    [_TempHighLabel setText:[self getTemperatureString:[_cityDictionary numberForKeys:@[STR_MAIN, STR_TEMP_MAX]]]];
    [_TempLowLabel setText:[self getTemperatureString:[_cityDictionary numberForKeys:@[STR_MAIN, STR_TEMP_MIN]]]];
    
    [_ForeCastTableView reloadData];    
}

- (IBAction)closeView:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Remove City"
                                                                   message:@"Remove this city from your forecast report?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* removeAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault                                                          handler:^(UIAlertAction * action)
    {
        NSMutableArray *tabs = [[NSMutableArray alloc] initWithArray:self.tabBarController.viewControllers];
        [tabs removeObjectAtIndex:self.tabBarController.selectedIndex];
        self.tabBarController.viewControllers = tabs;
        self.tabBarController.selectedIndex--;
    }];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault                                                       handler:nil];
    
    [alert addAction:defaultAction];
    [alert addAction:removeAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_forecastList)
    {
        return [_forecastList count];
    }
    else
    {
    	return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ForecastCell";
    ForecastCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dict = [_forecastList objectAtIndex:indexPath.row];
    
    NSDictionary *weatherDict = [[dict objectForKey:STR_WEATHER] objectAtIndex:0];
    cell.WeatherIconView.hidden = YES;
    cell.WeatherLabel.hidden = NO;
    [cell.WeatherLabel setText:[weatherDict stringForKey:STR_MAIN]];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        UIImage *img = [NetDataDispatcher getIconForId:[weatherDict objectForKey:STR_ICON]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.WeatherIconView setImage:img];
            cell.WeatherIconView.hidden = NO;
            cell.WeatherLabel.hidden = YES;
        });
    });
    
    NSString *dateString = [dict stringForKey:STR_DT_TXT];
    
    if(!dateString) // some cities don't return dt_txt, but since we don't know the timezone of each city... just gonna wing it with GMT
    {
    	NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[dict numberForKey:STR_DT] doubleValue]];
        dateString = [NSDateFormatter localizedStringFromDate:date
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
    }
    [cell.TimeLabel setText:dateString];
    
    
    
    
    // some cities dont' return the temperature in a "main" container but in "temp" instead
    NSNumber *maxTemp = [dict numberForKeys:@[STR_MAIN, STR_TEMP_MAX]];
    NSNumber *minTemp;
    if(maxTemp)
    {
        minTemp = [dict numberForKeys:@[STR_MAIN, STR_TEMP_MIN]];
    }
    else
    {
        maxTemp = [dict numberForKeys:@[STR_TEMP, STR_MAX]];
        minTemp = [dict numberForKeys:@[STR_TEMP, STR_MIN]];
    }
    [cell.TempHighLabel setText:[self getTemperatureString:maxTemp]];
    [cell.TempLowLabel setText:[self getTemperatureString:minTemp]];
    
    
    // some cities don't return wind dictionary like Melbourne AU
    NSDictionary *windDict = [dict objectForKey:STR_WIND];
    NSNumber *spd = [windDict numberForKey:STR_SPEED];
    NSNumber *deg = [windDict numberForKey:STR_DEG];
    if(!spd)
        spd = [dict numberForKey:STR_SPEED];
    if(!deg)
        deg = [dict numberForKey:STR_DEG];
    [cell.WindSpeedLabel setText:[self stringForWindSpeed:spd]];
    [cell.WindDirectionLabel setText:[self getWindDirection:deg]];
    
    return cell;
    
}

@end
