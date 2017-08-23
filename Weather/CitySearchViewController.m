//
//  CitySearchViewController.m
//  Weather
//
//  Created by Shaun on 23/08/2017.
//  Copyright © 2017 Shaun. All rights reserved.
//

#import "CitySearchViewController.h"


@implementation CitySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _SearchResultTableView.hidden = YES;
    
    //[_NameEntryTextField setText:@"lala"];
    //[self textFieldShouldReturn:_NameEntryTextField];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
//- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *name = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""]; // remove space character
    
    if(name && name.length > 0)
    {
        _Spinner.hidden = NO;
        _SearchResultTableView.hidden = YES;
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            NSDictionary *data = [NetDataDispatcher getWeatherForCity:name];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(data)
                {
                    self.searchResultList = [data objectForKey:STR_LIST];
                    _SearchResultTableView.dataSource = self;
                    [_SearchResultTableView reloadData];
                    _SearchResultTableView.hidden = NO;
                }
                else
                {
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Sorry"
                                                                                   message:@"The Weather Database failed to return with valid data for that city.  Please try another city or try again later."
                                                                            preferredStyle:UIAlertControllerStyleAlert];
                    
                    
                    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault                                                       handler:nil];
                    
                    [alert addAction:defaultAction];
                    [self presentViewController:alert animated:YES completion:nil];
                }
                _Spinner.hidden = YES;
                
            });
        });
        
        
        
    }
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_searchResultList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CitySearchCellId";
    CitySearchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *cityData = [_searchResultList objectAtIndex:indexPath.row];
    
    [cell.CityNameLabelView setText:[cityData stringForKey:STR_NAME]];
    [cell.CountryNameLabelView setText:[cityData stringForKeys:@[STR_SYS, STR_COUNTRY]]];
    
    NSDictionary *weatherDict = [[cityData objectForKey:STR_WEATHER] objectAtIndex:0];
    [cell.WeatherLabel setText:[weatherDict stringForKey:STR_MAIN]];
    cell.WeatherLabel.hidden = NO;
    cell.WeatherIconImageView.hidden = YES;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *imgId = [weatherDict objectForKey:STR_ICON];
        UIImage *img = [NetDataDispatcher getIconForId:imgId];
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.WeatherIconImageView setImage:img];
            cell.WeatherLabel.hidden = YES;
            cell.WeatherIconImageView.hidden = NO;
        });
    });
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cityData = [_searchResultList objectAtIndex:indexPath.row];
    
    MainTabBarController *main = (MainTabBarController *) self.tabBarController;
    
    [main addNewCity:cityData];
}


@end
