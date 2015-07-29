//
//  customMenuCell.h
//  FoodDeliveryApp
//
//  Created by Student on 7/20/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customMenuCell : UICollectionViewCell<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIImageView *gradientImageView;
@property (nonatomic) UILabel *name;
@property (nonatomic) UILabel *price;
@property (nonatomic) UIButton *button;

@property (nonatomic) UIButton *rightButton;
@property (nonatomic) UIButton *leftButton;
@property (nonatomic) UIButton *hiddenButton;

@property (nonatomic) UICollectionView *collectionView;

@end
