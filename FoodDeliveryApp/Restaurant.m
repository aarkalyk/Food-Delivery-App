//
//  Restaurant.m
//  FoodDeliveryApp
//
//  Created by Student on 7/24/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

-(instancetype)initWithName:(NSString *)name andWorkHours:(NSString *)workHours andAddressString:(NSString *)addressString andCoordinate:(CLLocationCoordinate2D)coordinate anMainImage:(UIImage *)mainImage andImagesArray:(NSMutableArray *)images andPhoneNo:(NSString *)phoneNo{
    self = [super init];
    
    if (self) {
        self.name = name;
        self.workHours = workHours;
        self.addressString = addressString;
        self.coordinate = coordinate;
        self.mainImage = mainImage;
        self.phoneNo = phoneNo;
        self.images = [[NSMutableArray alloc] initWithArray:images];
    }
    
    return self;
}

@end
