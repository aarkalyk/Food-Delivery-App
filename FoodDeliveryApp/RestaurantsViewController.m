//
//  RestaurantsViewController.m
//  
//
//  Created by Student on 7/24/15.
//
//
#import "RestaurantDetailViewController.h"
#import "RestaurantCollectionViewCell.h"
#import "RestaurantsViewController.h"
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import "Restaurant.h"

@interface RestaurantsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MKMapViewDelegate>

@property (nonatomic) Restaurant *tempRestaurant;

@property (nonatomic) NSMutableArray *images;
@property (nonatomic) NSMutableArray *names;

@property (nonatomic) UIImage *image1;
@property (nonatomic) UIImage *image2;
@property (nonatomic) UIImage *image3;
@property (nonatomic) UIImage *mainImage;

@property (nonatomic) NSMutableArray *restaurants;
@property (nonatomic) NSMutableArray *localObjects;
@property (nonatomic) NSMutableArray *namesFromParse;
@property (nonatomic) NSMutableArray *restaurantImages;
@property (weak, nonatomic) IBOutlet UIButton *cartButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *placeHolderImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoPlaceHolder;

@end

@implementation RestaurantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.images = [NSMutableArray new];
    self.names = [NSMutableArray new];
    
    [self.cartButton setImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
    self.cartButton.frame = CGRectMake(0, 0, 44, 44);
    
    self.logoPlaceHolder.image = [UIImage imageNamed:@"logo.png"];
    self.logoPlaceHolder.hidden = NO;
    self.placeHolderImageView.image = [UIImage imageNamed:@"placeHolderWhite.png"];
    self.placeHolderImageView.hidden = NO;
    
    self.restaurantImages = [NSMutableArray new];
    self.restaurants = [NSMutableArray new];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[RestaurantCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    [self getDataFromLocalDataStore];
    [self downloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper methods
-(void) hidePlaceHolder{
    self.placeHolderImageView.alpha = 1.0f;
    self.logoPlaceHolder.alpha = 1.0f;
    // Then fades it away after 2 seconds (the cross-fade animation will take 0.5s)
    [UIView animateWithDuration:0.5 delay:1.0 options:0 animations:^{
        // Animate the alpha value of your imageView from 1.0 to 0.0 here
        self.logoPlaceHolder.alpha = 0.0f;
        self.placeHolderImageView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
        self.placeHolderImageView.hidden = YES;
        self.logoPlaceHolder.hidden = YES;
    }];
}

#pragma mark - Parse methods
-(void) downloadData{
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurants"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *name = object[@"name"];
                NSString *phoneNo = object[@"phoneNo"];
                NSString *workHours = object[@"workHours"];
                NSString *addressString = object[@"addressString"];
                PFGeoPoint *coordinate = object[@"addressGeoPoint"];
                NSLog(@"%@", name);
                
                BOOL exists = NO;
                for (int i =0; i < self.restaurants.count; i++) {
                    Restaurant *tempRestaurant = self.restaurants[i];
                    if ([tempRestaurant.name isEqualToString:name]) {
                        NSLog(@"exists");
                        exists = YES;
                    }
                }
                
                if (!exists) {
                    PFFile *file = object[@"mainImage"];
                    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        self.mainImage = [UIImage imageWithData:data];
                        [self.images addObject:self.mainImage];
                        [self.names addObject:name];
                        NSLog(@"size of images %zd", self.images.count);
                        NSLog(@"size of names %zd", self.names.count);
                        [self hidePlaceHolder];
                        [self.collectionView reloadData];
                    }];
                    
                    PFFile *file1 = object[@"image1"];
                    self.image1 = [UIImage imageWithData:[file1 getData]];
                    [self addImage:self.image1];
                    
                    
                    PFFile *file2 = object[@"image2"];
                    self.image2 = [UIImage imageWithData:[file2 getData]];
                    [self addImage:self.image2];
                    
                    PFFile *file3 = object[@"image3"];
                    self.image3 = [UIImage imageWithData:[file3 getData]];
                    [self addImage:self.image3];
                    Restaurant *restaurant = [[Restaurant alloc] initWithName:name andWorkHours:workHours andAddressString:addressString andCoordinate:CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude) anMainImage:self.mainImage andImagesArray:self.restaurantImages andPhoneNo:phoneNo];
                    [object pinInBackground];
                    [self addRestaurant:restaurant];
                }
                [self.namesFromParse addObject:name];
            }
            [self updateLocalData];
        }
    }];
}

