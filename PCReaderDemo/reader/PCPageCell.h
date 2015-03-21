//
//  PCPageCell.h
//  PCReaderDemo
//
//  Created by 张培创 on 15/3/17.
//  Copyright (c) 2015年 com.duowan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCPageView.h"

static NSString *PageCellIdentifier = @"PageCellIdentifier";

@interface PCPageCell : UICollectionViewCell

@property (nonatomic, strong) PCPageView *pageView;

@end
