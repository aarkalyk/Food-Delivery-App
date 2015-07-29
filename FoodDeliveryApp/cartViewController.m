//
//  cartViewController.m
//  FoodDeliveryApp
//
//  Created by Student on 7/21/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "cartViewController.h"
#import "cartCollectionViewCell.h"
#import "UserInputViewController.h"

@interface cartViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) int totalPrice;
@property (nonatomic) UIColor *customGreen;
@property (nonatomic) NSMutableArray *emailArray;
@property (weak, nonatomic) IBOutlet UIButton *orderButton;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteOrderButton;
@property (weak, nonatomic) IBOutlet UILabel *totaLPriceTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *minimumOrderPriceLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation cartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //custom green color
    self.customGreen = [UIColor colorWithRed:89/255.0 green:218/255.0 blue:145/255.0 alpha:1];
    
    self.minimumOrderPriceLabel.text = @"*Минимальный заказ 2000 тенге";
    self.minimumOrderPriceLabel.hidden = YES;
    
    //setting titles to buttons
    [self.orderButton setTitle:@"Заказть" forState:UIControlStateNormal];
    [self.deleteOrderButton setTitle:@"Очистить" forState:UIControlStateNormal];
    [self.deleteOrderButton setTintColor:[UIColor blackColor]];
    
    //printing total price
    self.totaLPriceTextLabel.text = @"Общий счет:";
    
    //setting up the collectionview
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[cartCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    if (self.orderNames.count == 0) {
        //getting data from local memory
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        self.orderNames = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderNames"]];
        self.orderPrices = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderPrices"]];
        self.orderQuantities = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderQuan"]];
        if (!self.orderNames) {
            // create array if it doesn't exist in NSUserDefaults
            self.orderNames = [[NSMutableArray alloc] init];
        }
        if (!self.orderQuantities) {
            // create array if it doesn't exist in NSUserDefaults
            self.orderQuantities = [[NSMutableArray alloc] init];
        }
        if (!self.orderPrices) {
            self.orderPrices = [[NSMutableArray alloc] init];
        }
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:self.orderNames forKey:@"orderNames"];
        [[NSUserDefaults standardUserDefaults] setObject:self.orderPrices forKey:@"orderPrices"];
        [[NSUserDefaults standardUserDefaults] setObject:self.orderQuantities  forKey:@"orderQuan"];
    }
    
    [self countTotalPrice];
    [self.collectionView reloadData];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
        //getting data from local memory
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        self.orderNames = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderNames"]];
        self.orderPrices = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderPrices"]];
        self.orderQuantities = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderQuan"]];
        if (!self.orderNames) {
            // create array if it doesn't exist in NSUserDefaults
            self.orderNames = [[NSMutableArray alloc] init];
        }
        if (!self.orderQuantities) {
            // create array if it doesn't exist in NSUserDefaults
            self.orderQuantities = [[NSMutableArray alloc] init];
        }
        if (!self.orderPrices) {
            self.orderPrices = [[NSMutableArray alloc] init];
        }

    
    
    //printing sum and reloading the collectionview
    [self countTotalPrice];
    [self.collectionView reloadData];
    
    //disable the button if total price is less than 2000
    if (self.totalPrice < 2000) {
        [self.orderButton setBackgroundColor:[UIColor grayColor]];
        self.orderButton.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper methods
//counts and prints total price
-(void) countTotalPrice{
    int sum = 0;
    int price = 0;
    int quantity = 0;
    
    for (int i = 0; i < self.orderNames.count; i++) {
        price = [self.orderPrices[i] intValue];
        quantity = [self.orderQuantities[i] intValue];
        
        sum += price*quantity;
    }
    self.totalPrice = sum;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%i тенге", sum];
    
    //disable the button if total price is less than 2000
    if (self.totalPrice < 2000) {
        [self.orderButton setBackgroundColor:[UIColor grayColor]];
        self.orderButton.enabled = NO;
        
        if (self.totalPrice != 0) {
            self.minimumOrderPriceLabel.hidden = NO;
        }
    }else{
        [self.orderButton setBackgroundColor:self.customGreen];
        self.orderButton.enabled =YES;
        
        if (self.totalPrice != 0) {
            self.minimumOrderPriceLabel.hidden = YES;
        }
    }
}

-(void) increaseQuantity:(UIButton *) button{
    int tempQuantity = [self.orderQuantities[button.tag] intValue];
    tempQuantity++;
    [self.orderQuantities replaceObjectAtIndex:button.tag withObject:[NSNumber numberWithInt:tempQuantity]];
    
    //saving in local memory
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.orderQuantities forKey:@"orderQuan"];
    [userDefaults setObject:self.orderNames forKey:@"orderNames"];
    
    self.orderNames = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderNames"]];
    self.orderQuantities = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderQuan"]];
    // synchronize is only needed while debugging (when you use the stop button in Xcode)
    // you don't need this in production code. remove it for release
    [userDefaults synchronize];
    
    [self countTotalPrice];
    [self.collectionView reloadData];
}

