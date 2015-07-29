//
//  MenuItem.h
//  FoodDeliveryApp
//
//  Created by Student on 7/20/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MenuItem : NSObject
@property (nonatomic) NSString *name;
@property (nonatomic) UIImage *image;

-(instancetype) initWithName:(NSString *) name andImage:(UIImage *) image;
@end
