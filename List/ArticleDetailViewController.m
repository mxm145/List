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
@property NSNumber *stat;
@property (weak, nonatomic) MBProgressHUD *HUD;
@end

@implementation ArticleDetailViewController
//MBProgressHUD *HUD;

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
    if (self.stat == false) {
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.labelText = @"加载中...";
        
        self.stat = [[NSNumber alloc] initWithBool:YES];
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    if (webView.isLoading) {
        return;
    }
    self.HUD.labelText = @"加载完成";
    [self.HUD hide:YES afterDelay:0.5];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    self.HUD.labelText = @"加载失败";
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
