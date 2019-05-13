//
//  DyCalendarCollectionViewCell.h
//  TestProject
//
//  Created by Dylan_W on 2019/4/18.
//  Copyright © 2019 nipaiyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DyCalendarDaysModel;

NS_ASSUME_NONNULL_BEGIN

@interface DyCalendarCollectionViewCell : UICollectionViewCell

/**
 设置日历的每个cell的数据模型

 @param model 数据模型
 */
- (void)setCellContentWithModel:(DyCalendarDaysModel *)model;

@end

NS_ASSUME_NONNULL_END
