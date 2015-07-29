//
//  HistoryCollectionViewCell.h
//  FoodDeliveryApp
//
//  Created by Student on 7/22/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryCollectionViewCell : UICollectionViewCell

@property (nonatomic) UIView *viewUpper;
@property (nonatomic) UIView *viewLower;
@property (nonatomic) UILabel *dateLabel;
@property (nonatomic) UILabel *priceLabel;
@property (nonatomic) UIImageView *image;

@end
