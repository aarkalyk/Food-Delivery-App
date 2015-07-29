//
//  MapViewController.m
//  FoodDeliveryApp
//
//  Created by Student on 7/24/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.restaurant.coordinate, 1000.0, 1000.0);
    
    [self.mapView setRegion:region];
     self.mapView.delegate = self;
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:self.restaurant.coordinate];
    [self.mapView addAnnotation:annotation];
    
    //[self.mapView addAnnotation:self.restaurant.coordinate];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - MKMapView delegate methods
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
        annotationView.canShowCallout = YES;
        annotationView.calloutOffset = CGPointMake(-5.0, 5.0);
    }else{
        annotationView.annotation = annotation;
    }
    
    return annotationView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
