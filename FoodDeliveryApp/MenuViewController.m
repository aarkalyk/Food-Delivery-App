//
//  MenuViewController.m
//  FoodDeliveryApp
//
//  Created by Student on 7/20/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "MenuItemsViewController.h"
#import "MenuViewController.h"
#import "customMenuCell.h"
#import <Parse/Parse.h>
#import "MenuItem.h"

@interface MenuViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *menuCollectionView;
@property (nonatomic) NSMutableArray *localObjects;
@property (nonatomic) NSMutableArray *items;
@property (nonatomic) NSMutableArray *names;

@property (weak, nonatomic) IBOutlet UIImageView *placeHolderImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoPlaceHolder;
@property (nonatomic) UIImage *defaultImage;
@property (weak, nonatomic) IBOutlet UIButton *cartButton;
@property (nonatomic) NSString *categoryName;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setting images to tabbar items
    UITabBarItem *tabBarItem = [self.tabBarController.tabBar.items objectAtIndex:0];
    
    UIImageView *unselectedImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    unselectedImage.image = [UIImage imageNamed:@"menu.png"];
    
    [tabBarItem setImage: [unselectedImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    //restaurants
    UITabBarItem *tabBarItem1 = [self.tabBarController.tabBar.items objectAtIndex:1];
    
    UIImageView *unselectedImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    unselectedImage1.image = [UIImage imageNamed:@"restaurant.png"];
    
    [tabBarItem1 setImage: [unselectedImage1.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //history
    UITabBarItem *tabBarItem2 = [self.tabBarController.tabBar.items objectAtIndex:2];
    
    UIImageView *unselectedImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    unselectedImage2.image = [UIImage imageNamed:@"history.png"];
    
    [tabBarItem2 setImage: [unselectedImage2.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //more
    UITabBarItem *tabBarItem3 = [self.tabBarController.tabBar.items objectAtIndex:3];
    
    UIImageView *unselectedImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    unselectedImage3.image = [UIImage imageNamed:@"more.png"];
    
    [tabBarItem3 setImage: [unselectedImage3.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    
    [self.cartButton setImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
    self.cartButton.frame = CGRectMake(0, 0, 44, 44);
    
    self.placeHolderImageView.image = [UIImage imageNamed:@"placeHolderWhite.png"];
    self.logoPlaceHolder.image = [UIImage imageNamed:@"logo.png"];
    self.defaultImage = [UIImage imageNamed:@"defaultFood.png"];
    
    self.items = [NSMutableArray new];
    
    [self.menuCollectionView registerClass:[customMenuCell class] forCellWithReuseIdentifier:@"Cell"];
    self.menuCollectionView.delegate = self;
    self.menuCollectionView.dataSource = self;
    [self.menuCollectionView setBackgroundColor:[UIColor clearColor]];
    
    [self getDataFromLocalDatastore];
    [self downloadImages];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cartButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"menuToCart" sender:self];
}

#pragma mark - Helper methods
-(void) hidePlaceHolder{
    self.placeHolderImageView.alpha = 1.0f;
    self.logoPlaceHolder.alpha = 1.0f;
    // Then fades it away after 2 seconds (the cross-fade animation will take 0.5s)
    [UIView animateWithDuration:0.5 delay:1.0 options:0 animations:^{
        // Animate the alpha value of your imageView from 1.0 to 0.0 here
        self.placeHolderImageView.alpha = 0.0f;
        self.logoPlaceHolder.alpha = 0.0f;
    } completion:^(BOOL finished) {
        // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
        self.placeHolderImageView.hidden = YES;
        self.logoPlaceHolder.hidden = YES;
    }];
}

#pragma mark - Parse's methods
-(void) downloadNames{
    PFQuery *query = [PFQuery queryWithClassName:@"Categories"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *name = object[@"name"];
                MenuItem *item = [[MenuItem alloc] initWithName:name andImage:self.defaultImage];
                NSLog(@"%@", name);
                [self.items addObject:item];
            }
            NSLog(@"%zd", self.items.count);
            
            [self hidePlaceHolder];
            [self.menuCollectionView reloadData];
            [self downloadImages];
        }
    }];
}

-(void) downloadImages{
    PFQuery *query = [PFQuery queryWithClassName:@"Categories"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *name = object[@"name"];
                PFFile *file = object[@"image"];
                [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    BOOL exists = NO;
                    
                    UIImage *image = [UIImage imageWithData:data];
                    MenuItem *item = [[MenuItem alloc] initWithName:name andImage:image];
                    
                    for (int j = 0; j < self.items.count; j++) {
                        MenuItem *localItem = self.items[j];
                        NSLog(@"loop is running");
                        if([name isEqualToString:localItem.name]){
                            NSLog(@"names are equal");
                            exists = YES;
                        }
                    }
                    if (!exists) {
                        [self addNewItem:item];
                        [object pinInBackground];
                    }
                
                    [self.menuCollectionView reloadData];
                }];
                [self.names addObject:name];
            }
            [self hidePlaceHolder];
            [self upDateLocalData];
        }
    }];
}

