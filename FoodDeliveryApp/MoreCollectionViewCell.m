//
//  MoreCollectionViewCell.m
//  FoodDeliveryApp
//
//  Created by Student on 7/27/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "MoreCollectionViewCell.h"

@implementation MoreCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(70, 20, CGRectGetWidth(frame), 40)];
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (CGRectGetHeight(frame)-40)/2.0f, 40, 40)];
        self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame)-40, (CGRectGetHeight(frame)-40)/2.0f, 40, 40)];
        self.line = [[UIView alloc] initWithFrame:CGRectMake(20, 80, CGRectGetWidth(frame)-20, 1)];
        
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.arrowImageView];
    }
    return self;
}

@end
