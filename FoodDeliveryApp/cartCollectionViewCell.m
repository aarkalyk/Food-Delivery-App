//
//  cartCollectionViewCell.m
//  FoodDeliveryApp
//
//  Created by Student on 7/21/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "cartCollectionViewCell.h"

@implementation cartCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 0.5f)];
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 140, 20)];
        self.price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame)-120, 10, 100, 20)];
        
        //rounding buttons
        self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.subtractButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.addButton.clipsToBounds = YES;
        self.subtractButton.clipsToBounds = YES;
        self.addButton.layer.cornerRadius = 30/2.0f;
        self.subtractButton.layer.cornerRadius = 30/2.0f;
        
        self.addButton.frame = CGRectMake((CGRectGetWidth(frame)-40), 5, 30, 30);
        self.subtractButton.frame = CGRectMake(8, 5, 30, 30);
        
        [self.addButton setTitle:@"+" forState:UIControlStateNormal];
        [self.subtractButton setTitle:@"—" forState:UIControlStateNormal];
        [self.addButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
        [self.subtractButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
        
        [self.contentView addSubview:self.view];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.price];
        [self.contentView addSubview:self.addButton];
        [self.contentView addSubview:self.subtractButton];
    }
    
    return self;
}

@end
