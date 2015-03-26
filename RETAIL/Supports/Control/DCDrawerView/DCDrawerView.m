
#import "DCDrawerView.h"

typedef UIPanGestureRecognizer DragGesture;

#define kContentViewAnimationRate 0.5

@interface DCDrawerView ()
<UIGestureRecognizerDelegate>
{
  Direction _slideDirection;
  Direction _openDirection;
  
  CGFloat _lastX, _curX, _offset;
  CGFloat _originXOffset;
  CGFloat _distance;
  BOOL    _exceeded;
}

- (void)handleDrag:(DragGesture *)dragGesture;

- (void)openAnimated:(BOOL)animated
         toDirection:(Direction)toDirection
          completion:(void (^)())completion;
- (void)closeAnimated:(BOOL)animated completion:(void (^)())completion;
- (void)resetContent;

- (void)didBeginDragging;
- (void)didEndDragging;

@end

@implementation DCDrawerView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _maxSlideDistance = 100.0;
    
    _openAnimationBaseDuration = 0.3;
    _closeAnimationBaseDuration = 0.3;
    _resetContentAnimationBaseDuration = 0.3;

    UIViewAutoresizing autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    _backgroundView.backgroundColor = [UIColor clearColor];
    _backgroundView.autoresizingMask = autoresizingMask;
    [self addSubview:_backgroundView];
    
    _foregroundView = [[UIView alloc] initWithFrame:self.bounds];
    _foregroundView.backgroundColor = [UIColor clearColor];
    _foregroundView.autoresizingMask = autoresizingMask;
    [self addSubview:_foregroundView];
    
    _contentView = [[UIView alloc] initWithFrame:self.bounds];
    _contentView.backgroundColor = [UIColor clearColor];
    _contentView.autoresizingMask = autoresizingMask;
    [_foregroundView addSubview:_contentView];
    
    DragGesture *gesture = [[DragGesture alloc] initWithTarget:self
                                                        action:@selector(handleDrag:)];
    gesture.delegate = self;
    gesture.maximumNumberOfTouches = 1;
    [self addGestureRecognizer:gesture];
  }
  return self;
}

- (void)handleDrag:(DragGesture *)dragGesture {
  CGPoint p = [dragGesture locationInView:self];
  
  switch (dragGesture.state) {
    case UIGestureRecognizerStateBegan:
    {
      _lastX = _curX = p.x;
      _offset   = 0.0;
      _distance = _foregroundView.frame.origin.x;
      _exceeded = NO;
      _slideDirection = DirectionUnknown;
      
      [self didBeginDragging];
      break;
    }
    case UIGestureRecognizerStateChanged:
    {
      _curX = p.x;
      
      _offset = _curX - _lastX;
      
      if (_offset < 0) {
        _slideDirection = DirectionLeft;
      }
      else if (_offset > 0) {
        _slideDirection = DirectionRight;
      }
      
      _distance += _offset;
      
      if (_distance < 0) {
        if (!_allowsSlideToLeft) {
          _originXOffset = 0; // MAX(0, _distance);
          _exceeded = NO;
        }
        else {
          _originXOffset = MAX(-_maxSlideDistance, _distance);
          _exceeded = fabs(_distance) > _maxSlideDistance;
        }
      }
      else if (_distance > 0) {
        if (!_allowsSlideToRight) {
          _originXOffset = 0; // MIN(0, _distance);
          _exceeded = NO;
        }
        else {
          _originXOffset = MIN(_maxSlideDistance, _distance);
          _exceeded = _distance > _maxSlideDistance;
        }
      }
      
      CGRect frame = _foregroundView.frame;
      frame.origin.x = _originXOffset;
      _foregroundView.frame = frame;
      
      if (_exceeded) {
        CGRect frame = _contentView.frame;
        frame.origin.x += _offset * kContentViewAnimationRate;
        _contentView.frame = frame;
      }
      
      _lastX = _curX;
      break;
    }
    case UIGestureRecognizerStateEnded:
    {
      [self resetContent];
      
      if (_openDirection == DirectionLeft) {
        if (_slideDirection == DirectionLeft) {
          [self openAnimated:YES toDirection:_openDirection completion:nil];
        }
        else {
          [self closeAnimated:YES completion:nil];
        }
      }
      else if (_openDirection == DirectionRight) {
        if (_slideDirection == DirectionRight) {
          [self openAnimated:YES toDirection:_openDirection completion:nil];
        }
        else {
          [self closeAnimated:YES completion:nil];
        }
      }
      else {
        if (_slideDirection == DirectionLeft && _allowsSlideToLeft && _foregroundView.frame.origin.x < 0) {
          [self openAnimated:YES
                 toDirection:DirectionLeft
                  completion:^{}];
        }
        else if (_slideDirection == DirectionRight && _allowsSlideToRight && _foregroundView.frame.origin.x > 0) {
          [self openAnimated:YES
                 toDirection:DirectionRight
                  completion:^{}];
        }
        else {
          [self closeAnimated:YES completion:^{}];
        }
      }
      
      [self didEndDragging];
      break;
    }
    default:
      break;
  }
}

