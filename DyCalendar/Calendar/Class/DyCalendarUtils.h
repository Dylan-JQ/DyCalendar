//
//  DyCalendarUtils.h
//  TestProject
//
//  Created by Dylan_W on 2019/4/17.
//  Copyright © 2019 nipaiyi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DyCalendarUtils : NSObject

/// 当前的时间.
@property (nonatomic, strong, class) NSDate *myCurrentDate;

/// 获取日.
+ (NSInteger)day:(NSDate *)date;
/// 获取月.
+ (NSInteger)month:(NSDate *)date;
/// 获取年.
+ (NSInteger)year:(NSDate *)date;

/// 获取当前月份第一天是星期几.
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
/// 获取当前月份下一个月第一天是星期几.
+ (NSInteger)firstWeekdayInNextMonth:(NSDate *)date;

/// 获取当前月共有多少天.
+ (NSInteger)totalDaysInMonth:(NSDate *)date;
/// 获取当前月前一个月有多少天.
+ (NSInteger)totalDaysInLastMonth:(NSDate *)date;
/// 获取当前月下一个月有多少天.
+ (NSInteger)totalDaysInNextMonth:(NSDate *)date;

/// 获取当前月日历显示时间数组.
+ (NSArray *)getAllDaysInThisMonthCalendar:(NSDate *)date;
/// 获取上一个月日历显示时间数组.
+ (NSArray *)getAllDaysInLastMonth;
/// 获取下一个月日历显示时间数组.
+ (NSArray *)getAllDaysInNextMonth;


/// 选中某个日期.
+ (void)selectDate:(NSDate *)date;
@end

NS_ASSUME_NONNULL_END
