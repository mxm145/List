//
//  HYTabBarController.m
//  List
//
//  Created by lemon on 15/12/8.
//  Copyright © 2015年 lemon. All rights reserved.
//

#import "HYTabBarController.h"
#import "ViewController.h"
#import "SecondViewController.h"

@interface HYTabBarController ()

@end

@implementation HYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) initViewController{
    ViewController *view = [[ViewController alloc] init];
    [self setupViewController:view image:[UIImage imageNamed:@"tab_home_icon"] title:@"首页"];
    
    SecondViewController *secView = [[SecondViewController alloc] init];
    [self setupViewController:secView image:[UIImage imageNamed:@"user"] title:@"设置"];
}

-(void) setupViewController:(UIViewController *)viewController image:(UIImage *)image title:(NSString *)title{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    nav.title = title;
    nav.tabBarItem.image = image;
    //[nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"commentary_num_bg"] forBarMetrics:UIBarMetricsDefault];
    viewController.navigationItem.title = title;
    [self addChildViewController:nav];
}

@end
