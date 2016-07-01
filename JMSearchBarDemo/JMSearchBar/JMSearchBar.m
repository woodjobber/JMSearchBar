//
//  JMSearchBar.m
//  JMSearchBar
//
//  Created by chengbin on 16/6/13.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "JMSearchBar.h"
#import "JMSearchBar+JMSearchBarLayout.h"
#import "JMSearchBarTextField.h"

static NSString * const JMSearchBarNibName = @"JMSearchBar";
static NSString * const JMSearchBarTextFiledPlaceholder = @"搜索历史订单";

@protocol JMSearchBarMaskViewDelegate <NSObject>

- (void)jm_searchBarMaskViewTouchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

@end

@interface JMSearchBarMaskView ()

@property (weak, nonatomic) id<JMSearchBarMaskViewDelegate>delegate;

@end

@implementation JMSearchBarMaskView

- (instancetype)init {
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithWhite:0.9f alpha:0.7f];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_searchBarMaskViewTouchesBegan:withEvent:)]) {
        [self.delegate jm_searchBarMaskViewTouchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];
}

@end

@interface JMSearchBar ()<JMSearchBarMaskViewDelegate>

@property (weak, nonatomic) IBOutlet JMSearchBarTextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (strong, nonatomic) JMSearchBarMaskView *playground;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldLeftMargin;

@end

@implementation JMSearchBar

#pragma mark -
#pragma mark Init

+ (nullable instancetype)instantiateInitialJMSearchBarFromNib {
   return [[UINib nibWithNibName:JMSearchBarNibName bundle:nil] instantiateWithOwner:self options:nil].firstObject;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (instancetype)init {
    JMSearchBar *searchBar = [[self class] instantiateInitialJMSearchBarFromNib];
    if (self = [super init]) {
        searchBar.frame = self.frame;
        [self setup];
    }
    return searchBar?:self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    JMSearchBar *searchBar = [[self class] instantiateInitialJMSearchBarFromNib];
    if (self = [super initWithFrame:frame]) {
        searchBar.frame = self.frame;
        [self setup];
    }
    return searchBar?:self;
}

#pragma mark -
#pragma mark Setter Methods

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
    [self.textField setNeedsDisplay];
}

- (void)setLeftViewLeftMarginOfTextField:(CGFloat)leftViewLeftMarginOfTextField{
    _leftViewLeftMarginOfTextField = leftViewLeftMarginOfTextField;
    self.textField.leftViewLeftMargin = leftViewLeftMarginOfTextField;
    [self.textField setNeedsLayout];
}

- (void)setLeftMargin:(CGFloat)leftMargin {
    _leftMargin = leftMargin;
    self.textFieldLeftMargin.constant = leftMargin;
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    [self.textField setFont:font];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.textField.textColor = textColor;
    [self.textField setNeedsDisplay];
}

- (void)setRightItemTitle:(NSString *)rightItemTitle {
    _rightItemTitle = rightItemTitle;
    [self.cancelButton setTitle:rightItemTitle forState:UIControlStateNormal];
}
- (void)setRightItemColor:(UIColor *)rightItemColor {
    _rightItemColor = rightItemColor;
    [self.cancelButton setTitleColor:rightItemColor forState:UIControlStateNormal];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.textField.layer.cornerRadius = cornerRadius;
    [self.textField setNeedsDisplay];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.textField.layer.borderColor = borderColor.CGColor;
    [self.textField setNeedsDisplay];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.textField.layer.borderWidth = borderWidth;
    [self.textField setNeedsDisplay];
}

- (void)setBackgroundColorForMaskView:(UIColor *)backgroundColorForMaskView {
    _backgroundColorForMaskView = backgroundColorForMaskView;
    self.playground.backgroundColor = backgroundColorForMaskView;
}

- (void)setUserInteractionEnabledOfMaskView:(BOOL)userInteractionEnabledOfMaskView {
    _userInteractionEnabledOfMaskView = userInteractionEnabledOfMaskView;
    self.playground.userInteractionEnabled = userInteractionEnabledOfMaskView;
}
- (void)setBackgroundColorOfTextField:(UIColor *)backgroundColorOfTextField {
    _backgroundColorForMaskView = backgroundColorOfTextField;
    self.textField.backgroundColor = backgroundColorOfTextField;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    _attributedPlaceholder = attributedPlaceholder;
    self.textField.attributedPlaceholder = attributedPlaceholder;
}

