//
//  MenuItemsViewController.m
//  FoodDeliveryApp
//
//  Created by Student on 7/20/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "itemQuantityCollectionViewCell.h"
#import "FoodDescriptionViewController.h"
#import "MenuItemsViewController.h"
#import "customMenuCell.h"
#import <Parse/Parse.h>
#import "Product.h"

@interface MenuItemsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *itemCollectionView;

@property (nonatomic) BOOL started;
@property (nonatomic) Product *tempProduct;
@property (nonatomic) NSMutableArray *products;
@property (nonatomic) NSMutableArray *orderNames;
@property (nonatomic) NSMutableArray *orderPrices;
@property (nonatomic) NSMutableArray *orderQuantities;
@property (weak, nonatomic) IBOutlet UIButton *cartButton;
@property (nonatomic) UIColor *customGreen;
@property (weak, nonatomic) IBOutlet UIImageView *whitePlaceHolder;
@property (weak, nonatomic) IBOutlet UIImageView *logoPlaceHolder;

@end

@implementation MenuItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setting up the placeholders
    self.whitePlaceHolder.image = [UIImage imageNamed:@"placeHolderWhite.png"];
    self.logoPlaceHolder.image = [UIImage imageNamed:@"logo.png"];
    self.whitePlaceHolder.hidden = NO;
    self.logoPlaceHolder.hidden = NO;
    
    self.customGreen = [UIColor colorWithRed:89/255.0 green:218/255.0 blue:145/255.0 alpha:1];
    
    self.products = [NSMutableArray new];
    
    self.started = NO;
    
    [self.cartButton setImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
    self.cartButton.frame = CGRectMake(0, 0, 44, 44);
    
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"orderNames"];
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"orderQuan"];
    
    self.itemCollectionView.delegate = self;
    self.itemCollectionView.dataSource = self;
    [self.itemCollectionView setBackgroundColor:[UIColor clearColor]];
    [self.itemCollectionView registerClass:[customMenuCell class] forCellWithReuseIdentifier:@"Cell"];
    
    
    [self downloadNames];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
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
    
    BOOL exists = NO;
    for (int j = 0; j < self.products.count; j++) {
        Product *product = self.products[j];
        
        for (int i = 0; i < self.orderNames.count; i++) {
            if ([product.name isEqualToString:self.orderNames[i]]) {
                exists = YES;
                product.quantity = [self.orderQuantities[i] intValue];
                product.isAdded = YES;
            }
        }
        if (!exists) {
            product.quantity = 0;
            product.isAdded = NO;
        }
        [self.products replaceObjectAtIndex:j withObject:product];
    }
    
    [self.itemCollectionView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper methods
-(void) hidePlaceHolder{
    self.whitePlaceHolder.alpha = 1.0f;
    self.logoPlaceHolder.alpha = 1.0f;
    // Then fades it away after 2 seconds (the cross-fade animation will take 0.5s)
    [UIView animateWithDuration:0.5 delay:1.0 options:0 animations:^{
        // Animate the alpha value of your imageView from 1.0 to 0.0 here
        self.whitePlaceHolder.alpha = 0.0f;
        self.logoPlaceHolder.alpha = 0.0f;
    } completion:^(BOOL finished) {
        // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
        self.whitePlaceHolder.hidden = YES;
        self.logoPlaceHolder.hidden = YES;
    }];
}

#pragma mark - Button methods
-(void)addOrder:(UIButton *)button{
    //[self addNewItem:button.tag];
    customMenuCell *cell = [self.itemCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:button.tag inSection:0]];
    cell.collectionView.hidden = NO;
    cell.rightButton.hidden = NO;
    cell.leftButton.hidden = NO;
    cell.hiddenButton.hidden = NO;

}

- (IBAction)cartButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"menuItemsToCart" sender:self];
}

-(void) increaseQuan:(UIButton *) button{
    customMenuCell *cell = [self.itemCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:button.tag inSection:0]];
    
    NSMutableArray *currentCell = [[NSMutableArray alloc] initWithArray:cell.collectionView.visibleCells];
    itemQuantityCollectionViewCell *cellsCell = currentCell[0];
    
    NSIndexPath *indexPath = [cell.collectionView indexPathForCell:cellsCell];
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
    
    [cell.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    //[self addNewItem:button.tag withQuantity:nextIndexPath.row];
}

