//
//  DyStyleHeader.h
//  PegasusIPad
//
//  Created by liugangyi on 2019/1/11.
//

#ifndef DyStyleHeader_h
#define DyStyleHeader_h

//======================== 字体 ========================
#define PFSC_Regular(fontSize)     [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize]
#define PFSC_Medium(fontSize)      [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize]
#define PFSC_Light(fontSize)       [UIFont fontWithName:@"PingFangSC-Light" size:fontSize]
#define PFSC_Thin(fontSize)        [UIFont fontWithName:@"PingFangSC-Thin" size:fontSize]
#define PFSC_Semibold(fontSize)    [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize]

//======================== 色值 ========================
/// 通用RGB.
#define kCommonRGBColor(r, g, b)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/// 通过RGB 可以设置alpha.
#define kCommonRGBAColor(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
/// 常用的51 51 51 1.0 颜色.
#define kCommon51Color              [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]



//======================== 屏幕适配 ========================

#define kAppWindow        ([[[UIApplication sharedApplication] delegate] window])
#define kAppKeyWindow        ([[UIApplication sharedApplication] keyWindow])
#define kAppDelegate      ((Appdelegate *)[[UIApplication sharedApplication] delegate])

/// 是否为iPad.
#define IS_PAD ({ \
int ispad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ? 1:0; \
ispad; \
})
/// 是否 X 系列.
#define kIS_XSeries (CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]) == 44.0f)
/// 屏幕宽.
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
/// 屏幕高.
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height

/// 状态栏高度.
#define kStateBarHeight                   (kIS_XSeries  ? 44.0f : 20.0f)
/// iPhoneX的底部底部安全高度
#define kIPhoneXBottomSafeHeight_34       (kIS_XSeries  ? 34.0f : 0.0f)
/// 状态栏+导航栏.
#define kTopBarHeight                     (kIS_XSeries ? 88.0f: 64.0f)
/// tabBar + 安全距离高度..
#define kBottomBarHeight                     (kIS_XSeries ? 83.0f : 49.0f)   //49 83

// ============================ 屏幕适配 ==============================
#pragma mark - iPad 和 iPhone 屏幕比例适配

#define IS_LANDSCAPE    (SCREEN_WIDTH > SCREEN_HEIGHT)

/// 设备适配开关 1 Pad / 0 iPhone.
#define IOS_DEVICE_TYPE 1

#if IOS_DEVICE_TYPE
//  以 7.9 iPad 屏幕为设计稿进行适配
#define kFit_Width(w)       ([UIScreen mainScreen].bounds.size.width / (IS_LANDSCAPE ? 1024.0:768.0) * (w))
#define kFit_Height(h)      ([UIScreen mainScreen].bounds.size.height / (IS_LANDSCAPE ? 768.0:1024.0) * (h))

#else

// 以 6s 为 设计稿进行适配
#define kFit_Width(w)       ([UIScreen mainScreen].bounds.size.width / (IS_LANDSCAPE ? 667.0:375.0) * (w))
#define kFit_Height(h)      ([UIScreen mainScreen].bounds.size.height / (IS_LANDSCAPE ? 375.0:667.0) * (h))

#endif


#endif /* DyStyleHeader */
