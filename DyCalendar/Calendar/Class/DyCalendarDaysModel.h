//
//  DyCalendarDaysModel.h
//  TestProject
//
//  Created by Dylan_W on 2019/4/18.
//  Copyright © 2019 nipaiyi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    PGCalendarDaysTypeLastMonth, /// 上一个月.
    PGCalendarDaysTypeThisMonth, /// 本月.
    PGCalendarDaysTypeNextMonth, /// 下一个月.
} PGCalendarDaysType;

@interface DyCalendarDaysModel : NSObject
/// 模型id.
@property (nonatomic, assign) NSInteger mId;
/// 标题 - 日期.
@property (nonatomic, copy) NSString *title;
/// 当前的时间.
@property (nonatomic, strong) NSDate *date;
/// 日期类别.
@property (nonatomic, assign) PGCalendarDaysType type;
/// 是否选中.
@property (nonatomic, assign) BOOL isSelected;
/// 是否为当日.
@property (nonatomic, assign) BOOL isThisDay;
/// 有tag.
@property (nonatomic, assign) BOOL isTag;

/**
 初始化日历每日的数据对象

 @param mid 数据模型id
 @param title 显示的标题
 @param type 类型
 @return 返回对象本身
 */
- (instancetype)initWithID:(NSInteger)mid title:(NSString *)title type:(PGCalendarDaysType)type;

@end

NS_ASSUME_NONNULL_END