- (void)openAnimated:(BOOL)animated
         toDirection:(Direction)toDirection
          completion:(void (^)())completion
{
  CGFloat offset = toDirection == DirectionLeft ? -_maxSlideDistance : _maxSlideDistance;
  CGRect frame = _foregroundView.frame;
  NSTimeInterval duration = fabs((frame.origin.x - offset) * _openAnimationBaseDuration / offset);
  frame.origin.x = offset;
  
  if (animated) {
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                       _foregroundView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                       _openDirection = toDirection;
                       if (completion != nil) {
                         completion();
                       }
                     }];
  }
  else {
    _foregroundView.frame = frame;
    _openDirection = toDirection;
    if (completion != nil) {
      completion();
    }
  }
}

- (void)closeAnimated:(BOOL)animated completion:(void (^)())completion
{
  CGRect frame = _foregroundView.frame;
  NSTimeInterval duration = -frame.origin.x * _closeAnimationBaseDuration / _maxSlideDistance;
  frame.origin.x = 0.0;
  
  if (animated) {
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                       _foregroundView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                       _openDirection = DirectionUnknown;
                       if (completion != nil) {
                         completion();
                       }
                     }];
  }
  else {
    _foregroundView.frame = frame;
    _openDirection = DirectionUnknown;
    if (completion != nil) {
      completion();
    }
  }
}

- (void)resetContent {
  CGRect frame = _contentView.frame;
  frame.origin.x = 0.0;
  
  CGFloat baseDistance = (self.bounds.size.width - _maxSlideDistance) * kContentViewAnimationRate;
  CGFloat offset = -_contentView.frame.origin.x;
  NSTimeInterval duration = offset * _resetContentAnimationBaseDuration / baseDistance;
  
  [UIView animateWithDuration:duration
                        delay:0.0
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^{
                     _contentView.frame = frame;
                   }
                   completion:^(BOOL finished) {
                     
                   }];
}

#pragma mark -

- (void)didBeginDragging {
  if ([self.delegate respondsToSelector:@selector(drawerViewDidBeginDragging:)]) {
    [self.delegate drawerViewDidBeginDragging:self];
  }
}

- (void)didEndDragging {
  if ([self.delegate respondsToSelector:@selector(drawerViewDidEndDragging:)]) {
    [self.delegate drawerViewDidEndDragging:self];
  }
}

#pragma mark -
#pragma mark UIGestureRecognizer Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  BOOL should = NO;
  
  if ([self.delegate respondsToSelector:@selector(drawerViewShouldBeginDragging:)]) {
    should = [self.delegate drawerViewShouldBeginDragging:self];
  }
  else {
    should = YES;
  }
  
  if (should) {
    if ([gestureRecognizer isKindOfClass:[DragGesture class]]) {
      DragGesture *gesture = (DragGesture *)gestureRecognizer;
      CGPoint v = [gesture velocityInView:self];

      should = fabsf(v.x) > fabsf(v.y);
    }
  }
  
  if (!should) {
    [self.delegate drawerViewDidAbortDragging:self];
  }
  
  return should;
}


@end
