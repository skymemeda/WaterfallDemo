//
//  WaterCollectionViewCell.m
//  WaterfallDemo
//
//  Created by 李新 on 2018/10/20.
//  Copyright © 2018 liranhui. All rights reserved.
//

#import "WaterCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface WaterCollectionViewCell()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation WaterCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
}
@end
