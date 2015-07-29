//
//  DeliveryCollectionViewCell.h
//  FoodDeliveryApp
//
//  Created by Student on 7/27/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeliveryCollectionViewCell : UICollectionViewCell

@property (nonatomic) UILabel *workingHoursLabel;
@property (nonatomic) UILabel *workingHoursTextLabel;
@property (nonatomic) UILabel *minimumOrderLabel;
@property (nonatomic) UILabel *minimumOrderTextLabel;
@property (nonatomic) UILabel *cityLabel;
@property (nonatomic) UITextView *streetsTextView;
@property (nonatomic) UIImageView *mapImageView;

@end
