//
//  MoreItem.m
//  FoodDeliveryApp
//
//  Created by Student on 7/27/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "MoreItem.h"

@implementation MoreItem

-(instancetype)initWithName:(NSString *)name andRusName:(NSString *)rusName andImage:(NSString *)imageName{
    self = [super init];
    
    if (self) {
        self.name = name;
        self.rusName = rusName;
        self.imageName = imageName;
    }
    
    return self;
}

@end
