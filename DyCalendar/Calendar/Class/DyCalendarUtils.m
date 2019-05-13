//
//  DyCalendarUtils.m
//  TestProject
//
//  Created by Dylan_W on 2019/4/17.
//  Copyright © 2019 nipaiyi. All rights reserved.
//

#import "DyCalendarUtils.h"
#import "DyCalendarDaysModel.h"
#import <objc/runtime.h>

#define FirstWeekday 2

@interface DyCalendarUtils ()

/// 记录当前的时间.
@property (nonatomic, strong, class) NSDate *myThisDate;
/// 记录选中的时间.
@property (nonatomic, strong, class) NSDate *mySelectDate;

@end

@implementation DyCalendarUtils

static const void *this_date_strongKey = &this_date_strongKey;
static const void *select_date_strongKey = &select_date_strongKey;
static const void *current_date_strongKey = &current_date_strongKey;

/// 设置今日时间.
+ (void)setMyThisDate:(NSDate *)myThisDate {
    
    objc_setAssociatedObject(self, this_date_strongKey, myThisDate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    DyCalendarUtils.mySelectDate = myThisDate;
}

/// 获取今日时间.
+ (NSDate *)myThisDate {

    return objc_getAssociatedObject(self, this_date_strongKey);
}

/// 设置选中的时间.
+ (void)setMySelectDate:(NSDate *)mySelectDate {
    
    objc_setAssociatedObject(self, select_date_strongKey, mySelectDate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 得到选中的时间.
+ (NSDate *)mySelectDate {
    
    return objc_getAssociatedObject(self, select_date_strongKey);
}

/// 设置当前操作的时间.
+ (void)setMyCurrentDate:(NSDate *)myCurrentDate {
    
    objc_setAssociatedObject(self, current_date_strongKey, myCurrentDate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 获取当前操作的时间.
+ (NSDate *)myCurrentDate {
    
    return objc_getAssociatedObject(self, current_date_strongKey);
}

/// 获取日.
+ (NSInteger)day:(NSDate *)date {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return components.day;
}

/// 获取月.
+ (NSInteger)month:(NSDate *)date {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return components.month;
}

/// 获取年.
+ (NSInteger)year:(NSDate *)date {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return components.year;
}

/// 获取当前月份第一天是星期几.
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date {
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    //设置每周的第一天从周几开始，默认为1，从周日开始
    [calender setFirstWeekday:FirstWeekday];//1.Sun 2.Mon 3.Thes 4.Wed 5.Thur 6.Fri 7.Sat
    NSDateComponents *comp = [calender components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calender dateFromComponents:comp];
    NSInteger firstWeekday = [calender ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday-1;
}

/// 获取当前月份下一个月第一天是星期几.
+ (NSInteger)firstWeekdayInNextMonth:(NSDate *)date {
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    //设置每周的第一天从周几开始，默认为1，从周日开始
    [calender setFirstWeekday:FirstWeekday];
    NSDateComponents *comp = [calender components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    comp.month = comp.month + 1;
    comp.day = 1;
    NSDate * nextMonthDay = [calender dateFromComponents:comp];
    return [DyCalendarUtils firstWeekdayInThisMonth:nextMonthDay];
}

/// 获取当前月共有多少天.
+ (NSInteger)totalDaysInMonth:(NSDate *)date {
    
    NSRange daysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInMonth.length;
}

/// 获取当前月前一个月有多少天.
+ (NSInteger)totalDaysInLastMonth:(NSDate *)date {
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    //设置每周的第一天从周几开始，默认为1，从周日开始
    [calender setFirstWeekday:FirstWeekday];
    NSDateComponents *comp = [calender components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    comp.month = comp.month - 1;
    comp.day = 1;
    
    NSDate * lastMonthDay = [calender dateFromComponents:comp];
    
    NSRange daysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:lastMonthDay];
    return daysInMonth.length;
}

/// 获取当前月下一个月有多少天.
+ (NSInteger)totalDaysInNextMonth:(NSDate *)date {
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    //设置每周的第一天从周几开始，默认为1，从周日开始
    [calender setFirstWeekday:FirstWeekday];
    NSDateComponents *comp = [calender components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    comp.month = comp.month + 1;
    comp.day = 1;
    
    NSDate * nextMonthDay = [calender dateFromComponents:comp];
    
    NSRange daysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:nextMonthDay];
    return daysInMonth.length;
}

/// 获取当前月日历显示时间数组.
+ (NSArray *)getAllDaysInThisMonthCalendar:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:FirstWeekday];
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    DyCalendarUtils.myThisDate = [calendar dateFromComponents:comp];
    DyCalendarUtils.myCurrentDate = [calendar dateFromComponents:comp];
    return [DyCalendarUtils getAllDaysInMonthCalendar:DyCalendarUtils.myCurrentDate];
}

/// 获取上一个月日历显示时间数组.
+ (NSArray *)getAllDaysInLastMonth {
    
    NSDate *date = DyCalendarUtils.myCurrentDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:FirstWeekday];
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    comp.month = comp.month - 1;
    comp.day = 1;
    DyCalendarUtils.myCurrentDate = [calendar dateFromComponents:comp];
    //设置选中的天
    if (DyCalendarUtils.mySelectDate) {
        NSDateComponents *currentComp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:DyCalendarUtils.mySelectDate];
        NSDateComponents *copyComp = [currentComp copy];
        NSInteger lastMonth = currentComp.month - 1;
        copyComp.month = lastMonth;
        copyComp.day = 1;
        NSInteger lastMonthDays = [DyCalendarUtils totalDaysInMonth:[calendar dateFromComponents:copyComp]];
        if (currentComp.day > lastMonthDays) {
            currentComp.day = lastMonthDays;
        }
        currentComp.month = lastMonth;
        DyCalendarUtils.mySelectDate = [calendar dateFromComponents:currentComp];
        DyCalendarUtils.myCurrentDate = [calendar dateFromComponents:currentComp];
    }
    return [DyCalendarUtils getAllDaysInMonthCalendar:DyCalendarUtils.myCurrentDate];
}

/// 获取下一个月日历显示时间数组.
+ (NSArray *)getAllDaysInNextMonth {
    
    NSDate *date = DyCalendarUtils.myCurrentDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:FirstWeekday];
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    comp.month = comp.month + 1;
    comp.day = 1;
    DyCalendarUtils.myCurrentDate = [calendar dateFromComponents:comp];
    //设置选中的天
    if (DyCalendarUtils.mySelectDate) {
        NSDateComponents *currentComp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:DyCalendarUtils.mySelectDate];
        NSInteger nextMonth = currentComp.month + 1;
        NSDateComponents *copyComp = [currentComp copy];
        copyComp.month = nextMonth;
        copyComp.day = 1;
        NSInteger nextMonthDays = [DyCalendarUtils totalDaysInMonth:[calendar dateFromComponents:copyComp]];
        if (currentComp.day > nextMonthDays) {
            currentComp.day = nextMonthDays;
        }
        currentComp.month = nextMonth;
        DyCalendarUtils.mySelectDate = [calendar dateFromComponents:currentComp];
        DyCalendarUtils.myCurrentDate = [calendar dateFromComponents:currentComp];
    }
    return [DyCalendarUtils getAllDaysInMonthCalendar:DyCalendarUtils.myCurrentDate];
}

/// 获取时间所在月的所有天对象.
+ (NSArray *)getAllDaysInMonthCalendar:(NSDate *)date {
    
    NSMutableArray *daysArr = [NSMutableArray arrayWithCapacity:1];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:FirstWeekday];
    
    NSInteger firstWeekDay = [DyCalendarUtils firstWeekdayInThisMonth:date];
    NSInteger lastTotalDays = [DyCalendarUtils totalDaysInLastMonth:date];
    
    NSInteger mid = 0;
    //上个月
    for (NSInteger i = lastTotalDays - firstWeekDay; i < lastTotalDays; i++) {
        mid = mid + 1;
        DyCalendarDaysModel *model = [[DyCalendarDaysModel alloc] initWithID:mid title:[NSString stringWithFormat:@"%ld", i + 1] type:(PGCalendarDaysTypeLastMonth)];
        NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
        comp.month = comp.month - 1;
        comp.day = i+1;
        model.date = [calendar dateFromComponents:comp];
        [daysArr addObject:model];
    }
    //本月
    for (NSInteger i = 0; i < [DyCalendarUtils totalDaysInMonth:date]; i++) {
        mid = mid + 1;
        DyCalendarDaysModel * model = [[DyCalendarDaysModel alloc] initWithID:mid title:[NSString stringWithFormat:@"%ld", i + 1] type:(PGCalendarDaysTypeThisMonth)];
        NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
        comp.month = comp.month;
        comp.day = i+1;
        model.date = [calendar dateFromComponents:comp];
        if ([model.date compare:DyCalendarUtils.myThisDate] == NSOrderedSame) {
            model.isThisDay = YES;
        }
        if ([model.date compare:DyCalendarUtils.mySelectDate] == NSOrderedSame) {
            model.isSelected = YES;
        }
        [daysArr addObject:model];
    }
    //下个月
    NSInteger nextFirstWeekday = [DyCalendarUtils firstWeekdayInNextMonth:date]; //获取下个月第一天是星期几
    for (NSInteger i = 0; i < 7 - nextFirstWeekday; i++) {
        mid = mid + 1;
        DyCalendarDaysModel * model = [[DyCalendarDaysModel alloc] initWithID:mid title:[NSString stringWithFormat:@"%ld", i + 1] type:(PGCalendarDaysTypeNextMonth)];
        NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
        comp.month = comp.month + 1;
        comp.day = i+1;
        model.date = [calendar dateFromComponents:comp];
        [daysArr addObject:model];
    }
    return daysArr;
}

/// 选中某个日期.
+ (void)selectDate:(NSDate *)date {
    
    DyCalendarUtils.mySelectDate = date;
}
@end
