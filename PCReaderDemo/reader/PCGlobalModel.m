//
//  PCGlobalModel.m
//  PCReaderDemo
//
//  Created by 张培创 on 15/3/17.
//  Copyright (c) 2015年 com.duowan. All rights reserved.
//

#import "PCGlobalModel.h"
#import "NSString+PCPaging.h"

@implementation PCGlobalModel

+ (instancetype)shareModel
{
    static PCGlobalModel *model = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        model = [[PCGlobalModel alloc] init];
    });
    return model;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fontSize = 18;
    }
    return self;
}

- (void)loadText:(NSString *)text completion:(void (^)(void))completion
{
    self.text = text;
    [self pagingTextCompletion:completion];
}

- (void)pagingTextCompletion:(void (^)(void))completion
{
    NSMutableDictionary * attributes = [NSMutableDictionary dictionaryWithCapacity:5];
    UIFont * font = [UIFont systemFontOfSize:self.fontSize];
    [attributes setValue:font forKey:NSFontAttributeName];
    [attributes setValue:@(1.0) forKey:NSKernAttributeName];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5.0;
    paragraphStyle.paragraphSpacing = 10.0;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    [attributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
    self.attributes = [attributes copy];
    self.rangeArray = [[self.text paginationWithAttributes:self.attributes constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 10 * 2, [UIScreen mainScreen].bounds.size.height - 30 * 2)] mutableCopy];
    if (completion) {
        completion();
    }
}

- (void)updateFontCompletion:(void (^)(void))completion
{
    //取回之前的定位页数
    NSRange range = self.currentRange;
    [self pagingTextCompletion:^{
        //重新定位页码
        [self.rangeArray enumerateObjectsUsingBlock:^(NSString *rangeStr, NSUInteger idx, BOOL *stop) {
            NSRange tempRange = NSRangeFromString(rangeStr);
            if (tempRange.location <= range.location && tempRange.location + tempRange.length > range.location) {
                self.currentPage = idx;
                *stop = YES;
            }
        }];
        if (completion) {
            completion();
        }
    }];
}

- (void)setFontSize:(CGFloat)fontSize
{
    if (fontSize < 14.0) {
        _fontSize = 14.0;
    } else if (fontSize > 30.0) {
        _fontSize = 30.0;
    } else {
        _fontSize = fontSize;
    }
}

- (void)setCurrentRange:(NSRange)currentRange
{
    _currentRange = currentRange;
    NSLog(@"%@", NSStringFromRange(_currentRange));
}

@end
