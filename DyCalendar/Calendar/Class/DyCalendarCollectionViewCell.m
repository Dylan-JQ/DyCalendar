//
//  DyCalendarCollectionViewCell.m
//  TestProject
//
//  Created by Dylan_W on 2019/4/18.
//  Copyright © 2019 nipaiyi. All rights reserved.
//

#import "DyCalendarCollectionViewCell.h"
#import "DyCalendarDaysModel.h"

#define SelectView_Width 28
#define Tag_Width 6

@interface DyCalendarCollectionViewCell ()

/// 我的标题标签.
@property (nonatomic, strong) UILabel *myTitleLabel;

/// 我的选择的标记.
@property (nonatomic, strong) UIView *mySelectedTag;

/// 我的点标记.
@property (nonatomic, strong) UIView *myPointTag;

@end

@implementation DyCalendarCollectionViewCell

#pragma mark - 构造方法

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {

        [self.contentView addSubview:self.mySelectedTag];
        self.mySelectedTag.center = CGPointMake(self.contentView.frame.size.width/2, self.contentView.frame.size.height/2);
        [self.contentView addSubview:self.myTitleLabel];
        self.myTitleLabel.center = CGPointMake(self.contentView.frame.size.width/2, self.contentView.frame.size.height/2);
        [self.contentView addSubview:self.myPointTag];
    }
    return self;
}

- (void)setCellContentWithModel:(DyCalendarDaysModel *)model {
    
    if (model.type == PGCalendarDaysTypeThisMonth) {
        self.myTitleLabel.text = model.title;
        self.myTitleLabel.textColor = [UIColor whiteColor];
        if (model.isSelected) {
            self.mySelectedTag.hidden = NO;
            self.myTitleLabel.textColor = [UIColor colorWithRed:233/255.0 green:33/255.0 blue:33/255.0 alpha:1];
        }else {
            self.mySelectedTag.hidden = YES;
            self.myTitleLabel.textColor = [UIColor whiteColor];
        }
        if (model.isTag) {
            self.myPointTag.hidden = NO;
        }else {
            self.myPointTag.hidden = YES;
        }
    }else {
        self.myTitleLabel.text = @"";
        self.myPointTag.hidden = YES;
        self.mySelectedTag.hidden = YES;
    }
}

#pragma mark - Setter/Getter方法

- (UILabel *)myTitleLabel {
    
    if (!_myTitleLabel) {
        _myTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width/2 - SelectView_Width/2, 4, SelectView_Width, SelectView_Width)];
        _myTitleLabel.font = [UIFont systemFontOfSize:16];
        _myTitleLabel.textColor = [UIColor whiteColor];
        _myTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _myTitleLabel;
}

- (UIView *)mySelectedTag {
    
    if (!_mySelectedTag) {
        _mySelectedTag = [[UIView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width/2 - SelectView_Width/2, 4, SelectView_Width, SelectView_Width)];
        _mySelectedTag.backgroundColor = [UIColor whiteColor];
        _mySelectedTag.layer.cornerRadius = 6.0;
        _mySelectedTag.hidden = YES;
    }
    return _mySelectedTag;
}

- (UIView *)myPointTag {
    
    if (!_myPointTag) {
        _myPointTag = [[UIView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width/2 - Tag_Width/2, self.mySelectedTag.frame.origin.y + self.mySelectedTag.frame.size.height + 3, Tag_Width, Tag_Width)];
        _myPointTag.backgroundColor = [UIColor whiteColor];
        _myPointTag.hidden = YES;
        _myPointTag.layer.cornerRadius = Tag_Width/2;
    }
    return _myPointTag;
}

@end
