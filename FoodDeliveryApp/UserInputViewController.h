//
//  UserInputViewController.h
//  FoodDeliveryApp
//
//  Created by Student on 7/21/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInputViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic) int totalPrice;
@property (nonatomic) NSMutableArray *emailArray;

@end
