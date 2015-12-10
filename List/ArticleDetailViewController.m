//
//  ArticleDetailViewController.m
//  List
//
//  Created by lemon on 15/12/9.
//  Copyright © 2015年 lemon. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import <MBProgressHUD.h>

@interface ArticleDetailViewController () <UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;

@end

@implementation ArticleDetailViewController
MBProgressHUD *HUD;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [self.view addSubview:webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(nonnull NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.labelText = @"加载中...";
    [HUD hide:YES afterDelay:2];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    HUD.labelText = @"加载完成";
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    HUD.labelText = @"加载失败";
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
