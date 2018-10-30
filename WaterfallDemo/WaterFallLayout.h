//
//  WaterFallLayout.h
//  WaterfallDemo
//
//  Created by 李新 on 2018/10/20.
//  Copyright © 2018 liranhui. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef CGFloat(^ItemHeightBlock)(CGFloat itemWidth,NSIndexPath *indexPath);
NS_ASSUME_NONNULL_BEGIN

@interface WaterFallLayout : UICollectionViewLayout
//分区边距
@property(nonatomic,assign)UIEdgeInsets   sectionInset;
//列间距
@property(nonatomic,assign)CGFloat        columPadding;
//行间距
@property(nonatomic,assign)CGFloat        rowPadding;
@property(nonatomic,copy)ItemHeightBlock  heightBlock;
- (instancetype)initWithColum:(NSInteger)colum;
+ (instancetype)waterFallLayoutWithColum:(NSInteger)colum;
@end

NS_ASSUME_NONNULL_END
