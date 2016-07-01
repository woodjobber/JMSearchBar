//
//  JMSearchBar.h
//  JMSearchBar
//
//  Created by chengbin on 16/6/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JMSearchBar;

@protocol  JMSearchBarDelegate <NSObject>

@optional

- (void)jm_searchBarDidTapRightItem:(JMSearchBar *)searchBar;

- (void)jm_searchBarDidTapWhiteSpace:(JMSearchBar *)searchBar;

- (BOOL)jm_searchBarDidSearchButton:(JMSearchBar *)searchBar;// Return key

- (BOOL)jm_searchBarShouldBeginEditing:(JMSearchBar *)searchBar;

- (BOOL)jm_searchBarShouldEndEditing:(JMSearchBar *)searchBar;

- (void)jm_searchBarDidBeginEditing:(JMSearchBar *)searchBar;

- (void)jm_searchBarDidEndEditing:(JMSearchBar *)searchBar;

- (BOOL)jm_searchBarShouldClear:(JMSearchBar *)searchBar;

- (BOOL)jm_searchBar:(JMSearchBar *)searchBar shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end

@interface JMSearchBarMaskView : UIView

@end

@interface JMSearchBar : UIView <UITextFieldDelegate>

@property (weak, nonatomic) id<JMSearchBarDelegate>delegate;

@property (assign, nonatomic) CGFloat leftMargin;

@property (strong, nonatomic,readonly) NSString *text;

@property (assign, nonatomic) CGFloat leftViewLeftMarginOfTextField;// Default is 10.0f;

@property (strong, nonatomic) NSString *placeholder;

@property (strong, nonatomic) NSAttributedString * attributedPlaceholder;//Default is nil.

@property (strong, nonatomic) UIFont *font;

@property (strong, nonatomic) UIColor *textColor;

@property (strong, nonatomic) NSString *rightItemTitle;// UIButton's title

@property (strong, nonatomic) UIColor *rightItemColor;// UIButton's color

@property (assign, nonatomic) CGFloat cornerRadius; //Default is 14.0f

@property (assign, nonatomic) CGFloat borderWidth; // Default is 0.5f;

@property (assign, nonatomic) UIColor *borderColor;// Default [UIColor grayColor]

@property (strong, nonatomic) UIColor *backgroundColorForMaskView;

@property (assign, nonatomic) BOOL userInteractionEnabledOfMaskView; //Default YES

@property (strong, nonatomic) UIColor * backgroundColorOfTextField;// textfield in search bar

+ (nullable instancetype)instantiateInitialJMSearchBarFromNib;
/**
 *  Only show search bar
 *
 *  @param view search bar's superview
 *
 *  @return JMSearchBar --
 */

+ (nullable JMSearchBar *)showSearchBarInView:(nonnull UIView *)view;

/**
 *  show search bar and mask view
 *
 *  @param v1 search bar's superview
 *  @param v2 mask view's superview
 *
 *  @return JMSearchBar --
 */
+ (nullable JMSearchBar *)showSearchBarInView:(nonnull UIView *)v1 maskViewInView:(nullable UIView *)v2;

- (void)becomeFirstResponder;

- (void)resignFirstResponder;

@end
NS_ASSUME_NONNULL_END