#pragma mark -
#pragma mark Getter Methods
- (NSString *)text {
    return self.textField.text;
}

#pragma mark -
#pragma mark Private Methods - configure
- (void)setup{
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.textField.delegate = self;
    self.textField.placeholder = JMSearchBarTextFiledPlaceholder;
    [self.textField becomeFirstResponder];
    self.textField.returnKeyType = UIReturnKeySearch;
   
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 20.0f, 20.0f);
    [leftBtn setImage:[UIImage imageNamed:@"Search_noraml"] forState:UIControlStateNormal];
    leftBtn.userInteractionEnabled = NO;
    self.textField.leftView = leftBtn;
    [self.textField.leftView setFrame:CGRectMake(0, 0, 25.0f, 20.0f)];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    self.textField.layer.cornerRadius = 14.0f;
    self.textField.layer.borderWidth = 0.5f;
    self.textField.layer.borderColor = [UIColor grayColor].CGColor;
    self.textField.layer.masksToBounds = YES;
    _leftViewLeftMarginOfTextField = 10.0f;
    _userInteractionEnabledOfMaskView = YES;
}

- (JMSearchBarMaskView *)playground {
    if (!_playground) {
        _playground = [[JMSearchBarMaskView alloc]init];
        _playground.delegate = self;
        _playground.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _playground;
}

- (void)jm_searchBarMaskViewTouchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeSearchBarAndMaskViewFromSuperView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_searchBarDidTapWhiteSpace:)]) {
        [self.delegate jm_searchBarDidTapWhiteSpace:self];
    }
}

- (void)removeSearchBarAndMaskViewFromSuperView {
    [self resignFirstResponder];
    [self removeFromSuperview];
    [self.playground removeFromSuperview];
    
}
- (IBAction)jm_searchBarCancel:(id)sender {
    [self removeSearchBarAndMaskViewFromSuperView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_searchBarDidTapRightItem:)]) {
        [self.delegate jm_searchBarDidTapRightItem:self];
    }
}

#pragma mark -
#pragma mark Public Methods

+ (nullable JMSearchBar *)showSearchBarInView:(nonnull UIView *)view {
   return [self showSearchBarInView:view maskViewInView:nil];
}

+ (nullable JMSearchBar *)showSearchBarInView:(nonnull UIView *)v1 maskViewInView:(nullable UIView *)v2 {
    if (!v1) {
        return nil;
    }
    __block JMSearchBar *searchBar = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
      
        searchBar = ({
            JMSearchBar *searchBar = [JMSearchBar instantiateInitialJMSearchBarFromNib];
            [v1 addSubview:searchBar];
            [v1 bringSubviewToFront:searchBar];
            searchBar;
        });
        [searchBar jm_searchBarAutoLayout];
        if (v2) {
            [v2 addSubview:searchBar.playground];
            [v2 bringSubviewToFront:searchBar.playground];
            [searchBar jm_searchBarAutoLayoutMaskView:searchBar.playground];
        }
      
    });
    return searchBar;
}

- (void)becomeFirstResponder {
    [self.textField becomeFirstResponder];
}
- (void)resignFirstResponder {
    [self.textField resignFirstResponder];
}

#pragma mark - 
#pragma mark UITextFieldDelegate


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_searchBarShouldBeginEditing:)]) {
       return [self.delegate jm_searchBarShouldBeginEditing:self];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_searchBarDidBeginEditing:)]) {
        [self.delegate jm_searchBarDidBeginEditing:self];
    }

}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_searchBarShouldEndEditing:)]) {
       return [self.delegate jm_searchBarShouldEndEditing:self];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_searchBarDidEndEditing:)]) {
        [self.delegate jm_searchBarDidEndEditing:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
   
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_searchBar:shouldChangeCharactersInRange:replacementString:)]) {
       return [self.delegate jm_searchBar:self shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_searchBarShouldClear:)]) {
       return [self.delegate jm_searchBarShouldClear:self];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_searchBarDidSearchButton:)]) {
        return [self.delegate jm_searchBarDidSearchButton:self];
    }
    return YES;
}

@end