-(void)upDateLocalData{
    BOOL exists = NO;
    for (int i = 0;  i < self.items.count; i++) {
        for (int j = 0;  j < self.names.count; j++) {
            MenuItem *item = self.items[i];
            if ([item.name isEqualToString:self.names[j]]) {
                exists = YES;
            }
        }
        if (!exists) {
            [self deletObjectFromLocal:self.localObjects[i]];
            [self.localObjects removeObjectAtIndex:i];
            [self.items removeObjectAtIndex:i];
            [self.menuCollectionView reloadData];
        }
        exists = NO;
    }
}

-(void)deletObjectFromLocal:(PFObject *)object{
    PFQuery *query = [PFQuery queryWithClassName:@"Categories"];
    [query fromLocalDatastore];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [object unpinInBackground];
    }];
}

-(void)getDataFromLocalDatastore{
    PFQuery *query = [PFQuery queryWithClassName:@"Categories"];
    [query fromLocalDatastore];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *name = object[@"name"];
                PFFile *file = object[@"image"];
                [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    UIImage *image = [UIImage imageWithData:data];
                    MenuItem *item = [[MenuItem alloc] initWithName:name andImage:image];
                    [self addNewItem:item];
                    [self addNewObject:object];
                }];
                //[object unpinInBackground];
            }
            if (objects.count != 0) {
                [self hidePlaceHolder];
            }
        }
    }];
}

-(void)addNewObject:(PFObject *)object{
    [self.localObjects addObject:object];
}

-(void) addNewItem:(MenuItem *)item{
    [self.items addObject:item];
    [self.menuCollectionView reloadData];
    NSLog(@"%zd", self.items.count);
}

#pragma mark - CollectionView delegate methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    customMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    MenuItem *item = self.items[indexPath.row];
    
    cell.collectionView.hidden = YES;
    cell.imageView.image = item.image;
    cell.name.text = item.name;
    cell.gradientImageView.image = [UIImage imageNamed:@"gradient.png"];
    /*
    cell.price.text = @"2000 tenge";
    [cell.button setTitle:@"add" forState:UIControlStateNormal];
    [cell.button setBackgroundColor:[UIColor greenColor]];
    [cell.button addTarget:self action:@selector(addOrder:) forControlEvents:UIControlEventTouchUpInside];
    cell.button.tag = indexPath.row;
    */
     
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(self.view.frame),100);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuItem *item = self.items[indexPath.row];
    self.categoryName = item.name;
    [self performSegueWithIdentifier:@"categoryToItems" sender:self];
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[MenuItemsViewController class]]) {
        MenuItemsViewController *VC = segue.destinationViewController;
        VC.categoryName = self.categoryName;
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
