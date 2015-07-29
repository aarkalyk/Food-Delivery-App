//
//  RestaurantDetailViewController.m
//  FoodDeliveryApp
//
//  Created by Student on 7/24/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "AlbumCollectionViewCell.h"
#import "MapViewController.h"

@interface RestaurantDetailViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *albumCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *cartButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIImageView *timeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pinImageView;
@property (weak, nonatomic) IBOutlet UIImageView *phoneImageView;

@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImageView2;

@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UIButton *pinButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation RestaurantDetailViewController

- (void)viewDidLoad {
    
    if (CGRectGetHeight(self.view.frame) == 480) {
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), 250);
        self.rightArrowImageView1.image = [UIImage imageNamed:@"rightarrowSmall.png"];
        self.rightArrowImageView2.image = [UIImage imageNamed:@"rightarrowSmall.png"];
    }else if (CGRectGetHeight(self.view.frame) == 568){
        self.rightArrowImageView1.image = [UIImage imageNamed:@"rightarrowSmall.png"];
        self.rightArrowImageView2.image = [UIImage imageNamed:@"rightarrowSmall.png"];
    } 
    
    [self.pinButton setTitle:@"" forState:UIControlStateNormal];
    [self.phoneButton setTitle:@"" forState:UIControlStateNormal];
    
    self.timeImageView.image = [UIImage imageNamed:@"clock.png"];
    self.pinImageView.image = [UIImage imageNamed:@"pin.png"];
    self.phoneImageView.image = [UIImage imageNamed:@"phone.png"];
    
    
    
    self.timelabel.text = [NSString stringWithFormat:@" %@", self.restaurant.workHours];
    self.addressLabel.text = [NSString stringWithFormat:@" %@", self.restaurant.addressString];
    self.phoneLabel.text = [NSString stringWithFormat:@" %@", self.restaurant.phoneNo];
    self.timelabel.backgroundColor = [UIColor clearColor];
    self.addressLabel.backgroundColor = [UIColor clearColor];
    self.phoneLabel.backgroundColor = [UIColor clearColor];
    
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.nameLabel.text = self.restaurant.name;
    
    [self.cartButton setImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
    self.cartButton.frame = CGRectMake(0, 0, 44, 44);
    
    self.albumCollectionView.delegate = self;
    self.albumCollectionView.dataSource = self;
    self.albumCollectionView.clipsToBounds = NO;
    self.albumCollectionView.pagingEnabled = YES;
    self.albumCollectionView.backgroundColor = [UIColor blackColor];
    [self.albumCollectionView registerClass:[AlbumCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    [self.albumCollectionView reloadData];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - helper methods
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSMutableArray *currentCells = [[NSMutableArray alloc] initWithArray:self.albumCollectionView.visibleCells];
    AlbumCollectionViewCell *cell = currentCells[0];
    NSIndexPath *indexPath = [self.albumCollectionView indexPathForCell:cell];
    self.pageControl.currentPage = indexPath.row;
}

#pragma mark - Buttons' methods
- (IBAction)phoneButtonPressed:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://2135554321"]];
    NSLog(@"calling");
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSMutableArray *currentCells = [[NSMutableArray alloc] initWithArray:self.albumCollectionView.visibleCells];
    AlbumCollectionViewCell *cell = currentCells[0];
    NSIndexPath *indexPath = [self.albumCollectionView indexPathForCell:cell];
    self.pageControl.currentPage = indexPath.row;
}

#pragma mark - Collectionview delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.restaurant.images.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.imageView.image = self.restaurant.images[indexPath.row];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.albumCollectionView.frame.size;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - Segue methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[MapViewController class]]) {
        MapViewController *VC = segue.destinationViewController;
        VC.restaurant = self.restaurant;
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