-(void) decreaseQuantity:(UIButton *) button{
    int tempQuantity = [self.orderQuantities[button.tag] intValue];
    if (tempQuantity != 1) {
        tempQuantity--;
        [self.orderQuantities replaceObjectAtIndex:button.tag withObject:[NSNumber numberWithInt:tempQuantity]];
    }else{
        [self.orderNames removeObjectAtIndex:button.tag];
        [self.orderPrices removeObjectAtIndex:button.tag];
        [self.orderQuantities removeObjectAtIndex:button.tag];
    }
    
    //saving in loacl memory
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.orderNames forKey:@"orderNames"];
    [userDefaults setObject:self.orderPrices forKey:@"orderPrices"];
    [userDefaults setObject:self.orderQuantities forKey:@"orderQuan"];
    
    self.orderNames = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderNames"]];
    self.orderQuantities = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderQuan"]];
    self.orderPrices = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderPrices"]];
    // synchronize is only needed while debugging (when you use the stop button in Xcode)
    // you don't need this in production code. remove it for release
    [userDefaults synchronize];
    
    [self countTotalPrice];
    [self.collectionView reloadData];
}

//composes an email
-(void) composeAnEmail{
    self.emailArray = [NSMutableArray new];
    
    for (int i = 0; i < self.orderNames.count; i++) {
        NSString *price = [NSString stringWithFormat:@"%i", [self.orderPrices[i] intValue]*[self.orderQuantities[i] intValue]];
        NSString *nameAndQuantity = [NSString stringWithFormat:@"%@ x %i", self.orderNames[i], [self.orderQuantities[i] intValue]];
        NSString *priceNameAndQuantity = [NSString stringWithFormat:@"%@ - %@", price, nameAndQuantity];
        [self.emailArray addObject:priceNameAndQuantity];
    }
    NSString *totalPrice = [NSString stringWithFormat:@"Общая сумма: %i тенге",self.totalPrice];
    [self.emailArray addObject:totalPrice];
    //self.email = [self.emailArray componentsJoinedByString:@"\r"];
}

#pragma mark - Button methods
- (IBAction)deleteOrderButtonPressed:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"orderNames"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"orderQuan"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"orderPrices"];
    self.orderNames = [[NSMutableArray alloc] init];
    self.orderQuantities = [[NSMutableArray alloc] init];
    self.orderPrices = [[NSMutableArray alloc] init];
    [self countTotalPrice];
    [self.collectionView reloadData];
    [self.orderButton setBackgroundColor:[UIColor grayColor]];
    self.orderButton.enabled = NO;
}

- (IBAction)orderButtonPressed:(UIButton *)sender {
    [self composeAnEmail];
    [self performSegueWithIdentifier:@"cartToUserInput" sender:self];
}

#pragma mark - CollectionView delegate methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.orderNames.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    cartCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    int price = [self.orderPrices[indexPath.row] intValue];
    int quantity = [self.orderQuantities[indexPath.row] intValue];
    int priceQuan = price*quantity;
    NSString *name = self.orderNames[indexPath.row];
    
    cell.view.backgroundColor = [UIColor grayColor];
    cell.name.text = [NSString stringWithFormat:@"%@ x %i",name, quantity];
    
    [cell.addButton setBackgroundColor:self.customGreen];
    cell.addButton.tag = indexPath.row;
    [cell.addButton addTarget:self action:@selector(increaseQuantity:) forControlEvents:UIControlEventTouchUpInside];

    [cell.subtractButton setBackgroundColor:[UIColor redColor]];
    cell.subtractButton.tag = indexPath.row;
    [cell.subtractButton addTarget:self action:@selector(decreaseQuantity:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.price.text = [NSString stringWithFormat:@"%i tg", priceQuan];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 30);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

#pragma mark - Segue helper methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[UserInputViewController class]]) {
        UserInputViewController *nextVC = segue.destinationViewController;
        nextVC.totalPrice = self.totalPrice;
        nextVC.emailArray = self.emailArray;
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
