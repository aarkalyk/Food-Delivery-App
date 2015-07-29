//
//  FoodDescriptionViewController.h
//  FoodDeliveryApp
//
//  Created by Student on 7/20/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodDescriptionViewController : UIViewController
@property (nonatomic) int price;
@property (nonatomic) int quan;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *descr;
@end
