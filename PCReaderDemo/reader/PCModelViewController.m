//
//  PCModelViewController.m
//  PCReaderDemo
//
//  Created by 张培创 on 15/3/9.
//  Copyright (c) 2015年 com.duowan. All rights reserved.
//

#import "PCModelViewController.h"
#import "PCGlobalModel.h"

@interface PCModelViewController ()

@end

@implementation PCModelViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        // Create the data model.
    }
    return self;
}

- (PCDataViewController *)viewControllerAtIndex:(NSUInteger)index {
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PCDataViewController *dataViewController = [[PCDataViewController alloc] init];
    dataViewController.dataObject = [self.text substringWithRange:NSRangeFromString(self.pageData[index])];
    dataViewController.attributes = self.attributes;
    dataViewController.currentPage = index;
    dataViewController.totalPage = [self.pageData count];
    [PCGlobalModel shareModel].currentPage = index;
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(PCDataViewController *)viewController {
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:NSStringFromRange([self.text rangeOfString:viewController.dataObject])];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(PCDataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    [PCGlobalModel shareModel].currentRange = NSRangeFromString(self.pageData[index]);
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(PCDataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    [PCGlobalModel shareModel].currentRange = NSRangeFromString(self.pageData[index]);
    return [self viewControllerAtIndex:index];
}

@end
