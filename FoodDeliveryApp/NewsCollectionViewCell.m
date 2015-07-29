//
//  NewsCollectionViewCell.m
//  FoodDeliveryApp
//
//  Created by Student on 7/27/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "NewsCollectionViewCell.h"

@implementation NewsCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.viewUpper = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 0.5f)];
        self.viewLower = [[UIView alloc] initWithFrame:CGRectMake(0, 50, CGRectGetWidth(frame), 0.5f)];
        self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, CGRectGetWidth(frame)-40, 20)];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame)-40, 10, 30, 30)];
        
        [self.contentView addSubview:self.viewUpper];
        [self.contentView addSubview:self.viewLower];
        [self.contentView addSubview:self.headerLabel];
        [self.contentView addSubview:self.imageView];
    }
    
    return self;
}

@end
