//
//  PCModelViewController.h
//  PCReaderDemo
//
//  Created by 张培创 on 15/3/9.
//  Copyright (c) 2015年 com.duowan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCDataViewController.h"
#import "PCReaderViewController.h"

#define kAdjustFontNotification     @"kAdjustFontNotification"

@interface PCModelViewController : NSObject<UIPageViewControllerDataSource>

@property (weak, nonatomic) PCReaderViewController *readerController;
@property (strong, nonatomic) NSArray *pageData;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSDictionary *attributes;

- (PCDataViewController *)viewControllerAtIndex:(NSUInteger)index;

- (NSUInteger)indexOfViewController:(PCDataViewController *)viewController;

@end
