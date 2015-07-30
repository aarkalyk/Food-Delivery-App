//
//  UserInputViewController.m
//  FoodDeliveryApp
//
//  Created by Student on 7/21/15.
//  Copyright (c) 2015 Arkalyk. All rights reserved.
//


#import <NSData+Base64Additions.h>
#import <skpsmtpmessage/SKPSMTPMessage.h>
#import "UserInputViewController.h"
#import <JGProgressHUD/JGProgressHUD.h>



@interface UserInputViewController ()<SKPSMTPMessageDelegate>

@property (nonatomic) NSString *email;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *userAdress;
@property (nonatomic) NSString *userPhoneNo;
@property (nonatomic) NSString *changeMoney;

@property (nonatomic) NSMutableArray *allOrderNames;
@property (nonatomic) NSMutableArray *allOrderPrices;
@property (nonatomic) NSMutableArray *allOrderQuantities;

@property (nonatomic) JGProgressHUD *LoadingHUD;
@property (nonatomic) NSMutableArray *orderDates;
@property (nonatomic) NSMutableArray *orderNames;
@property (nonatomic) NSMutableArray *orderPrices;
@property (nonatomic) NSMutableArray *orderQuantities;
@property (nonatomic) NSMutableArray *orderTotalPrices;
@property (weak, nonatomic) IBOutlet UIButton *orderButton;
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceTextlabel;
@property (weak, nonatomic) IBOutlet UITextField *changeMoneyLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberlabel;
@property (weak, nonatomic) IBOutlet UIImageView *callBackImageView;
@property (weak, nonatomic) IBOutlet UIImageView *placeHolder;

@end

@implementation UserInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setting delegates to the textfields
    self.nameLabel.delegate = self;
    self.addressLabel.delegate = self;
    self.changeMoneyLabel.delegate = self;
    self.phoneNumberlabel.delegate = self;
    
    //hidning placeholders
    self.callBackImageView.image = [UIImage imageNamed:@"placeHolderWhite.png"];
    self.placeHolder.image = [UIImage imageNamed:@"orderPlaceHolder.png"];
    self.callBackImageView.hidden = YES;
    self.placeHolder.hidden = YES;
    
    //getting orderInfo from local memory
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.orderNames = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderNames"]];
    self.orderPrices = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderPrices"]];
    self.orderQuantities = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderQuan"]];
    
    //getting user's info from local memory
    self.userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    self.userPhoneNo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhoneNo"];
    self.userAdress = [[NSUserDefaults standardUserDefaults] objectForKey:@"userAdress"];
    
    //if there's info in local memory input automatically
    if (self.userName.length > 0) {
        self.nameLabel.text = self.userName;
    }
    if (self.userPhoneNo.length > 0) {
        self.phoneNumberlabel.text = self.userPhoneNo;
    }
    if (self.userAdress.length > 0) {
        self.addressLabel.text = self.userAdress;
    }
    
    //if there's no info in local memory input manually
    [self.nameLabel setPlaceholder:@"Ваше Имя"];
    [self.addressLabel setPlaceholder:@"Адрес"];
    [self.changeMoneyLabel setPlaceholder:@"С какой суммы нужна сдача"];
    [self.phoneNumberlabel setPlaceholder:@"Контактный телефон"];
    
    self.totalPriceTextlabel.text = @"Общая сумма:";
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%i тенге", self.totalPrice];
    [self.orderButton setTitle:@"Заказть" forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Helper methods
-(void) composeAnEmail{
    self.userName = [NSString stringWithFormat:@"\rИмя клиента: %@", self.userName];
    self.userPhoneNo = [NSString stringWithFormat:@"Номер клиента: %@", self.userPhoneNo];
    self.userAdress = [NSString stringWithFormat:@"Адрес клиента: %@", self.userAdress];
    
    [self.emailArray addObject:self.userName];
    [self.emailArray addObject:self.userAdress];
    [self.emailArray addObject:self.userPhoneNo];
    if (self.changeMoneyLabel.text.length > 0) {
        self.changeMoney = [NSString stringWithFormat:@"Нужна сдача с %@ тенге", self.changeMoneyLabel.text];
        [self.emailArray addObject:self.changeMoney];
    }
    
    //creating a big string by joining array elements
    self.email = [self.emailArray componentsJoinedByString:@"\r"];
}

-(void) saveHistory{
    //get the current date
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate]; // Get necessary date components
    NSInteger month = [components month]; //gives you month
    NSInteger day   = [components day];   //gives you day
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSString *monthName = [[df monthSymbols] objectAtIndex:(month-1)];
    NSString *monthDay = [NSString stringWithFormat:@"%@ %zd", monthName, day];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.orderTotalPrices = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderTotalPrices"]];
    self.allOrderNames = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"allOrderNames"]];
    self.allOrderPrices = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"allOrderPrices"]];
    self.allOrderQuantities = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"allOrderQuan"]];
    
    if (!self.allOrderNames) {
        self.allOrderNames = [NSMutableArray new];
    }
    [self.allOrderNames addObject:self.orderNames];
    
    if (!self.allOrderPrices) {
        self.allOrderPrices = [NSMutableArray new];
    }
    [self.allOrderPrices addObject:self.orderPrices];
    
    if (!self.allOrderQuantities) {
        self.allOrderQuantities = [NSMutableArray new];
    }
    [self.allOrderQuantities addObject:self.orderQuantities];
    
    if (!self.orderTotalPrices) {
        self.orderTotalPrices = [NSMutableArray new];
    }
    [self.orderTotalPrices addObject:[NSNumber numberWithInt:self.totalPrice]];
    
    self.orderDates = [[NSMutableArray alloc] initWithArray:[userDefaults objectForKey:@"orderDates"]];
    if (!self.orderDates) {
        self.orderDates = [NSMutableArray new];
    }
    [self.orderDates addObject:monthDay];
    
    [userDefaults setObject:self.allOrderNames forKey:@"allOrderNames"];
    [userDefaults setObject:self.allOrderPrices forKey:@"allOrderPrices"];
    [userDefaults setObject:self.allOrderQuantities forKey:@"allOrderQuan"];
    
    [userDefaults setObject:self.orderDates forKey:@"orderDates"];
    [userDefaults setObject:self.orderTotalPrices forKey:@"orderTotalPrices"];
}

