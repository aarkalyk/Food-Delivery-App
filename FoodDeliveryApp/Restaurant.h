//
//  Restaurant.h
//  FoodDeliveryApp
//
//  Created by Student on 7/24/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Restaurant : NSObject <MKAnnotation>

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *phoneNo;
@property (nonatomic) NSString *workHours;
@property (nonatomic) NSString *addressString;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) UIImage *mainImage;
@property (nonatomic) NSMutableArray *images;

-(instancetype) initWithName:(NSString *)name andWorkHours:(NSString *)workHours andAddressString:(NSString *)addressString andCoordinate:(CLLocationCoordinate2D )coordinate anMainImage:(UIImage *)mainImage andImagesArray:(NSMutableArray *)images andPhoneNo:(NSString *)phoneNo;

@end
