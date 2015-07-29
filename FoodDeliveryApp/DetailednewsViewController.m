//
//  DetailednewsViewController.m
//  FoodDeliveryApp
//
//  Created by Student on 7/27/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "DetailednewsViewController.h"

@interface DetailednewsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailednewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = self.news.image;
    self.textView.text = self.news.text;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
