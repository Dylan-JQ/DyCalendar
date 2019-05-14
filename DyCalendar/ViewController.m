//
//  ViewController.m
//  DyCalendar
//
//  Created by 纪前 on 2019/5/13.
//  Copyright © 2019 dylan. All rights reserved.
//

#import "ViewController.h"
#import "DyCalendarHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //日历控件加载
    DyCalendarView *calendarView = [[DyCalendarView alloc] initWithFrame:CGRectZero date:[NSDate date]];
    [self.view addSubview:calendarView];
}


@end
