//
//  RootTableViewController.m
//  List
//
//  Created by lemon on 15/12/31.
//  Copyright © 2015年 lemon. All rights reserved.
//

#import "RootTableViewController.h"
#import "HYCell.h"
#import "HYMenu.h"
#import <AFNetworking.h>
#import "MJExtension.h"
#import <MJRefresh.h>
#import "ArticleDetailViewController.h"
#import "HeaderImageView.h"
#import "UIImageView+WebCache.h"

@interface RootTableViewController ()
@property (strong, nonatomic) NSMutableArray<HYMenu *> *menus;
@property (weak, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) NSNumber *maxorder;
@property (nonatomic, assign) UIEdgeInsets insets;
@end

@implementation RootTableViewController

@synthesize id;

static NSString * const RequestUrl = @"http://接口地址";
static NSString * const RequestImageUrl = @"http://接口地址";
static NSString * const CellId = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.maxorder = [[NSNumber alloc] initWithDouble:0.0000];
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    self.insets = UIEdgeInsetsMake(0, 10, 0, 10);

    [self setupTable];
    [self setupHeaderImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidLayoutSubviews{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:self.insets];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:self.insets];
    }
}

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

-(void) setupHeaderImage{
    //[self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:id,@"category_id",@"0",@"since_id",@"5",@"count", nil];
    [self.manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
    [self.manager POST:RequestImageUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *news = [responseObject objectForKey:@"news"];
        NSMutableArray *imageArray = [[NSMutableArray alloc] init];
        NSMutableArray *titleArray = [[NSMutableArray alloc] init];
        NSMutableArray *urlArray = [[NSMutableArray alloc] init];
        for (NSDictionary *ob in news) {
            [imageArray addObject:[ob objectForKey:@"thumbnail"]];
            [titleArray addObject:[ob objectForKey:@"title"]];
            [urlArray addObject:[ob objectForKey:@"detail_url"]];
        }
        CGFloat W = [UIScreen mainScreen].bounds.size.width;
        HeaderImageView *imgView = [[HeaderImageView alloc] initWithFrame:CGRectMake(0, 0, W, 200)];
        imgView.imageArray = imageArray;
        imgView.titleArray = titleArray;
        imgView.autoScroll = YES;
        [imgView downloadFocusItem:^(id downloadItem, UIImageView *currentImageView) {
            [currentImageView sd_setImageWithURL:[NSURL URLWithString:downloadItem]];
        }];
        [imgView didSelectScrollFocusItem:^(NSInteger index) {
            //NSLog(@"click %ld",index);
            NSString *url = urlArray[index];
            [self pushView:url];
        }];
        self.tableView.tableHeaderView = imgView;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}

-(void) setupTable{
    self.tableView.rowHeight = 90;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HYCell class]) bundle:nil] forCellReuseIdentifier:CellId];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self loadData];
}

-(void) loadData{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"category_id"] = id;
    params[@"since_id"] = @"0";
    params[@"count"] = @"10";
    [self.manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
    [self.manager POST:RequestUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *news = [responseObject objectForKey:@"news"];
        [HYMenu mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"albums": @"thumbnail",
                     @"title": @"title",
                     @"time": @"time",
                     @"url": @"detail_url"
                     };
        }];
        for (NSDictionary *ob in news) {
            NSNumber *tmporder = [[NSNumber alloc] initWithDouble:[[ob objectForKey:@"listorder"] doubleValue]];
            if ([tmporder compare:self.maxorder] == NSOrderedDescending) {
                self.maxorder = tmporder;
            }
        }
        NSMutableArray *arr = [HYMenu mj_objectArrayWithKeyValuesArray:news];
        weakSelf.menus = arr;
        [self.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}

-(void) loadMoreData{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"category_id"] = @"93";
    params[@"max_id"] = self.maxorder;
    params[@"count"] = @"10";
    [self.manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
    [self.manager POST:RequestUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *news = [responseObject objectForKey:@"news"];
        [HYMenu mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"albums": @"thumbnail",
                     @"title": @"title",
                     @"time": @"time"
                     };
        }];
        for (NSDictionary *ob in news) {
            NSNumber *tmporder = [[NSNumber alloc] initWithDouble:[[ob objectForKey:@"listorder"] doubleValue]];
            if ([tmporder compare:self.maxorder] == NSOrderedAscending) {
                self.maxorder = tmporder;
            }
        }
        NSMutableArray *arr = [HYMenu mj_objectArrayWithKeyValuesArray:news];
        [weakSelf.menus addObjectsFromArray:arr];
        [self.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menus.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HYCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.menu = self.menus[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:self.insets];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:self.insets];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *url = self.menus[indexPath.row].url;
    [self pushView:url];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(void)pushView:(NSString *)url{
    ArticleDetailViewController *article = [[ArticleDetailViewController alloc] init];
    article.url = url;
    [self.navigationController pushViewController:article animated:YES];
}

@end
