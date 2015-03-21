//
//  PCPageView.h
//  PCPageDemo
//
//  Created by 张培创 on 15/3/10.
//  Copyright (c) 2015年 com.duowan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCPageView : UIView

@property (nonatomic, copy) NSAttributedString *attributedText;

- (void)setText:(NSAttributedString *)attributedText;

@end
