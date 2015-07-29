//
//  Product.h
//  FoodDeliveryApp
//
//  Created by Student on 7/20/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Product : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *descr;
@property (nonatomic) UIImage *image;
@property (nonatomic) BOOL isAdded;
@property (nonatomic) int quantity;
@property (nonatomic) int price;

-(instancetype) initWithName:(NSString *)name andDescr:(NSString *)descr andImage:(UIImage *)image andQuan:(int)quantity isAdded:(BOOL)isAdded andPrice:(int)price;

@end
