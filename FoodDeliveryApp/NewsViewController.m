//
//  NewsViewController.m
//  FoodDeliveryApp
//
//  Created by Student on 7/27/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "DetailednewsViewController.h"
#import "NewsCollectionViewCell.h"
#import "NewsViewController.h"
#import <Parse/Parse.h>
#import "News.h"

@interface NewsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *whitePlaceHolder;
@property (weak, nonatomic) IBOutlet UIImageView *logoPlaceHolder;
@property (nonatomic) NSMutableArray *newsArray;
@property (nonatomic) News *tempNews;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setting up the placeholders
    self.whitePlaceHolder.image = [UIImage imageNamed:@"placeHolderWhite.png"];
    self.whitePlaceHolder.hidden = NO;
    self.logoPlaceHolder.image = [UIImage imageNamed:@"logo.png"];
    self.logoPlaceHolder.hidden = NO;
    
    self.newsArray = [NSMutableArray new];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[NewsCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    [self getDataFromParse];
    // Do any additional setup after loading the view.
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

#pragma mark - Parse methods
-(void)getDataFromParse{
    PFQuery *query = [PFQuery queryWithClassName:@"News"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *title = object[@"title"];
                NSString *text = object[@"text"];
                PFFile *file = object[@"image"];
                [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    UIImage *image = [UIImage imageWithData:data];
                    News *news = [[News alloc] initWithTitle:title andText:text andImage:image];
                    NSLog(@"%@", title);
                    [self addNewNews:news];
                }];
            }
            [self hidePlaceHolder];
        }
    }];
}

-(void) addNewNews:(News *)news{
    [self.newsArray addObject:news];
    NSLog(@"size - %zd", self.newsArray.count);
    [self.collectionView reloadData];
}

#pragma mark - Collectionview delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.newsArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    News *news = self.newsArray[indexPath.row];
    
    cell.viewUpper.backgroundColor = [UIColor grayColor];
    cell.viewLower.backgroundColor = [UIColor grayColor];
    cell.headerLabel.text = news.title;
    cell.imageView.image = [UIImage imageNamed:@"rightArrow.png"];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 50);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.tempNews = self.newsArray[indexPath.row];
    [self performSegueWithIdentifier:@"detailedNews" sender:self];
}

#pragma mark - Segue methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[DetailednewsViewController class]]) {
        DetailednewsViewController *VC = segue.destinationViewController;
        VC.news = self.tempNews;
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
