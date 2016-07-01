//
//  JMSearchBarTextField.m
//  JMSearchBarDemo
//
//  Created by chengbin on 16/6/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "JMSearchBarTextField.h"

@implementation JMSearchBarTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    _leftViewLeftMargin = 10.0f;
}

- (instancetype)init {
    if (self = [super init]) {
        _leftViewLeftMargin = 10.0f;
    }
    return self;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect leftViewRect = [super leftViewRectForBounds:bounds];
    leftViewRect.origin.x += self.leftViewLeftMargin;
    return leftViewRect;
}

@end
