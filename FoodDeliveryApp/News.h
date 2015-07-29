//
//  News.h
//  FoodDeliveryApp
//
//  Created by Student on 7/27/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface News : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *text;
@property (nonatomic) UIImage *image;

-(instancetype) initWithTitle:(NSString *)title andText:(NSString *)text andImage:(UIImage *)image;

@end