#pragma mark - Button methods
- (IBAction)orderButtonPressed:(UIButton *)sender {
    //alert if a user didn't fill a required field
    if (self.nameLabel.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Напишите свое имя" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else if (self.phoneNumberlabel.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Напишите свой номер телефона" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else if(self.addressLabel.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Напишите свой адрес" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    //send email if required fields are filled
    else{
        self.userName = self.nameLabel.text;
        self.userPhoneNo = self.phoneNumberlabel.text;
        self.userAdress = self.addressLabel.text;
        //saving user's data in local memory
        [[NSUserDefaults standardUserDefaults] setObject:self.userName forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] setObject:self.userPhoneNo forKey:@"userPhoneNo"];
        [[NSUserDefaults standardUserDefaults] setObject:self.userAdress forKey:@"userAdress"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self composeAnEmail];
        [self sendEmailInBackground];
        self.LoadingHUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
        [self.LoadingHUD showInView:self.view];
    }
}

#pragma makr - Sending an e-mail
-(void) sendEmailInBackground {
    NSLog(@"Start Sending");
    SKPSMTPMessage *emailMessage = [[SKPSMTPMessage alloc] init];
    emailMessage.fromEmail = @"a.arkalyk@gmail.com"; //sender email address
    emailMessage.toEmail = @"arkalyk.akash@nu.edu.kz";  //receiver email address
    emailMessage.relayHost = @"smtp.gmail.com";
    //emailMessage.ccEmail =@"your cc address";
    //emailMessage.bccEmail =@"your bcc address";
    emailMessage.requiresAuth = YES;
    emailMessage.login = @"a.arkalyk@gmail.com"; //sender email address
    emailMessage.pass = @"worldisperfect"; //sender email password
    emailMessage.subject =@"New app";
    emailMessage.wantsSecure = YES;
    emailMessage.delegate = self; // you must include <SKPSMTPMessageDelegate> to your class
    NSString *messageBody = [NSString stringWithFormat:@"%@", self.email];
    //for example :   NSString *messageBody = [NSString stringWithFormat:@"Tour Name: %@\nName: %@\nEmail: %@\nContact No: %@\nAddress: %@\nNote: %@",selectedTour,nameField.text,emailField.text,foneField.text,addField.text,txtView.text];
    // Now creating plain text email message
    NSDictionary *plainMsg = [NSDictionary
                              dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                              messageBody,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    emailMessage.parts = [NSArray arrayWithObjects:plainMsg,nil];
    //in addition : Logic for attaching file with email message.
    /*
     NSString *filePath = [[NSBundle mainBundle] pathForResource:@"filename" ofType:@"JPG"];
     NSData *fileData = [NSData dataWithContentsOfFile:filePath];
     NSDictionary *fileMsg = [NSDictionary dictionaryWithObjectsAndKeys:@"text/directory;\r\n\tx-
     unix-mode=0644;\r\n\tname=\"filename.JPG\"",kSKPSMTPPartContentTypeKey,@"attachment;\r\n\tfilename=\"filename.JPG\"",kSKPSMTPPartContentDispositionKey,[fileData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
     emailMessage.parts = [NSArray arrayWithObjects:plainMsg,fileMsg,nil]; //including plain msg and attached file msg
     */
    [emailMessage send];
    // sending email- will take little time to send so its better to use indicator with message showing sending...
}

// On success
-(void)messageSent:(SKPSMTPMessage *)message{
    NSLog(@"delegate - message sent");
    
    //deleting order data
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"orderNames"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"orderQuan"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"orderPrices"];
    
    [self saveHistory];
    [self.LoadingHUD dismissAnimated:YES];
    self.callBackImageView.hidden = NO;
    self.placeHolder.hidden = NO;
}
// On Failure
-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    // open an alert with just an OK button
    [self stoploading];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    NSLog(@"delegate - error(%d): %@", [error code], [error localizedDescription]);
}

-(void)stoploading
{
    [self.LoadingHUD dismissAfterDelay:1 animated:YES];
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
