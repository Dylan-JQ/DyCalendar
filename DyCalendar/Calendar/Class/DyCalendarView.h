//
//  DyCalendarView.h
//  TestProject
//
//  Created by Dylan_W on 2019/4/17.
//  Copyright © 2019 nipaiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CalendarDateSwitchResult)(NSDate *currentDate);

typedef void(^CalendarDateSelectResult)(NSDate *currentDate);

@interface DyCalendarView : UIView

/// 日历月份切换结果.
@property (nonatomic, copy) CalendarDateSwitchResult myDateSwitchBlock;

/// 日历日期选择结果.
@property (nonatomic, copy) CalendarDateSelectResult myDateSelectBlock;


/**
 初始化方法

 @param frame 初始化frame
 @param date 时间
 @return 返回日历视图本身
 */
- (instancetype)initWithFrame:(CGRect)frame date:(NSDate *)date;


/**
 更新日历数据源方法

 @param dateArr 日历数据源
 */
- (void)updateDataSource:(NSArray *)dateArr;

@end

NS_ASSUME_NONNULL_END