-(void)getDataFromLocalDataStore{
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurants"];
    [query fromLocalDatastore];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *name = object[@"name"];
                NSString *phoneNo = object[@"phoneNo"];
                NSString *workHours = object[@"workHours"];
                NSString *addressString = object[@"addressString"];
                PFGeoPoint *coordinate = object[@"addressGeoPoint"];
                NSLog(@"%@", name);
                
                PFFile *file = object[@"mainImage"];
                [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    self.mainImage = [UIImage imageWithData:data];
                    [self.images addObject:self.mainImage];
                    [self.names addObject:name];
                    NSLog(@"size of images %zd", self.images.count);
                    NSLog(@"size of names %zd", self.names.count);
                    [self hidePlaceHolder];
                    [self.collectionView reloadData];
                }];
                
                PFFile *file1 = object[@"image1"];
                self.image1 = [UIImage imageWithData:[file1 getData]];
                [self addImage:self.image1];
                
                
                PFFile *file2 = object[@"image2"];
                self.image2 = [UIImage imageWithData:[file2 getData]];
                [self addImage:self.image2];
                
                PFFile *file3 = object[@"image3"];
                self.image3 = [UIImage imageWithData:[file3 getData]];
                [self addImage:self.image3];
                Restaurant *restaurant = [[Restaurant alloc] initWithName:name andWorkHours:workHours andAddressString:addressString andCoordinate:CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude) anMainImage:self.mainImage andImagesArray:self.restaurantImages andPhoneNo:phoneNo];
                [self addRestaurant:restaurant];
                [self.localObjects addObject:object];
            }
        }
    }];
}

-(void)updateLocalData{
    BOOL exists = NO;
    for (int i = 0; i < self.restaurants.count; i++) {
        for (int j = 0; j < self.namesFromParse.count; j++) {
            Restaurant *restaurant = self.restaurants[i];
            if ([restaurant.name isEqualToString:self.namesFromParse[j]]) {
                exists = YES;
            }
        }
        if (!exists) {
            [self deletObjectFromLocal:self.localObjects[i]];
            [self.localObjects removeObjectAtIndex:i];
            [self.restaurants removeObjectAtIndex:i];
            [self.collectionView reloadData];
        }
    }
}

-(void)deletObjectFromLocal:(PFObject *)object{
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurants"];
    [query fromLocalDatastore];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [object unpinInBackground];
    }];
}

-(void) addImage:(UIImage *) image{
    if (self.restaurantImages.count == 3) {
        self.restaurantImages = [NSMutableArray new];
    }
    
    [self.restaurantImages addObject:image];
    NSLog(@"size of an array %zd", self.restaurantImages.count);
}

-(void) addRestaurant:(Restaurant *)restaurant{
    [self.restaurants addObject:restaurant];
    [self.collectionView reloadData];
}

#pragma mark - Collectionview delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.names.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RestaurantCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    //Restaurant *restaurant = self.restaurants[indexPath.row];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"  %@",self.names[indexPath.row]];
    cell.nameLabel.textColor = [UIColor whiteColor];
    cell.nameLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [cell.nameLabel setFont:[UIFont fontWithName:@"Helvetica-UltraLight" size:25]];
    
    cell.imageView.image = self.images[indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.tempRestaurant = self.restaurants[indexPath.row];
    [self performSegueWithIdentifier:@"restaurantDetails" sender:self];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 150);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - Segue methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[RestaurantDetailViewController class]]) {
        RestaurantDetailViewController *VC = segue.destinationViewController;
        VC.restaurant = self.tempRestaurant;
    }
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
