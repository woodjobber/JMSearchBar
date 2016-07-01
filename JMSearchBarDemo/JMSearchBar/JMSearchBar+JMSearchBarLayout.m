//
//  JMSearchBar+JMSearchBarLayout.m
//  JMSearchBarDemo
//
//  Created by chengbin on 16/6/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "JMSearchBar+JMSearchBarLayout.h"

@implementation JMSearchBar (JMSearchBarLayout)

- (void)jm_searchBarAutoLayout {
    UIView *superView = self.superview;
    if (!superView)return;
    [self jm_searchBarAddAutoLayoutConstraintToSuperView:superView];
}
- (void)jm_searchBarAddAutoLayoutConstraintToSuperView:(UIView *)superView {
    NSLayoutConstraint *viewLeft = [self jm_constraintToItem:superView attribute:NSLayoutAttributeLeading];
    NSLayoutConstraint *viewBottom = [self jm_constraintToItem:superView attribute:NSLayoutAttributeBottom];
    NSLayoutConstraint *viewRight = [self jm_constraintToItem:superView attribute:NSLayoutAttributeTrailing];
    NSLayoutConstraint *viewTop = [self jm_constraintToItem:superView attribute:NSLayoutAttributeTop];
    [superView addConstraints:@[viewLeft,viewBottom ,viewRight, viewTop]];
}

- (NSLayoutConstraint *)jm_constraintToItem:(id)item attribute:(NSLayoutAttribute)attr2 {
    return  [NSLayoutConstraint constraintWithItem:self
                                         attribute:attr2
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:item
                                         attribute:attr2
                                        multiplier:1
                                          constant:0];
}
- (NSLayoutConstraint *)jm_maskViewConstraintWithItem:(id)item1 toItem:(id)item2 attribute:(NSLayoutAttribute)attr2 {
    return  [NSLayoutConstraint constraintWithItem:item1
                                         attribute:attr2
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:item2
                                         attribute:attr2
                                        multiplier:1
                                          constant:0];
}

- (void)jm_searchBarAutoLayoutMaskView:(UIView *)maskView {
    UIView *superView = maskView.superview;
    if (!superView)return;
    NSLayoutConstraint *viewLeft = [self jm_maskViewConstraintWithItem:maskView toItem:superView attribute:NSLayoutAttributeLeading];
    NSLayoutConstraint *viewBottom = [self jm_maskViewConstraintWithItem:maskView toItem:superView attribute:NSLayoutAttributeBottom];
    NSLayoutConstraint *viewRight = [self jm_maskViewConstraintWithItem:maskView toItem:superView attribute:NSLayoutAttributeTrailing];
    NSLayoutConstraint *viewTop = [self jm_maskViewConstraintWithItem:maskView toItem:superView attribute:NSLayoutAttributeTop];
    [superView addConstraints:@[viewLeft,viewBottom ,viewRight, viewTop]];
}
@end
