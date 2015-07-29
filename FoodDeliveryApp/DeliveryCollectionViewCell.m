//
//  DeliveryCollectionViewCell.m
//  FoodDeliveryApp
//
//  Created by Student on 7/27/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "DeliveryCollectionViewCell.h"

@implementation DeliveryCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.workingHoursLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(frame)-10, 20)];
        [self.workingHoursLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        self.workingHoursTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, CGRectGetWidth(frame)-10, 20)];
        
        self.minimumOrderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, CGRectGetWidth(frame)-10, 20)];
        [self.minimumOrderLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        self.minimumOrderTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, CGRectGetWidth(frame)-10, 20)];
        
        self.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, CGRectGetWidth(frame)-10, 20)];
        [self.cityLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        
        self.streetsTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 120, CGRectGetWidth(frame)-10, 100)];
        self.mapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 220, CGRectGetWidth(frame), 400)];
        
        [self.contentView addSubview:self.workingHoursLabel];
        [self.contentView addSubview:self.workingHoursTextLabel];
        [self.contentView addSubview:self.minimumOrderLabel];
        [self.contentView addSubview:self.minimumOrderTextLabel];
        [self.contentView addSubview:self.cityLabel];
        [self.contentView addSubview:self.streetsTextView];
        [self.contentView addSubview:self.mapImageView];
    }
    
    return self;
}

@end
