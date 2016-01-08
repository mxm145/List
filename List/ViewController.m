//
//  ViewController.m
//  List
//
//  Created by lemon on 15/11/30.
//  Copyright © 2015年 lemon. All rights reserved.
//

#import "ViewController.h"
#import "RootTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(0, 0, 38, 38);
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"leftbar"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame = CGRectMake(0, 0, 38, 38);
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"rightbar"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(presentRightMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //self.navigationController.navigationBarHidden = YES;
    
    RootTableViewController *view = [[RootTableViewController alloc] init];
    view.id = [NSNumber numberWithChar:116];

    [self addChildViewController:view];
    [self.view addSubview:view.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
