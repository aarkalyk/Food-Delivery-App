//
//  News.m
//  FoodDeliveryApp
//
//  Created by Student on 7/27/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "News.h"

@implementation News

-(instancetype)initWithTitle:(NSString *)title andText:(NSString *)text andImage:(UIImage *)image
{
    self = [super init];
    
    if (self) {
        self.title = title;
        self.text = text;
        self.image = image;
    }
    
    return self;
}

@end
