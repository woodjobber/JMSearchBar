//
//  JMTableView.h
//  JMSearchBarDemo
//
//  Created by chengbin on 16/6/29.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMTableView;
@protocol JMTableViewDelegate <UITableViewDelegate>

@optional
- (void)jm_tableViewWillReloadData:(JMTableView *)tableView;
- (void)jm_tableViewDidReloadData:(JMTableView *)tableView;

@end

@interface JMTableView : UITableView

@property (weak, nonatomic) id <JMTableViewDelegate>delegate;

- (void)beginOrEndUpdatesWithAnimations:(void (^)(void))animations completion:(void(^)(void))completion;

@end
