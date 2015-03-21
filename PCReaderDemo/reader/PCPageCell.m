//
//  PCPageCell.m
//  PCReaderDemo
//
//  Created by 张培创 on 15/3/17.
//  Copyright (c) 2015年 com.duowan. All rights reserved.
//

#import "PCPageCell.h"

@implementation PCPageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.pageView];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_pageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageView)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_pageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageView)]];
    }
    return self;
}

#pragma mark - lazy loading

- (PCPageView *)pageView
{
    if (!_pageView) {
        _pageView = [[PCPageView alloc] init];
        _pageView.translatesAutoresizingMaskIntoConstraints = NO;
        _pageView.backgroundColor = [UIColor whiteColor];
    }
    return _pageView;
}

@end
