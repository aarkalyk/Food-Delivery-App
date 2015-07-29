//
//  RestaurantCollectionViewCell.m
//  FoodDeliveryApp
//
//  Created by Student on 7/24/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "RestaurantCollectionViewCell.h"

@implementation RestaurantCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, CGRectGetWidth(frame), 30)];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 150)];
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.nameLabel];
    }
    
    return self;
}

@end
