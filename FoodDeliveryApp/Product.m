//
//  Product.m
//  FoodDeliveryApp
//
//  Created by Student on 7/20/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "Product.h"

@implementation Product

-(instancetype)initWithName:(NSString *)name andDescr:(NSString *)descr andImage:(UIImage *)image andQuan:(int)quantity isAdded:(BOOL)isAdded andPrice:(int)price{
    self = [super init];
    
    if (self) {
        self.name = name;
        self.descr = descr;
        self.image = image;
        self.quantity = quantity;
        self.price = price;
        self.isAdded = isAdded;
    }
    
    return self;
}

@end
