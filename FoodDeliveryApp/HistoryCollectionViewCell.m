//
//  HistoryCollectionViewCell.m
//  FoodDeliveryApp
//
//  Created by Student on 7/22/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "HistoryCollectionViewCell.h"

@implementation HistoryCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.viewUpper = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 0.5f)];
        self.viewLower = [[UIView alloc] initWithFrame:CGRectMake(0, 30, CGRectGetWidth(frame), 0.5f)];
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 140, 20)];
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame)-140, 5, 100, 20)];
        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame)-40, 5, 30, 20)];
    }
    
    [self.contentView addSubview:self.viewUpper];
    [self.contentView addSubview:self.viewLower];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.image];
    
    return self;
}

@end
