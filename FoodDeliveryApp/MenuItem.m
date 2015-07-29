//
//  MenuItem.m
//  FoodDeliveryApp
//
//  Created by Student on 7/20/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

-(instancetype)initWithName:(NSString *)name andImage:(UIImage *)image{
    self = [super init];
    
    if (self) {
        self.name = name;
        self.image = image;
    }
    
    return self;
}

@end
