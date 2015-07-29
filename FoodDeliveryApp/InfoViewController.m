//
//  InfoViewController.m
//  FoodDeliveryApp
//
//  Created by Student on 7/20/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *workingHoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *minOrderPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *freeDeliveryLabel;

@property (weak, nonatomic) IBOutlet UITextView *workingHoursTextView;
@property (weak, nonatomic) IBOutlet UITextView *minOderPriceTextView;
@property (weak, nonatomic) IBOutlet UITextView *freeDeliveryTextView;

@property (weak, nonatomic) IBOutlet UIButton *startOrderingButton;
@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTemplateWithPrice:2000];
    self.logoImageView.image = [UIImage imageNamed:@"logoSmall.png"];
    
    self.workingHoursLabel.text = @"Режим работы";
    self.minOrderPriceLabel.text = @"Минимальный заказ";
    self.freeDeliveryLabel.text = @"Бесплатная доставка";
    
    [self.startOrderingButton setTitle:@"ПРИСТУПИТЬ К ЗАКАЗУ" forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view.
}

-(void) setTemplateWithPrice:(int) price
{
    self.workingHoursTextView.text = @"Ежедневно с 9:00 до 22:00";
    self.minOderPriceTextView.text = [NSString stringWithFormat:@"%i тг + бесплатная доставка", price];
    self.freeDeliveryTextView.text = @"Бесплатная доставка в Алматы и Астане Осуществляется в пределах заданного квадрата (описание содержится в разделе Доставка)\r\rДоставка в другие районы города рассматривается дополнительно: Алматы от 700 тг, Астана - от 1000 тг. Компания оставляет за собой отказать в осуществлении доставки по тем или иным причинам.";
    
    self.workingHoursTextView.userInteractionEnabled = NO;
    self.minOderPriceTextView.userInteractionEnabled = NO;
    self.freeDeliveryTextView.userInteractionEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startOrderingButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"startOrdering" sender:self];
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
