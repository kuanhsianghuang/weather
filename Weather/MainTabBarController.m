//
//  MainTabBarController.m
//  Weather
//
//  Created by Shaun on 23/08/2017.
//  Copyright © 2017 Shaun. All rights reserved.
//

#import "MainTabBarController.h"
#import "DataCache.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [DataCache init];
    [DataCache loadCache];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [DataCache clear];
}


- (void)addNewCity:(NSDictionary *)data
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ForecastViewController *myController = [storyboard instantiateViewControllerWithIdentifier:@"ForeCastViewController"];
    myController.cityDictionary = data;
    
    NSMutableArray *tabs = [[NSMutableArray alloc] initWithArray:self.viewControllers];
    [tabs addObject:myController];
    self.viewControllers = tabs;
    self.selectedIndex = [tabs count]-1;
}


- (void)viewDidDisappear:(BOOL)animated
{
    [DataCache saveCache];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
