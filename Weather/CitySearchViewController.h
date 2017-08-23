//
//  CitySearchViewController.h
//  Weather
//
//  Created by Shaun on 23/08/2017.
//  Copyright © 2017 Shaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetDataDispatcher.h"
#import "Constants.h"
#import "CitySearchCell.h"
#import "NSDictionary+HelperCategory.h"
#import "MainTabBarController.h"

@interface CitySearchViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Spinner;
@property (weak, nonatomic) IBOutlet UITableView *SearchResultTableView;
@property (weak, nonatomic) IBOutlet UITextField *NameEntryTextField;
@property (weak, nonatomic) IBOutlet MainTabBarController *MainTabBar;
@property (strong, nonatomic) NSArray *searchResultList;

@end
