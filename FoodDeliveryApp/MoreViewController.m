//
//  MoreViewController.m
//  FoodDeliveryApp
//
//  Created by Student on 7/27/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "MoreCollectionViewCell.h"
#import "MoreViewController.h"
#import "MoreItem.h"

@interface MoreViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *cartButton;
@property (nonatomic) NSMutableArray *items;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.cartButton setImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
    self.cartButton.frame = CGRectMake(0, 0, 44, 44);
    
    self.items = [NSMutableArray new];
    
    //setting up the collectionview
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[MoreCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    [self createItems];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper methods
-(void) createItems{
    MoreItem *item0 = [[MoreItem alloc] initWithName:@"About" andImage:@"about.png"];
    MoreItem *item1 = [[MoreItem alloc] initWithName:@"News" andImage:@"news.png"];
    MoreItem *item2 = [[MoreItem alloc] initWithName:@"Delivery" andImage:@"delivery.png"];
    MoreItem *item3 = [[MoreItem alloc] initWithName:@"Settings" andImage:@"settings.png"];
    
    [self.items addObject:item0];
    [self.items addObject:item1];
    [self.items addObject:item2];
    [self.items addObject:item3];
    
    [self.collectionView reloadData];
}

#pragma mark - CollectionView delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    MoreItem *item = self.items[indexPath.row];
    
    cell.name.text = item.name;
    cell.name.textColor = [UIColor blackColor];
    cell.line.backgroundColor = [UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:0.5];
    cell.arrowImageView.image = [UIImage imageNamed:@"rightArrow.png"];
    cell.iconImageView.image = [UIImage imageNamed:item.imageName];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 80);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MoreItem *item = self.items[indexPath.row];
    [self performSegueWithIdentifier:item.name sender:self];
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
