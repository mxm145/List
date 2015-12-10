//
//  HYCell.m
//  List
//
//  Created by lemon on 15/12/1.
//  Copyright © 2015年 lemon. All rights reserved.
//

#import "HYCell.h"
#import "HYMenu.h"
#import <UIImageView+WebCache.h>

@interface HYCell ()
@property (weak, nonatomic) IBOutlet UIImageView *albums;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation HYCell

-(void) setMenu:(HYMenu *)menu{
    _menu = menu;
    [self.albums sd_setImageWithURL:[NSURL URLWithString:menu.albums]];
    self.title.text = menu.title;
    self.time.text = menu.time;
}

@end
