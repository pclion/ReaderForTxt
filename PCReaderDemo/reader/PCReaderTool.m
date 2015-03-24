//
//  PCReaderTool.m
//  OJia
//
//  Created by 张培创 on 15/3/23.
//  Copyright (c) 2015年 com.ojia. All rights reserved.
//

#import "PCReaderTool.h"

@interface PCReaderTool ()

@property (nonatomic, copy) BatteryMonitorBlock monitorBlock;
@property (nonatomic, copy) TimeMonitorBlock timeBlock;
@property (nonatomic) BOOL timeMonitorStop;

@end

@implementation PCReaderTool

- (void)startMonitorBatteryWithBlock:(BatteryMonitorBlock)block
{
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    [device addObserver:self forKeyPath:@"batteryLevel" options:0x0 context:nil];
    self.monitorBlock = block;
    if (self.monitorBlock) {
        self.monitorBlock(device.batteryLevel);
    }
}

- (void)stopMonitorBattery
{
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = NO;
    [device removeObserver:self forKeyPath:@"batteryLevel"];
}

- (void)startMonitorTimeWithBlock:(TimeMonitorBlock)block
{
    self.timeBlock = block;
    self.timeMonitorStop = NO;
    [self monitorTime];
}

- (void)stopMonitorTime
{
    self.timeMonitorStop = YES;
}

- (void)monitorTime
{
    NSDate *date = [NSDate date];
    if (self.timeBlock) {
        self.timeBlock(date);
    }
    if (self.timeMonitorStop) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self monitorTime];
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    UIDevice *device = [UIDevice currentDevice];
    if ([object isEqual:device] && [keyPath isEqual:@"batteryLevel"]) {
        if (self.monitorBlock) {
            self.monitorBlock(device.batteryLevel);
        }
    }  
}

@end
