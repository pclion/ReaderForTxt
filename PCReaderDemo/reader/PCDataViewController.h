//
//  PCDataViewController.h
//  PCReaderDemo
//
//  Created by 张培创 on 15/3/9.
//  Copyright (c) 2015年 com.duowan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCPageView.h"

@interface PCDataViewController : UIViewController

@property (strong, nonatomic) id dataObject;
@property (strong, nonatomic) NSDictionary *attributes;
@property (strong, nonatomic) PCPageView *pageView;
@property (strong, nonatomic) UILabel *progressLabel;
@property (strong, nonatomic) UILabel *timeLabel;

@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSInteger totalPage;

@end
