#import "HZInfiniteYearScrollView.h"
#import "HZCalendarCommon.h"

@interface HZInfiniteYearScrollView ()<UIGestureRecognizerDelegate>{
  UILabel* _highlightLabel;
}

@property(nonatomic, strong) UIView *labelContainerView;

- (void)updateYearLabelText;

- (void)recenterIfNecessary;
- (void)highlightIfNecessary;
- (UILabel *)insertLabel;
- (CGFloat)placeNewLabelOnRight:(CGFloat)rightEdge;
- (CGFloat)placeNewLabelOnLeft:(CGFloat)leftEdge;
@end


@implementation HZInfiniteYearScrollView


- (id)initWithFrame:(CGRect)frame year:(int)year{
  if((self = [super initWithFrame:frame])){
    [self setSelectedYear:year];
    _selectedYear = year;
    self.contentSize = CGSizeMake(5000, self.frame.size.height);
    
    _visibleLabels = [[NSMutableArray alloc] init];
    
    _labelContainerView = [[UIView alloc] init];
    self.labelContainerView.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    [self addSubview:self.labelContainerView];
    
    [self.labelContainerView setUserInteractionEnabled:NO];
    
    [self setShowsHorizontalScrollIndicator:NO];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
  }
  return self;
}





- (void)setSelectedYear:(NSInteger)selectedYear{
  _selectedYear = selectedYear;
  [self updateYearLabelText];
}

- (void)updateYearLabelText{
  for (int index = 0; index < [self.visibleLabels count]; index++) {
    UILabel* label =((UILabel*) self.visibleLabels[index]);
    [label setText:[NSString stringWithFormat:@"%d",_selectedYear+index]];
    if([label.text integerValue] == _selectedYear){
//      [label setTextColor:kCalendarBlueColor];
      [label setTextColor:kMainColor];
      _highlightLabel = label;
    }else{
      [label setTextColor:kCalendarTextGrayColor];
    }
  }
}

#pragma mark - Layout

// recenter content periodically to achieve impression of infinite scrolling
- (void)recenterIfNecessary
{
  CGPoint currentOffset = [self contentOffset];
  CGFloat contentWidth = [self contentSize].width;
  CGFloat centerOffsetX = (contentWidth - [self bounds].size.width) / 2.0;
  CGFloat distanceFromCenter = fabs(currentOffset.x - centerOffsetX);
  
  if (distanceFromCenter > (contentWidth / 4.0))
  {
    self.contentOffset = CGPointMake(centerOffsetX, currentOffset.y);
    
    // move content by the same amount so it appears to stay still
    for (UILabel *label in self.visibleLabels) {
      CGPoint center = [self.labelContainerView convertPoint:label.center toView:self];
      center.x += (centerOffsetX - currentOffset.x);
      label.center = [self convertPoint:center toView:self.labelContainerView];
    }
  }
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  [self recenterIfNecessary];
  
  // tile content in visible bounds
  CGRect visibleBounds = [self convertRect:[self bounds] toView:self.labelContainerView];
  CGFloat minimumVisibleX = CGRectGetMinX(visibleBounds);
  CGFloat maximumVisibleX = CGRectGetMaxX(visibleBounds);
  
  [self tileLabelsFromMinX:minimumVisibleX toMaxX:maximumVisibleX];
  
  [self highlightIfNecessary];
}


#pragma mark - Label Tiling
- (void)highlightIfNecessary{
  
  for (UILabel* label in self.visibleLabels) {
    if([label.text integerValue] == _selectedYear){
      [label setTextColor:kCalendarTextGrayColor];
      _highlightLabel = label;
//      [label setTextColor:kCalendarBlueColor];
      [label setTextColor:kMainColor];
    }
  }
}


- (UILabel *)insertLabel
{
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, self.bounds.size.height)];
  [label setBackgroundColor:[UIColor clearColor]];
  [label setFont:[UIFont systemFontOfSize:24]];
  [label setTextAlignment:NSTextAlignmentCenter];
  [label setTextColor:kCalendarTextGrayColor];
  [self.labelContainerView addSubview:label];
  return label;
}

