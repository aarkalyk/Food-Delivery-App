//
//  cartCollectionViewCell.h
//  FoodDeliveryApp
//
//  Created by Student on 7/21/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cartCollectionViewCell : UICollectionViewCell

@property (nonatomic) UIView *view;

@property (nonatomic) UILabel *name;
@property (nonatomic) UILabel *price;

@property (nonatomic) UIButton *addButton;
@property (nonatomic) UIButton *subtractButton;

@end
