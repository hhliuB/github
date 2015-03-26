#import "DCSegmentButton.h"

#import <QuartzCore/QuartzCore.h>

@implementation DCSegmentButton
{
  UIButton *_selectedButton;
  NSMutableArray *_buttons;
}

- (id)initWithFrame:(CGRect)frame
              style:(DCSegmentButtonStyle)style
             titles:(NSArray *)titles
{
  self = [super initWithFrame:frame];
  if (self) {
    switch (style) {
      case DCSegmentButtonStyleRoundRect:
        [self layoutRoundRectButtonsWithSize:frame.size titles:titles];
        break;
      case DCSegmentButtonStylePlainText:
        [self layoutPlainTextButtonsWithHeight:frame.size.height titles:titles];
        break;
      default:
        break;
    }
  }
  return self;
}

- (void)layoutRoundRectButtonsWithSize:(CGSize)size
                                titles:(NSArray *)titles
{
  UIColor *defaultColor = [UIColor colorWithRed:0.0 / 255.0
                                          green:140 / 255.0
                                           blue:214 / 255.0
                                          alpha:1.0];
  UIImage *defaultImage = [UIImage imageNamed:@"DCSegmentButtonDefaultBackgroundImage.png"];
  
  _borderColor = defaultColor;
  
  self.layer.borderWidth = 1.0;
  self.layer.borderColor = _borderColor.CGColor;
  self.layer.cornerRadius = 5.0;
  self.clipsToBounds = YES;
  
  int cnt = titles.count;
  
  _buttons = [NSMutableArray arrayWithCapacity:cnt];
  
  CGFloat x = 0.0;
  CGFloat y = 0.0;
  CGFloat w = size.width / cnt;
  CGFloat h = size.height;
  
  for (int i = 0; i < cnt; i++) {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTag:i];
    [btn setFrame:CGRectMake(x, y, w, h)];
    [btn setTitle:titles[i] forState:UIControlStateNormal];
    [btn setTitleColor:defaultColor forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [[btn titleLabel] setFont:[UIFont systemFontOfSize:13.0]];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setBackgroundImage:nil forState:UIControlStateNormal];
    [btn setBackgroundImage:defaultImage forState:UIControlStateSelected];
    [btn setBackgroundImage:defaultImage forState:UIControlStateHighlighted];
    [[btn layer] setBorderWidth:0.5];
    [[btn layer] setBorderColor:_borderColor.CGColor];
    [btn addTarget:self
            action:@selector(buttonPressed:)
  forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [_buttons addObject:btn];
    
    x += w;
  }
  
  _selectedButton = _buttons[0];
  [_selectedButton setSelected:YES];
}

- (void)layoutPlainTextButtonsWithHeight:(CGFloat)height
                                  titles:(NSArray *)titles
{
  UIColor *defaultColor = [UIColor colorWithRed:0.0 / 255.0
                                          green:140 / 255.0
                                           blue:214 / 255.0
                                          alpha:1.0];
  
  self.clipsToBounds = YES;
  
  int cnt = titles.count;
  
  _buttons = [NSMutableArray arrayWithCapacity:cnt];
  
  CGFloat x = 0.0;
  CGFloat y = 0.0;
  CGFloat w = 0.0;
  CGFloat h = height;
  
  for (int i = 0; i < cnt; i++) {
    NSString *title = titles[i];
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:14.0]];
    w = MAX(ceilf(size.width), 30);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTag:i];
    [btn setFrame:CGRectMake(x, y, w, h)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:defaultColor forState:UIControlStateSelected];
    [btn setTitleColor:defaultColor forState:UIControlStateHighlighted];
    [[btn titleLabel] setFont:[UIFont systemFontOfSize:14.0]];
    [btn addTarget:self
            action:@selector(buttonPressed:)
        forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [_buttons addObject:btn];
    
    if (i != cnt - 1) {
      CGRect separatorLableFrame = CGRectMake(x + w, 0, 10, h);
      UILabel *separatorLable = [[UILabel alloc] initWithFrame:separatorLableFrame];
      separatorLable.layer.borderWidth = 1.0;
      separatorLable.layer.borderColor = [UIColor whiteColor].CGColor;
      separatorLable.text = @"/";
      separatorLable.textColor = [UIColor darkGrayColor];
      separatorLable.textAlignment = NSTextAlignmentCenter;
      [self addSubview:separatorLable];
    }
    
    x += (w + 10);
  }
  
  _selectedButton = _buttons[0];
  [_selectedButton setSelected:YES];
  
  CGRect frame = self.frame;
  frame.size.width = x - 10;
  self.frame = frame;
}

- (void)buttonPressed:(UIButton *)sender
{
  if (_selectedButton == sender) {
    return;
  }
  
  _selectedButton.selected = NO;
  _selectedButton = sender;
  _selectedButton.selected = YES;
  
  [_delegate segmentButton:self didSelectIndex:_selectedButton.tag];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
  if (_selectedButton.tag == selectedIndex) {
    return;
  }
  
  _selectedButton.selected = NO;
  _selectedButton = nil;
  for (UIButton *btn in _buttons) {
    if (btn.tag == selectedIndex) {
      _selectedButton = btn;
      break;
    }
  }
  _selectedButton.selected = YES;
}

- (NSInteger)selectedIndex
{
  if (_selectedButton == nil) {
    return -1;
  }
  
  return _selectedButton.tag;
}

#pragma mark -

- (void)setTitleColor:(UIColor *)color
             forState:(UIControlState)state
{
  for (UIButton *btn in _buttons) {
    [btn setTitleColor:color forState:state];
  }
}

- (void)setButtonBackgroundImage:(UIImage *)image
                        forState:(UIControlState)state
{
  for (UIButton *btn in _buttons) {
    [btn setBackgroundImage:image forState:state];
  }
}

#pragma mark -

- (void)setBorderColor:(UIColor *)borderColor
{
  _borderColor = borderColor;
  self.layer.borderColor = _borderColor.CGColor;
  
  for (UIButton *btn in _buttons) {
    btn.layer.borderColor = _borderColor.CGColor;
  }
}

@end
