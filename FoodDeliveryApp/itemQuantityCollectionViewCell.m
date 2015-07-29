//
//  itemQuantityCollectionViewCell.m
//  FoodDeliveryApp
//
//  Created by Student on 7/23/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "itemQuantityCollectionViewCell.h"

@implementation itemQuantityCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:23]];
        [self.contentView addSubview:self.textLabel];
    }
    
    return self;
}

@end
