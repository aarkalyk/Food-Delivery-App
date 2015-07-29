//
//  AboutViewController.m
//  FoodDeliveryApp
//
//  Created by Student on 7/27/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *socialNetworkLabel;

@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *vkButton;

@property (nonatomic) float scrollableHeight;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.socialNetworkLabel.text = @"Follow us in social networks";
    
    self.scrollableHeight = CGRectGetHeight(self.view.frame);
    if (CGRectGetHeight(self.view.frame) == 480) {
        self.scrollableHeight = 580.0;
        NSLog(@"it's iphone 4s");
    }
    if (CGRectGetHeight(self.view.frame) == 568) {
        self.scrollableHeight = CGRectGetHeight(self.view.frame) + 50;
        NSLog(@"it's iphone 5s");
    }
    NSLog(@"%f", self.scrollableHeight);
    
    if (CGRectGetWidth(self.view.frame) == 320) {
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), self.scrollableHeight);
    }
    
    self.imageView.image = [UIImage imageNamed:@"building.jpg"];

    self.textView.text = @"Компания KingFisher поставляет охлажденную, замороженную рыбу и морепродукты в рестораны и сети супермаркетов Алматы, Астаны, Шымкента и других городов Казахстана. Также мы работаем с розничными клиентами, желающими купить продукцию  от KingFisher. Это можно сделать в нашем магазине по адресу г. Алматы, ул. Айманова 155, а так же с помощью услуги бесплатной доставки.";
    self.textView.userInteractionEnabled = NO;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)facebookButtonPressed:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com"]];
}

- (IBAction)vkButtonPressed:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.vk.com"]];
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
