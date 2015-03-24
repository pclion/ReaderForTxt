//
//  NSString+PCPaging.m
//  PCReaderDemo
//
//  Created by 张培创 on 15/3/10.
//  Copyright (c) 2015年 com.duowan. All rights reserved.
//

#import "NSString+PCPaging.h"
#import <CoreText/CoreText.h>

@implementation NSString (PCPaging)

/**
 * @abstract 根据指定的大小,对字符串进行分页,计算出每页显示的字符串区间(NSRange)
 *
 * @param    attributes  分页所需的字符串样式,需要指定字体大小,行间距等。iOS6.0以上请参见UIKit中NSAttributedString的扩展,iOS6.0以下请参考CoreText中的CTStringAttributes.h
 * @param    size        需要参考的size。即在size区域内
 */
- (NSArray *)paginationWithAttributes:(NSDictionary *)attributes constrainedToSize:(CGSize)size  {
    NSMutableArray * resultRange = [NSMutableArray arrayWithCapacity:5];
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    // 构造NSAttributedString
    NSAttributedString * attributedString = [[NSAttributedString alloc] initWithString:self attributes:attributes];
    
    //    以下方法耗时 基本再 0.5s 以内
    NSDate * date = [NSDate date];
    NSInteger rangeIndex = 0;
    do {
        //TODO      需要根据具体字号对最小值就行分别设定
        unsigned long length = MIN(750, attributedString.length - rangeIndex);
        NSAttributedString * childString = [attributedString attributedSubstringFromRange:NSMakeRange(rangeIndex, length)];
        
        CTFramesetterRef childFramesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) childString);
        UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRect:rect];
        CTFrameRef frame = CTFramesetterCreateFrame(childFramesetter, CFRangeMake(0, 0), bezierPath.CGPath, NULL);
        
        CFRange range = CTFrameGetVisibleStringRange(frame);
        NSRange r = {rangeIndex, range.length};
        
        if (r.length > 0) {
            [resultRange addObject:NSStringFromRange(r)];
        }
        rangeIndex += r.length;
        CFRelease(frame);
        CFRelease(childFramesetter);
    } while (rangeIndex < attributedString.length && attributedString.length > 0);
    NSTimeInterval millionSecond = [[NSDate date] timeIntervalSinceDate:date];
    NSLog(@"耗时 %@", [NSString stringWithFormat:@"%lf", millionSecond]);
    return resultRange;
}

- (NSString *)halfWidthToFullWidth
{
    //半角转全角
    NSMutableString *convertedString = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)convertedString, NULL, kCFStringTransformHiraganaKatakana, false);
    return [convertedString copy];
}

@end