- (CGFloat)placeNewLabelOnRight:(CGFloat)rightEdge
{
  UILabel *label = [self insertLabel];
  [self.visibleLabels addObject:label]; // add rightmost label at the end of the array
  
  CGRect frame = [label frame];
  frame.origin.x = rightEdge;
  frame.origin.y = [self.labelContainerView bounds].size.height - frame.size.height;
  [label setFrame:frame];
  
  return CGRectGetMaxX(frame);
}

- (CGFloat)placeNewLabelOnLeft:(CGFloat)leftEdge
{
  UILabel *label = [self insertLabel];
  [self.visibleLabels insertObject:label atIndex:0]; // add leftmost label at the beginning of the array
  
  CGRect frame = [label frame];
  frame.origin.x = leftEdge - frame.size.width;
  frame.origin.y = [self.labelContainerView bounds].size.height - frame.size.height;
  [label setFrame:frame];
  
  return CGRectGetMinX(frame);
}

- (void)tileLabelsFromMinX:(CGFloat)minimumVisibleX toMaxX:(CGFloat)maximumVisibleX
{
  // the upcoming tiling logic depends on there already being at least one label in the visibleLabels array, so
  // to kick off the tiling we need to make sure there's at least one label
  if ([self.visibleLabels count] == 0)
  {
    [self placeNewLabelOnRight:minimumVisibleX];
    NSString* year =[NSString stringWithFormat:@"%d",self.selectedYear + [self.visibleLabels count] - 1];
    [((UILabel*) self.visibleLabels[0]) setText:year];
  }
  
  // add labels that are missing on right side
  UILabel *lastLabel = [self.visibleLabels lastObject];
  CGFloat rightEdge = CGRectGetMaxX([lastLabel frame]);
  while (rightEdge < maximumVisibleX)
  {
    rightEdge = [self placeNewLabelOnRight:rightEdge];
    UILabel* preLastLabel = self.visibleLabels[[self.visibleLabels count] - 2];
    int preYear = [preLastLabel.text intValue];
    [[self.visibleLabels lastObject] setText:[NSString stringWithFormat:@"%d",preYear+1]];
  }
  
  // add labels that are missing on left side
  UILabel *firstLabel = self.visibleLabels[0];
  CGFloat leftEdge = CGRectGetMinX([firstLabel frame]);
  while (leftEdge > minimumVisibleX)
  {
    leftEdge = [self placeNewLabelOnLeft:leftEdge];
    int year = [((UILabel*)self.visibleLabels[1]).text integerValue] - 1;
    [((UILabel*) self.visibleLabels[0]) setText:[NSString stringWithFormat:@"%d",year]];
  }
  
  // remove labels that have fallen off right edge
  lastLabel = [self.visibleLabels lastObject];
  while ([lastLabel frame].origin.x > maximumVisibleX)
  {
    [lastLabel removeFromSuperview];
    [self.visibleLabels removeLastObject];
    lastLabel = [self.visibleLabels lastObject];
  }
  
  // remove labels that have fallen off left edge
  firstLabel = self.visibleLabels[0];
  while (CGRectGetMaxX([firstLabel frame]) < minimumVisibleX)
  {
    [firstLabel removeFromSuperview];
    [self.visibleLabels removeObjectAtIndex:0];
    firstLabel = self.visibleLabels[0];
  }
}

#pragma mark tap
- (void)handleTap:(UITapGestureRecognizer*)sender{
  if(sender.state == UIGestureRecognizerStateEnded){
    for (UILabel* label in self.visibleLabels) {
      if([label pointInside:[sender locationInView:label] withEvent:nil]){
        [self setSelectedYear:[label.text integerValue]];

        if ([self.delegate respondsToSelector:@selector(infiniteScrollView:didSelectYear:offset:)]) {
          [self.delegate infiniteScrollView:self didSelectYear:self.selectedYear offset:label.frame.origin];
        }
        return;
      }
    }
  }
}
@end
