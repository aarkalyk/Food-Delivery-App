//
//  FoodDescriptionViewController.m
//  FoodDeliveryApp
//
//  Created by Student on 7/20/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "FoodDescriptionViewController.h"
#import "QuantityCollectionViewCell.h"
#import "Product.h"

@interface FoodDescriptionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIImageView *FoodImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descrLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *cartButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) NSMutableArray *orderNames;
@property (nonatomic) NSMutableArray *orderPrices;
@property (nonatomic) NSMutableArray *orderQuantities;

@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *hiddenAddButton;

@property (nonatomic) NSMutableArray *currentCell;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation FoodDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(CGRectGetHeight(self.view.frame) == 480){
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)+100);
    }
    
    //setting up the buttons
    //[self.rightButton setImage:[UIImage imageNamed:@"rightArrow.png"] forState:UIControlStateNormal];
    //self.rightButton.frame = CGRectMake(0, 0, 50, 50);
    //[self.leftButton setImage:[UIImage imageNamed:@"leftArrow.png"] forState:UIControlStateNormal];
    //self.leftButton.frame = CGRectMake(0, 0, 50, 50);
    [self.rightButton setTintColor:[UIColor whiteColor]];
    [self.leftButton setTintColor:[UIColor whiteColor]];
    
    [self.hiddenAddButton setBackgroundColor:[UIColor colorWithRed:(89/255.9) green:(218/255.0) blue:(145/255.0) alpha:1]];
    [self.hiddenAddButton setTitle:@"Добавить" forState:UIControlStateNormal];
    [self.hiddenAddButton setTintColor:[UIColor whiteColor]];
    self.hiddenAddButton.hidden = YES;
    
    //setting up the collectionview
    //self.collectionView.hidden = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.clipsToBounds = NO;
    self.collectionView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [self.collectionView registerClass:[QuantityCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView reloadData];
    
    //hiding the buttons and the collectionview
    self.rightButton.hidden = YES;
    self.leftButton.hidden = YES;
    self.collectionView.hidden = YES;
    
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
        // create array if it doesn't exist in NSUserDefaults
        self.orderPrices = [[NSMutableArray alloc] init];
    }
    
    [self.cartButton setImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
    self.cartButton.frame = CGRectMake(0, 0, 44, 44);
    
    [self.addButton setTitle:@"В корзину" forState:UIControlStateNormal];
    
    //getting data from previous viewcontroller
    self.FoodImageView.image = self.image;
    self.priceLabel.text = [NSString stringWithFormat:@"%i tg", self.price];
    self.nameLabel.text = self.name;
    self.descrLabel.text = self.descr;
    
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    //self.collectionView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper methods
-(void) addItem{
    BOOL exists = NO;
    for (int i = 0; i < self.orderNames.count; i++) {
        if ([self.name isEqualToString:self.orderNames[i]]) {
            if (self.quan != 0) {
                [self.orderNames replaceObjectAtIndex:i withObject:self.name];
                [self.orderQuantities replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:self.quan]];
            }else{
                [self.orderNames removeObjectAtIndex:i];
                [self.orderPrices removeObjectAtIndex:i];
                [self.orderQuantities removeObjectAtIndex:i];
            }
            
            exists = YES;
        }
    }
    
    if (exists == NO) {
        if (self.quan != 0) {
            [self.orderNames addObject:self.name];
            [self.orderQuantities addObject:[NSNumber numberWithInt:self.quan]];
            [self.orderPrices addObject:[NSNumber numberWithInt:self.price]];
        }
    }
    
    //saving in local memory
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.orderQuantities forKey:@"orderQuan"];
    [userDefaults setObject:self.orderPrices forKey:@"orderPrices"];
    [userDefaults setObject:self.orderNames forKey:@"orderNames"];
    
    self.orderNames = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderNames"]];
    self.orderPrices = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderPrices"]];
    self.orderQuantities = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderQuan"]];
    // synchronize is only needed while debugging (when you use the stop button in Xcode)
    // you don't need this in production code. remove it for release
    [userDefaults synchronize];

}

#pragma mark - Button methods
- (IBAction)addButtonPressed:(UIButton *)sender {
    self.collectionView.hidden = NO;
    self.rightButton.hidden = NO;
    self.leftButton.hidden = NO;
    self.hiddenAddButton.hidden = NO;
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.quan inSection:0];
    [self.collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (IBAction)cartButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"foodDescrToCart" sender:self];
}

// RIGHT BUTTON
- (IBAction)leftButtonPressed:(UIButton *)sender {
    [self.view layoutIfNeeded];
    self.currentCell = [[NSMutableArray alloc] initWithArray:self.collectionView.visibleCells];
    QuantityCollectionViewCell *cell = self.currentCell[0];
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

//LEFT BUTTON
- (IBAction)rightButtonPressed:(UIButton *)sender {
    [self.view layoutIfNeeded];
    self.currentCell = [[NSMutableArray alloc] initWithArray:self.collectionView.visibleCells];
    QuantityCollectionViewCell *cell = self.currentCell[0];
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    if (indexPath.row != 0) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

- (IBAction)hiddenAddButtonPressed:(UIButton *)sender {
    
    NSMutableArray *currentCell = [[NSMutableArray alloc] initWithArray:self.collectionView.visibleCells];
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:currentCell[0]];
    self.quan = (int)indexPath.row;
    
    [self addItem];
    self.collectionView.hidden = YES;
    self.rightButton.hidden = YES;
    self.leftButton.hidden = YES;
    self.hiddenAddButton.hidden = YES;
    
}

#pragma mark - Collectionview delegate methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QuantityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    [cell.textLabel setFont:[UIFont systemFontOfSize:45]];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.collectionView.frame.size;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
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
