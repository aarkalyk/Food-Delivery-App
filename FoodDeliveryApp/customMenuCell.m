//
//  customMenuCell.m
//  FoodDeliveryApp
//
//  Created by Student on 7/20/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "itemQuantityCollectionViewCell.h"
#import "customMenuCell.h"

@implementation customMenuCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(frame)-100)/2.0f, 0, 100, 100)];
        self.gradientImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 100)];
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, 20)];
        self.name.textColor = [UIColor whiteColor];
        [self.name setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        self.price = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, 100, 20)];
        [self.price setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        self.price.textColor = [UIColor whiteColor];
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.clipsToBounds = YES;
        
        self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake((CGRectGetMaxX(frame)*0.9f), 35, 30, 30)];
        self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(frame)*1.1f, 35, 30, 30)];
        self.hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.hiddenButton.clipsToBounds = YES;
        self.hiddenButton.layer.cornerRadius = 30/2.0f;
        self.hiddenButton.frame = CGRectMake((CGRectGetMaxX(frame)-50), 10, 30, 30);
        
        //half of the width
        self.button.layer.cornerRadius = 30/2.0f;
        self.button.frame = CGRectMake(CGRectGetMaxX(frame)-50, 10, 30, 30);
        
        //initializing the collectionview
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = frame.size;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)) collectionViewLayout:flowLayout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.collectionView.pagingEnabled = YES;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        
        [self.collectionView registerClass:[itemQuantityCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.gradientImageView];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.price];
        [self.contentView addSubview:self.button];
        
        [self.contentView addSubview:self.collectionView];
        
        [self.contentView addSubview:self.rightButton];
        [self.contentView addSubview:self.leftButton];
        [self.contentView addSubview:self.hiddenButton];
    }
    
    return self;
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    itemQuantityCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.collectionView.frame.size;
}



@end
