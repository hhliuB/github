
/******************************************************************************
 *  @file   : UIConstants.h
 *  @author : CUI ZHENSONG
 *  @date   : 2014-11-10
 *  @brief  : 定义 UI 相关的常量
 *            包括但不限于坐标、宽高、frame、颜色、字体、动画时间等
 ******************************************************************************/

#ifndef UIConstants_h
#define UIConstants_h

/**
 *  Frames
 */
#pragma mark -
#pragma mark Frames

#define kLeftViewWidth     240
#define kSeparatorWidth    4
#define kRightViewX        244
#define kRightViewWidth    720
#define kSettingsViewWidth 240

#define kHeaderViewHeight 69
#define kDetailViewY      70
#define kDetailViewHeight 698

/**
 *  Identifiers
 */
#pragma mark -
#pragma mark Identifiers

#define kNumberCellIdentifier        @"Number"
#define kNameCellIdentifier          @"Name"
#define kFormulationCellIdentifier   @"Formulation"
#define kSpecificationCellIdentifier @"Specification"
#define kPreiceIdentifier            @"Price"
#define kCountCellIdentifier         @"Count"


//#define <#kSpecifiedCellIdentifier#> @"<#kSpecifiedCellIdentifier#>"

/**
 *  Colors
 */
#pragma mark -
#pragma mark Colors

#define kMainColor      kBlueColor

#define kBlueColor      [UIColor colorWithHex:0x40a9e0]
#define kLightBlueColor [UIColor colorWithHex:0xC2E2F5]
#define kDarkBlueColor  [UIColor colorWithHex:0x008cd6]

#define kTextColor      [UIColor colorWithHex:0x858585]
#define kDarkTextColor  [UIColor colorWithHex:0x303030]

#define kLightGrayColor [UIColor colorWithHex:0xf9f9f9]
#define kGrayColor      [UIColor colorWithHex:0xf5f5f5]
#define kDarkGrayColor  [UIColor colorWithHex:0xededed]

#define kLineColor      [UIColor colorWithHex:0xededed]

#define kBlackColor     [UIColor colorWithHex:0x000000]
#define kWhiteColor     [UIColor colorWithHex:0xffffff]
#define kClearColor     [UIColor clearColor]

#define kOrangeColor    [UIColor colorWithHex:0xef903e]
#define kRedColor       [UIColor colorWithHex:0xcc0000]
#define kGreenColor     [UIColor colorWithHex:0x00a45c]

/**
 *  Fonts
 */
#pragma mark -
#pragma mark Fonts

#define UIFontWithSize(fontSize) [UIFont systemFontOfSize:fontSize]

#define kSmallestFont UIFontWithSize(10)
#define kSmallerFont  UIFontWithSize(12)
#define kDefaultFont  UIFontWithSize(14)
#define kLargerFont   UIFontWithSize(16)
#define kLargestFont  UIFontWithSize(18)
#define kHugeFont     UIFontWithSize(22)

/**
 *  Others
 */
#pragma mark -
#pragma mark Others

#define kPopHudDismissDelayTime 3.0

#endif
