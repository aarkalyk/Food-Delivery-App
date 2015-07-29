//
//  cartViewController.h
//  FoodDeliveryApp
//
//  Created by Student on 7/21/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cartViewController : UIViewController

@property (nonatomic) NSMutableArray *orderNames;
@property (nonatomic) NSMutableArray *orderPrices;
@property (nonatomic) NSMutableArray *orderQuantities;

@end
