//
//  SettingsViewController.m
//  FoodDeliveryApp
//
//  Created by Student on 7/27/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;

@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *userPhoneNo;
@property (nonatomic) NSString *userAdress;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameTextField.delegate = self;
    self.phoneNumberTextField.delegate = self;
    self.addressTextField.delegate = self;
    
    [self.changeButton setTitle:@"Сохранить" forState:UIControlStateNormal];
    
    //getting user's info from local memory
    self.userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    self.userPhoneNo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhoneNo"];
    self.userAdress = [[NSUserDefaults standardUserDefaults] objectForKey:@"userAdress"];
    
    if (self.userName.length > 0) {
        self.nameTextField.text = self.userName;
    }
    if (self.userPhoneNo.length > 0) {
        self.phoneNumberTextField.text = self.userPhoneNo;
    }
    if (self.userAdress.length > 0) {
        self.addressTextField.text = self.userAdress;
    }
    
    [self.nameTextField setPlaceholder:@"Ваше Имя"];
    [self.addressTextField setPlaceholder:@"Адрес"];
    [self.phoneNumberTextField setPlaceholder:@"Контактный телефон"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveUserData:(UIButton *)sender {
    //saving user's data in local memory
    if (self.nameTextField.text.length != 0) {
        [[NSUserDefaults standardUserDefaults] setObject:self.nameTextField.text forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (self.phoneNumberTextField.text.length != 0) {
        [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberTextField.text forKey:@"userPhoneNo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (self.addressTextField.text.length != 0) {
        [[NSUserDefaults standardUserDefaults] setObject:self.addressTextField.text forKey:@"userAdress"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
