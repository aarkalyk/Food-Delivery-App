//
//  ViewController.m
//  FoodDeliveryApp
//
//  Created by Student on 7/20/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *buttonText;
@property (nonatomic) UIImage *image;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self templateWithName:@"Пицца Хат!" andButtonText:@"Начать!" andImageNamed:@"logo.png"];
    
    self.logoImageView.image = self.image;
    self.welcomeLabel.text = @"Добро пожаловать в";
    self.nameLabel.text = self.name;
    [self.startButton setTitle:self.buttonText forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) templateWithName:(NSString *)name andButtonText: (NSString *)buttonText andImageNamed:(NSString *) imageName
{
    self.name = name;
    self.buttonText = buttonText;
    self.image = [UIImage imageNamed:imageName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"start" sender:self];
}

@end
