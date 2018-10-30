//
//  WaterFallLayout.m
//  WaterfallDemo
//
//  Created by 李新 on 2018/10/20.
//  Copyright © 2018 liranhui. All rights reserved.
//

#import "WaterFallLayout.h"
@interface WaterFallLayout()
//列数
@property(nonatomic,assign)NSInteger    colum;
//存放每个item的属性数组
@property(nonatomic,strong)NSMutableArray   *attributesArray;
//存放较短的那列及对应的高度
@property(nonatomic,strong)NSMutableDictionary *lowheightDict;
@end

@implementation WaterFallLayout
- (NSMutableArray*)attributesArray
{
    if(!_attributesArray)
    {
        _attributesArray = [[NSMutableArray alloc]init];
    }
    return _attributesArray;
}
- (NSMutableDictionary*)lowheightDict
{
    if(!_lowheightDict)
    {
        _lowheightDict = [[NSMutableDictionary alloc]init];
    }
    return _lowheightDict;
}
- (instancetype)init
{
    if(self=[super init])
    {
        self.colum = 2;
    }
    return self;
}
- (instancetype)initWithColum:(NSInteger)colum
{
    if(self = [super init])
    {
        self.colum = colum;
    }
    return self;
}
+ (instancetype)waterFallLayoutWithColum:(NSInteger)colum
{
    return [[self alloc] initWithColum:colum];
}
//初始化数据
- (void)prepareLayout
{
    [super prepareLayout];
    for (int index = 0; index<self.colum; index++)
    {
        self.lowheightDict[@(index)] = @(self.sectionInset.top);
    }
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    [self.attributesArray removeAllObjects];
    for (int itemIndex = 0; itemIndex<itemsCount; itemIndex++)
    {
        UICollectionViewLayoutAttributes*attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:itemIndex inSection:0]];
        [self.attributesArray addObject:attribute];
    }
}
- (CGSize)collectionViewContentSize
{
    //找出最长的那列对应的高度
    NSArray *keys = [self.lowheightDict allKeys];
    CGFloat maxHeight = 0;
    for (NSString*key in keys) {
        if([self.lowheightDict[key] floatValue]>maxHeight)
        {
            maxHeight = [self.lowheightDict[key] floatValue];
        }
    }
    return CGSizeMake(0, maxHeight+self.sectionInset.bottom);
}
- (UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //计算出最短的那一列索引
    NSArray *keys = [self.lowheightDict allKeys];
    NSInteger index = 0;
    for (NSString*key in keys)
    {
        if([self.lowheightDict[key] floatValue]<[self.lowheightDict[@(index)] floatValue])
        {
            index = [key integerValue];
        }
    }
    CGFloat collectionW = self.collectionView.frame.size.width;
    CGFloat itemW = (collectionW - self.sectionInset.left - self.sectionInset.right - (self.colum-1)*self.columPadding)/self.colum;
    CGFloat itemX = self.sectionInset.left+(itemW+self.columPadding)*index;
    CGFloat itemY = [self.lowheightDict[@(index)] floatValue]+self.rowPadding;
    CGFloat itemH = 0;
    if(self.heightBlock)
    {
        itemH = self.heightBlock(itemW,indexPath);
    }
    attribute.frame = CGRectMake(itemX, itemY, itemW, itemH);
    self.lowheightDict[@(index)] = @(CGRectGetMaxY(attribute.frame));
    return attribute;
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}
@end
