//
//  JMSearchBar+JMSearchBarLayout.h
//  JMSearchBarDemo
//
//  Created by chengbin on 16/6/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "JMSearchBar.h"

@interface JMSearchBar (JMSearchBarLayout)

- (void)jm_searchBarAutoLayout;

- (void)jm_searchBarAutoLayoutMaskView:(UIView *)maskView;

@end
