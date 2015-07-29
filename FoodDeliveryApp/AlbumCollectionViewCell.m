//
//  AlbumCollectionViewCell.m
//  FoodDeliveryApp
//
//  Created by Student on 7/24/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "AlbumCollectionViewCell.h"

@implementation AlbumCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [self.contentView addSubview:self.imageView];
    }
    
    return self;
}

@end
