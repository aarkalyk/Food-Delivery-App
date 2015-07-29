//
//  MoreItem.h
//  FoodDeliveryApp
//
//  Created by Student on 7/27/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MoreItem : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *imageName;

-(instancetype) initWithName:(NSString *)name andImage:(NSString *)imageName;

@end
