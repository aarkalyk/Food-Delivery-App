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
@property (nonatomic) NSMutableArray *newsArray;
@property (nonatomic) News *tempNews;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
