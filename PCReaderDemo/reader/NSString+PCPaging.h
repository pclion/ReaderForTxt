//
//  NSString+PCPaging.h
//  PCReaderDemo
//
//  Created by 张培创 on 15/3/10.
//  Copyright (c) 2015年 com.duowan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (PCPaging)

- (NSArray *)paginationWithAttributes:(NSDictionary *)attributes constrainedToSize:(CGSize)size;

- (NSString *)halfWidthToFullWidth;

@end
