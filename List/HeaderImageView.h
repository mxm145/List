//
//  HeaderImageView.h
//  List
//
//  Created by lemon on 15/12/11.
//  Copyright © 2015年 lemon. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DidSelectScrollFocusItem)(NSInteger index);
typedef void (^DownloadFocusItem)(id downloadItem,UIImageView *currentImageView);

@interface HeaderImageView : UIView<UIScrollViewDelegate>{
    DidSelectScrollFocusItem _didSelectScrollFocusItem;
    DownloadFocusItem _downloadFocusItem;
    NSInteger _currentPageIndex;
}

@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSArray *titleArray;
@property (assign, nonatomic) BOOL autoScroll;

-(void)didSelectScrollFocusItem:(DidSelectScrollFocusItem)didSelectScrollFocusItem;
-(void)downloadFocusItem:(DownloadFocusItem)downloadFocusItem;

@end