-(void) decreaseQuan:(UIButton *) button{
    customMenuCell *cell = [self.itemCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:button.tag inSection:0]];
    
    NSMutableArray *currentCell = [[NSMutableArray alloc] initWithArray:cell.collectionView.visibleCells];
    itemQuantityCollectionViewCell *cellsCell = currentCell[0];
    
    NSIndexPath *indexPath = [cell.collectionView indexPathForCell:cellsCell];
    
    if (indexPath.row != 0) {
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:0];
        [cell.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        //[self addNewItem:button.tag withQuantity:nextIndexPath.row];
    }else{
        //[self addNewItem:button.tag withQuantity:0];
    }
}

-(void) hiddenButtonPressed:(UIButton *) button{
    customMenuCell *cell = [self.itemCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:button.tag inSection:0]];
    cell.collectionView.hidden = YES;
    cell.rightButton.hidden = YES;
    cell.leftButton.hidden = YES;
    cell.hiddenButton.hidden = YES;
    NSMutableArray *indexPaths = [NSMutableArray new];
    NSIndexPath *indexPath = [self.itemCollectionView indexPathForCell:cell];
    [indexPaths addObject:indexPath];

    NSMutableArray *cellsCells = [[NSMutableArray alloc] initWithArray:cell.collectionView.visibleCells];
    itemQuantityCollectionViewCell *cellsCell = cellsCells[0];
    NSIndexPath *indexPathForQuan = [cell.collectionView indexPathForCell:cellsCell];
    
    Product *product = self.products[button.tag];
    BOOL exists = NO;
    
    if (indexPathForQuan.row != 0) {
        product.quantity = (int)indexPathForQuan.row;
        product.isAdded = YES;
        
        [self.products replaceObjectAtIndex:button.tag withObject:product];
        for (int i = 0; i < self.orderNames.count; i++) {
            if ([product.name isEqualToString:self.orderNames[i]]) {
                [self.orderNames replaceObjectAtIndex:i withObject:product.name];
                [self.orderQuantities replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:product.quantity]];
                exists = YES;
            }
        }
            
        if (exists == NO) {
            [self.orderNames addObject:product.name];
            [self.orderQuantities addObject:[NSNumber numberWithInt:product.quantity]];
            [self.orderPrices addObject:[NSNumber numberWithInt:product.price]];
        }
            
    }else{
        for (int i = 0; i < self.orderNames.count; i++) {
            if ([product.name isEqualToString:self.orderNames[i]]) {
                product.isAdded = NO;
                product.quantity = 0;
                
                [self.orderNames removeObjectAtIndex:i];
                [self.orderPrices removeObjectAtIndex:i];
                [self.orderQuantities removeObjectAtIndex:i];
            }
        }
    }
    
    //saving in local memory
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.orderQuantities forKey:@"orderQuan"];
    [userDefaults setObject:self.orderNames forKey:@"orderNames"];
    [userDefaults setObject:self.orderPrices forKey:@"orderPrices"];
    
    self.orderNames = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderNames"]];
    self.orderQuantities = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderQuan"]];
    self.orderPrices = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderPrices"]];
    // synchronize is only needed while debugging (when you use the stop button in Xcode)
    // you don't need this in production code. remove it for release
    [userDefaults synchronize];
    
    [self.itemCollectionView reloadItemsAtIndexPaths:indexPaths];
}



#pragma mark - Parse's methods
-(void) downloadNames{
    PFQuery *query = [PFQuery queryWithClassName:@"Products"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                if ([self.categoryName isEqualToString:object[@"category"]]) {
                    NSString *name = object[@"name"];
                    NSString *descr = object[@"descr"];
                    UIImage *image = [UIImage imageNamed:@"defaultFood.png"];
                    
                    BOOL isAdded = NO;
                    int quantity = 0;
                    int price = [object[@"price"] intValue];
                    
                    for (int i = 0; i < self.orderNames.count; i++) {
                        if ([name isEqualToString:self.orderNames[i]]) {
                            quantity = [self.orderQuantities[i] intValue];
                            isAdded = YES;
                        }
                    }
                    
                    Product *product = [[Product alloc] initWithName:name andDescr:descr andImage:image andQuan:quantity isAdded:isAdded andPrice:price];
                    [self.products addObject:product];
                }
            }
            [self.itemCollectionView reloadData];
            [self downloadImages];
        }
    }];
}

