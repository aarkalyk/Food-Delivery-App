//
//  HistoryViewController.m
//  FoodDeliveryApp
//
//  Created by Student on 7/22/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "HistoryCollectionViewCell.h"
#import "HistoryViewController.h"
#import "cartViewController.h"

@interface HistoryViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) NSMutableArray *nOrderNames;
@property (nonatomic) NSMutableArray *nOrderPrices;
@property (nonatomic) NSMutableArray *nOrderQuantities;

@property (nonatomic) NSMutableArray *orderDates;
@property (nonatomic) NSMutableArray *allOrderNames;
@property (nonatomic) NSMutableArray *allOrderPrices;
@property (nonatomic) NSMutableArray *orderTotalPrices;
@property (nonatomic) NSMutableArray *allOrderQuantities;
@property (weak, nonatomic) IBOutlet UIButton *cartButton;
@property (weak, nonatomic) IBOutlet UICollectionView *colllectionView;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self deleteOrder];
    
    //setting up the cartButton
    [self.cartButton setImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
    self.cartButton.frame = CGRectMake(0, 0, 44, 44);
    
    //setting up the collectionView
    self.colllectionView.delegate = self;
    self.colllectionView.dataSource = self;
    self.colllectionView.backgroundColor = [UIColor clearColor];
    [self.colllectionView registerClass:[HistoryCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    
    //getting order history from local memory
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.orderDates = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderDates"]];
    self.orderTotalPrices = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderTotalPrices"]];
    self.allOrderNames = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"allOrderNames"]];
    self.allOrderPrices = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"allOrderPrices"]];
    self.allOrderQuantities = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"allOrderQuan"]];
    
    if (self.orderDates.count == 0) {
        self.orderDates = [NSMutableArray new];
    }
    if (self.orderTotalPrices.count == 0) {
        self.orderTotalPrices = [NSMutableArray new];
    }
    if (self.allOrderNames.count == 0) {
        self.allOrderNames = [NSMutableArray new];
    }
    if (self.allOrderPrices.count == 0) {
        self.allOrderPrices = [NSMutableArray new];
    }
    if (self.allOrderQuantities.count == 0) {
        self.allOrderQuantities = [NSMutableArray new];
    }
    
    
    [self.colllectionView reloadData];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    //getting order history from local memory
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.orderDates = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderDates"]];
    self.orderTotalPrices = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderTotalPrices"]];
    self.allOrderNames = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"allOrderNames"]];
    self.allOrderPrices = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"allOrderPrices"]];
    self.allOrderQuantities = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"allOrderQuan"]];
    
    if (self.orderDates.count == 0) {
        self.orderDates = [NSMutableArray new];
    }
    if (self.orderTotalPrices.count == 0) {
        self.orderTotalPrices = [NSMutableArray new];
    }
    if (self.allOrderNames.count == 0) {
        self.allOrderNames = [NSMutableArray new];
    }
    if (self.allOrderPrices.count == 0) {
        self.allOrderPrices = [NSMutableArray new];
    }
    if (self.allOrderQuantities.count == 0) {
        self.allOrderQuantities = [NSMutableArray new];
    }
    
    
    
    [self.colllectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper methods
-(void) deleteOrder{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"orderDates"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"orderTotalPrices"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"historyOrderNames"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"historyOrderPrices"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"historyOrderQuan"];
}


#pragma mark - CollectionView delegate methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.orderTotalPrices.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HistoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.viewUpper.backgroundColor = [UIColor grayColor];
    cell.viewLower.backgroundColor = [UIColor grayColor];
    cell.priceLabel.text = [NSString stringWithFormat:@"%i тенге", [self.orderTotalPrices[indexPath.row] intValue]];
    cell.dateLabel.text = self.orderDates[indexPath.row];
    cell.image.image = [UIImage imageNamed:@"rightArrow.png"];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.nOrderNames = self.allOrderNames[indexPath.row];
    self.nOrderPrices = self.allOrderPrices[indexPath.row];
    self.nOrderQuantities = self.allOrderQuantities[indexPath.row];
    [self performSegueWithIdentifier:@"historyToCart" sender:self];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 20);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

#pragma mark - Segue methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"historyToCart"]) {
        cartViewController *nextVC = segue.destinationViewController;
        nextVC.orderNames = self.nOrderNames;
        nextVC.orderPrices = self.nOrderPrices;
        nextVC.orderQuantities = self.nOrderQuantities;
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
