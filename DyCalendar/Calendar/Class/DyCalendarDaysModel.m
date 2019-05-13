//
//  DyCalendarDaysModel.m
//  TestProject
//
//  Created by Dylan_W on 2019/4/18.
//  Copyright © 2019 nipaiyi. All rights reserved.
//

#import "DyCalendarDaysModel.h"

@implementation DyCalendarDaysModel

- (instancetype)initWithID:(NSInteger)mid title:(NSString *)title type:(PGCalendarDaysType)type {
    
    self = [super init];
    if (self) {
        self.mId = mid;
        self.title = title;
        self.type = type;
    }
    return self;
}

@end