-(void) downloadImages{
    PFQuery *query = [PFQuery queryWithClassName:@"Products"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            int i = 0;
            for (PFObject *object in objects) {
                if ([self.categoryName isEqualToString:object[@"category"]]) {
                    NSString *name = object[@"name"];
                    NSString *descr = object[@"descr"];
                    BOOL isAdded = NO;
                    int quantity = 0;
                    int price = [object[@"price"] intValue];
                    
                    for (int i = 0; i < self.orderNames.count; i++) {
                        if ([name isEqualToString:self.orderNames[i]]) {
                            quantity = [self.orderQuantities[i] intValue];
                            isAdded = YES;
                        }
                    }
                    
                    PFFile *file = object[@"image"];
                    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        UIImage *image = [UIImage imageWithData:data];
                        Product *product = [[Product alloc] initWithName:name andDescr:descr andImage:image andQuan:quantity isAdded:isAdded andPrice:price];
                        [self.products replaceObjectAtIndex:i withObject:product];
                        [self.itemCollectionView reloadData];
                    }];
                    i++;
                }
            }
            [self hidePlaceHolder];
        }
    }];
}

#pragma mark - Collectionview delegate methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.products.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    self.started = YES;
    customMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    Product *product = self.products[indexPath.row];
    cell.imageView.image = product.image;
    cell.name.text = product.name;
    cell.price.text = [NSString stringWithFormat:@"%i tg",product.price];
    
    cell.gradientImageView.image = [UIImage imageNamed:@"gradient.png"];
    
    if (product.isAdded == YES) {
        [cell.button setTitle:[NSString stringWithFormat:@"%i", product.quantity] forState:UIControlStateNormal];
        [cell.button setBackgroundColor:[UIColor redColor]];
    }else{
        [cell.button setTitle:@"+" forState:UIControlStateNormal];
        [cell.button setBackgroundColor:self.customGreen];
    }
    
    [cell.button addTarget:self action:@selector(addOrder:) forControlEvents:UIControlEventTouchUpInside];
    cell.button.tag = indexPath.row;
    
    cell.collectionView.hidden = YES;
    cell.rightButton.hidden = YES;
    cell.leftButton.hidden = YES;
    cell.rightButton.tag = indexPath.row;
    cell.leftButton.tag = indexPath.row;
    cell.hiddenButton.tag = indexPath.row;
    
    cell.hiddenButton.backgroundColor = self.customGreen;
    [cell.hiddenButton setTitle:@"x" forState:UIControlStateNormal];
    cell.hiddenButton.hidden = YES;
    
    [cell.rightButton setImage:[UIImage imageNamed:@"rightArrowWhite.png"] forState:UIControlStateNormal];
    [cell.leftButton setImage:[UIImage imageNamed:@"leftArrowWhite.png"] forState:UIControlStateNormal];
    
    [cell.rightButton addTarget:self action:@selector(increaseQuan:) forControlEvents:UIControlEventTouchUpInside];
    [cell.leftButton addTarget:self action:@selector(decreaseQuan:) forControlEvents:UIControlEventTouchUpInside];
    [cell.hiddenButton addTarget:self action:@selector(hiddenButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(self.view.frame),100);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.tempProduct = self.products[indexPath.row];
    [self performSegueWithIdentifier:@"descriptionSegue" sender:self];
}


#pragma mark - Segue methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[FoodDescriptionViewController class]]) {
        FoodDescriptionViewController *VC = segue.destinationViewController;
        VC.image = self.tempProduct.image;
        VC.name = self.tempProduct.name;
        VC.descr = self.tempProduct.descr;
        VC.price = self.tempProduct.price;
        VC.quan = self.tempProduct.quantity;
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
