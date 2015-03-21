//
//  PCCollectViewModel.m
//  PCReaderDemo
//
//  Created by 张培创 on 15/3/17.
//  Copyright (c) 2015年 com.duowan. All rights reserved.
//

#import "PCCollectViewModel.h"
#import "PCPageCell.h"
#import "PCGlobalModel.h"

@interface PCCollectViewModel ()

@end

@implementation PCCollectViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PCPageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PageCellIdentifier forIndexPath:indexPath];
    NSString *subText = [self.text substringWithRange:NSRangeFromString(self.dataArray[indexPath.row])];
    [cell.pageView setText:[[NSAttributedString alloc] initWithString:subText attributes:self.attributes]];
    
    return cell;
}

@end
