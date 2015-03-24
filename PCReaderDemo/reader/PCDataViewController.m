//
//  PCDataViewController.m
//  PCReaderDemo
//
//  Created by 张培创 on 15/3/9.
//  Copyright (c) 2015年 com.duowan. All rights reserved.
//

#import "PCDataViewController.h"
#import "PCGlobalModel.h"
#import "PCReaderTool.h"

@interface PCDataViewController ()

@property (nonatomic, strong) PCReaderTool *readerTool;

@end

@implementation PCDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pageView];
    [self.view addSubview:self.progressLabel];
    [self.view addSubview:self.timeLabel];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_pageView]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[_pageView]-40-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_progressLabel]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageView, _progressLabel)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_progressLabel]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageView, _progressLabel)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_timeLabel]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_timeLabel)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_timeLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_timeLabel)]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePage) name:kUpdatePageNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.pageView setAttributedText:[[NSAttributedString alloc] initWithString:self.dataObject attributes:self.attributes]];
    [self.progressLabel setText:[NSString stringWithFormat:@"%ld/%ld", (long)self.currentPage + 1, (long)self.totalPage]];
    
    [self.readerTool startMonitorTimeWithBlock:^(NSDate *currentDate) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString *datestr = [dateFormatter stringFromDate:currentDate];
        self.timeLabel.text = datestr;
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.readerTool stopMonitorTime];
}

- (void)updatePage
{
    [self.progressLabel setText:[NSString stringWithFormat:@"%ld/%ld", (long)[PCGlobalModel shareModel].currentPage + 1, (long)self.totalPage]];
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

- (UILabel *)progressLabel
{
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _progressLabel.font = [UIFont systemFontOfSize:14];
        _progressLabel.textColor = [UIColor blackColor];
    }
    return _progressLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = [UIColor blackColor];
    }
    return _timeLabel;
}

- (PCReaderTool *)readerTool
{
    if (!_readerTool) {
        _readerTool = [[PCReaderTool alloc] init];
    }
    return _readerTool;
}

@end
