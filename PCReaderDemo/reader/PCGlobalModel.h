//
//  PCGlobalModel.h
//  PCReaderDemo
//
//  Created by 张培创 on 15/3/17.
//  Copyright (c) 2015年 com.duowan. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kUpdatePageNotification = @"kUpdatePageNotification";

@interface PCGlobalModel : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSMutableArray *rangeArray;
@property (nonatomic, strong) NSDictionary *attributes;
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSRange currentRange;     //尚未使用

+ (instancetype)shareModel;

- (void)loadText:(NSString *)text completion:(void(^)(void))completion;

- (void)updateFontCompletion:(void(^)(void))completion;

@end
