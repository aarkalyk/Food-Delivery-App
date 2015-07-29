//
//  QuantityCollectionViewCell.m
//  FoodDeliveryApp
//
//  Created by Student on 7/22/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "QuantityCollectionViewCell.h"

@implementation QuantityCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(frame)-100)/2.0f, 160, 100, 100)];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.textLabel];
    }
    
    return self;
}

@end
