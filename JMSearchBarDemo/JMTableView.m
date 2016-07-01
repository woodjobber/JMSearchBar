

//
//  JMTableView.m
//  JMSearchBarDemo
//
//  Created by chengbin on 16/6/29.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "JMTableView.h"
struct Flags{
    bool delegateWillReloadData:true;
    bool delegateDidReloadData:true;
    bool reloading:true;
} ReloadFlags;

@interface JMTableView ()


@end

@implementation JMTableView
@dynamic delegate;

- (void)setDelegate:(id<JMTableViewDelegate>)delegate {
    [super setDelegate:delegate];
    ReloadFlags.delegateDidReloadData = [delegate respondsToSelector:@selector(jm_tableViewDidReloadData:)];
    ReloadFlags.delegateWillReloadData = [delegate respondsToSelector:@selector(jm_tableViewWillReloadData:)];
   
}

- (id<JMTableViewDelegate>)delegate {
    return (id<JMTableViewDelegate>)[super delegate];
}

- (void)reloadData {
    if (ReloadFlags.delegateWillReloadData) {
        [self.delegate jm_tableViewWillReloadData:self];
    }
    [super reloadData];
    [self layoutIfNeeded];
    if (ReloadFlags.reloading == false) {
        ReloadFlags.reloading = true;
        [self performSelector:@selector(finishReload) withObject:nil afterDelay:0.0f];
    }
}

- (void)finishReload {
    ReloadFlags.reloading = false;
    if (ReloadFlags.delegateDidReloadData) {
        [self.delegate jm_tableViewDidReloadData:self];
    }
}

- (void)beginOrEndUpdatesWithAnimations:(void (^)(void))animations completion:(void(^)(void))completion {
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self beginUpdates];
    {
        
    if (animations) {
        animations();
    }
        
    }
    [self endUpdates];
    [CATransaction commit];
}
@end
