//
//  DyCalendarView.m
//  TestProject
//
//  Created by Dylan_W on 2019/4/17.
//  Copyright © 2019 nipaiyi. All rights reserved.
//

#import "DyCalendarView.h"
#import "DyCalendarCollectionViewCell.h"
#import "DyCalendarUtils.h"
#import "DyCalendarDaysModel.h"

//集合视图的宽
#define CollectionCellWidth (([UIScreen mainScreen].bounds.size.width-32)/7.0)

//集合视图的高
#define CollectionCellHeight 45

@interface DyCalendarView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

// 我的集合视图.
@property (nonatomic, strong) UICollectionView *myCollectionView;

/// 背景图片视图.
@property (nonatomic, strong) UIImageView *myBackImgView;

/// 记录星期名称的数组.
@property (nonatomic, strong) NSArray *myWeakNameArr;

/// 日历总的天数据模型数组.
@property (nonatomic, strong) NSArray *myEveryDayArr;

/// 上个月的按钮.
@property (nonatomic, strong) UIButton *myLastMonthBtn;

/// 下个月的按钮.
@property (nonatomic, strong) UIButton *myNextMonthBtn;

/// 我的月份显示标签.
@property (nonatomic, strong) UILabel *myDateLabel;

/// 我的日期.
@property (nonatomic, strong) NSDate * myDate;

@end

@implementation DyCalendarView

static NSString * calendarCollectionCell = @"calendarCollectionCell";

#pragma mark - 构造方法

- (instancetype)initWithFrame:(CGRect)frame date:(NSDate *)date {
    
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 420)];
    if (self) {
        self.myDate = date;
        [self initData];
        [self configSelfView];
    }
    return self;
}

#pragma mark - 内部方法

- (void)initData {
    
    self.myWeakNameArr = @[@"一", @"二", @"三", @"四", @"五", @"六", @"日"];
    self.myEveryDayArr = [DyCalendarUtils getAllDaysInThisMonthCalendar:self.myDate];
}

- (void)configSelfView {
    
    //背景
    [self addSubview:self.myBackImgView];
    //头视图
    CGFloat weakNameWidth = CollectionCellWidth;
    for (int i = 0; i < self.myWeakNameArr.count; i++) {
        @autoreleasepool {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16 + weakNameWidth * i, 119, weakNameWidth, 33)];
            label.text = self.myWeakNameArr[i];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
            [self addSubview:label];
        }
    }
    //内容视图
    [self addSubview:self.myCollectionView];
    [self addSubview:self.myDateLabel];
    [self addSubview:self.myLastMonthBtn];
    [self addSubview:self.myNextMonthBtn];
}

- (void)updateDataSource:(NSArray *)dateArr {
    
    self.myEveryDayArr = dateArr;
    [self.myCollectionView reloadData];
}

#pragma mark - 点击事件

- (void)myLastMonthBtnAction:(UIButton *)btn {
    
    self.myEveryDayArr = [DyCalendarUtils getAllDaysInLastMonth];
    [self.myCollectionView reloadData];
    NSDate * current = DyCalendarUtils.myCurrentDate;
    NSDateFormatter * dateFor = [[NSDateFormatter alloc] init];
    [dateFor setDateFormat:@"YYYY年MM月"];
    self.myDateLabel.text = [dateFor stringFromDate:current];
    if (self.myDateSwitchBlock) {
        self.myDateSwitchBlock(current);
    }
}

- (void)myNextMonthBtnAction:(UIButton *)btn {
    
    self.myEveryDayArr = [DyCalendarUtils getAllDaysInNextMonth];
    [self.myCollectionView reloadData];
    NSDate * current = DyCalendarUtils.myCurrentDate;
    NSDateFormatter * dateFor = [[NSDateFormatter alloc] init];
    [dateFor setDateFormat:@"YYYY年MM月"];
    self.myDateLabel.text = [dateFor stringFromDate:current];
    if (self.myDateSwitchBlock) {
        self.myDateSwitchBlock(current);
    }
}

#pragma mark - 集合视图数据源代理

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.myEveryDayArr.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    DyCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:calendarCollectionCell forIndexPath:indexPath];
    [cell setCellContentWithModel:self.myEveryDayArr[indexPath.item]];
    return cell;
}

- (UICollectionView *)myCollectionView {
    
    if (!_myCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _myCollectionView.frame = CGRectMake(0, 172, [UIScreen mainScreen].bounds.size.width, 420 - 172);
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        [_myCollectionView registerClass:[DyCalendarCollectionViewCell class] forCellWithReuseIdentifier:calendarCollectionCell];
        _myCollectionView.backgroundColor = [UIColor clearColor];
    }
    return _myCollectionView;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 16, 0, 16);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(CollectionCellWidth, CollectionCellHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DyCalendarDaysModel *model = self.myEveryDayArr[indexPath.item];
    if (model.type != PGCalendarDaysTypeThisMonth) { //如果不是当月则不操作
        return;
    }
    for (DyCalendarDaysModel * m in self.myEveryDayArr) {
        if (model.mId == m.mId) {
            m.isSelected = YES;
        }else {
            m.isSelected = NO;
        }
    }
    [DyCalendarUtils selectDate:model.date];
    if (self.myDateSelectBlock) {
        self.myDateSelectBlock(model.date);
    }
    [collectionView reloadData];
}

#pragma mark - Setter/Getter方法

- (UIImageView *)myBackImgView {
    
    if (!_myBackImgView) {
        _myBackImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"course_calendar_bg"]];
        _myBackImgView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 420);
        [_myBackImgView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _myBackImgView;
}

- (UIButton *)myLastMonthBtn {
    
    if (!_myLastMonthBtn) {
        _myLastMonthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _myLastMonthBtn.frame = CGRectMake(self.myDateLabel.frame.origin.x - (50 + 8), 49, 50, 50);
        [_myLastMonthBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_myLastMonthBtn setImage:[UIImage imageNamed:@"course_last_month"] forState:UIControlStateNormal];
        [_myLastMonthBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_myLastMonthBtn addTarget:self action:@selector(myLastMonthBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myLastMonthBtn;
}

- (UIButton *)myNextMonthBtn {
    
    if (!_myNextMonthBtn) {
        _myNextMonthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _myNextMonthBtn.frame = CGRectMake(self.myDateLabel.frame.origin.x + self.myDateLabel.frame.size.width + 8, 49, 50, 50);
        [_myNextMonthBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_myNextMonthBtn setImage:[UIImage imageNamed:@"course_next_month"] forState:UIControlStateNormal];
        [_myNextMonthBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_myNextMonthBtn addTarget:self action:@selector(myNextMonthBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myNextMonthBtn;
}

- (UILabel *)myDateLabel {
    
    if (!_myDateLabel) {
        _myDateLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 280/2, 49, 280, 50)];
        _myDateLabel.textColor = [UIColor whiteColor];
        _myDateLabel.font = [UIFont systemFontOfSize:24];
        _myDateLabel.textAlignment = NSTextAlignmentCenter;
        NSDateFormatter *form = [[NSDateFormatter alloc] init];
        [form setDateFormat:@"YYYY年MM月"];
        _myDateLabel.text = [form stringFromDate:self.myDate];
    }
    return _myDateLabel;
}

@end

