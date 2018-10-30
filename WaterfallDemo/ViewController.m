//
//  ViewController.m
//  WaterfallDemo
//
//  Created by 李新 on 2018/10/20.
//  Copyright © 2018 liranhui. All rights reserved.
//

#import "ViewController.h"
#import "WaterFallLayout.h"
#import "WaterCollectionViewCell.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic ,strong)UICollectionView   *collectionView;
@property(nonatomic ,strong)NSArray     *imageArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1.plist" ofType:nil];
    self.imageArray = [NSArray arrayWithContentsOfFile:path];
    [self.view addSubview:self.collectionView];
}
- (UICollectionView*)collectionView
{
    if(!_collectionView)
    {
        WaterFallLayout *layout = [WaterFallLayout waterFallLayoutWithColum:3];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.columPadding = 10;
        layout.rowPadding = 10;
        __weak typeof(self)weakSelf = self;
        layout.heightBlock = ^CGFloat(CGFloat itemWidth, NSIndexPath *indexPath) {
            NSInteger row = indexPath.row;
            NSDictionary *dict = weakSelf.imageArray[row];
            return itemWidth*[dict[@"h"] floatValue]/[dict[@"w"] floatValue];
        };
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"WaterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"waterCell"];
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"waterCell" forIndexPath:indexPath];
    cell.imageUrl = self.imageArray[indexPath.row][@"img"];
    return cell;
}
@end
