//
//  NewAnnalViewController.m
//  百度旅游
//
//  Created by Lucky on 13-3-30.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "NewAnnalViewController.h"


@interface NewAnnalViewController ()

@end

@implementation NewAnnalViewController
@synthesize mTextField;
@synthesize residualtextfieldLength;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [mTextField becomeFirstResponder];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    residualtextfieldLength = 30;
	// Do any additional setup after loading the view.
    UIColor * color = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"image_TinyTravelNote_ThemeEdit_Background"]];
    self.view.backgroundColor = color;
    [color release];
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    
    //button
    UIButton * rgtButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rgtButton.frame = CGRectMake(10, 7, 51, 30);
    [rgtButton setBackgroundImage:[UIImage imageNamed:@"image_title_button"] forState:UIControlStateNormal];
    [rgtButton setBackgroundImage:[UIImage imageNamed:@"image_title_button_down"] forState:UIControlStateHighlighted];
    [rgtButton setTitle:@"完成" forState:UIControlStateNormal];
    rgtButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rgtButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rgtButton addTarget:self action:@selector(pressRightButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rghButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rgtButton];
    self.navigationItem.rightBarButtonItem = rghButtonItem;
    
    
    
    UIButton * lftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    lftButton.frame = CGRectMake(10, 7, 51, 30);
    [lftButton setBackgroundImage:[UIImage imageNamed:@"image_titlebar_back_button"] forState:UIControlStateNormal];
    [lftButton setBackgroundImage:[UIImage imageNamed:@"image_titlebar_back_button_pressed"] forState:UIControlStateSelected];
    [lftButton setTitle:@"返回" forState:UIControlStateNormal];
    lftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [lftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lftButton addTarget:self action:@selector(pressLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    
    //textField————————————————————————————————————————————————————————————
    mTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 300, 30)];
    [mTextField setBackgroundColor:[UIColor whiteColor]];
    mTextField.delegate = self;
    [self.view addSubview:mTextField];
   // [mTextField setTextAlignment:NSTextCheckingTypeReplacement];
    mTextField.font = [UIFont systemFontOfSize:14];
    mTextField.placeholder = @"请输入游记的名称";
    
    //labels
    UILabel * firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 32, 200, 20)];
    firstLabel.text = @"给这次旅行起个名字吧";
    firstLabel.textAlignment = NSTextAlignmentLeft;
    firstLabel.font = [UIFont systemFontOfSize:11];
//    firstLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    firstLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:firstLabel];
    [firstLabel release];
    
    tailLable = [[UILabel alloc] initWithFrame:CGRectMake(210, 98, 100, 20)];
    tailLable.font = [UIFont systemFontOfSize:11];
    tailLable.textColor = [UIColor grayColor];
    tailLable.text = [NSString stringWithFormat:@"剩余%d个字",residualtextfieldLength];
    tailLable.backgroundColor = [UIColor clearColor];
    tailLable.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:tailLable];
    
}
-(void)pressRightButton:(UIButton *) btn
{



}
-(void)pressLeftButton:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    tailLable.text = [NSString stringWithFormat:@"剩余%d个字",residualtextfieldLength];
//
//}
//-(BOOL)tex 
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//
//tailLable.text = [NSString stringWithFormat:@"剩余%d个字",residualtextfieldLength];
//}
//计算剩余字数
-(BOOL)textFieldShouldClear:(UITextField *)textField
{   //textField.text = @"";
    residualtextfieldLength = 30;
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.text = @"";
    residualtextfieldLength = 30;

}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    residualtextfieldLength = 30;
    //textField.text =@"";
    return  YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text length]!= 0) {
        residualtextfieldLength = 30 - location;
    }
    residualtextfieldLength = 30;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (range.location >= 29) {
        residualtextfieldLength = 0;
        location = range.location;
        tailLable.text = [NSString stringWithFormat:@"剩余%d个字",residualtextfieldLength];
        return  NO;
    }
    else
    {
       // int exsit = [string length];
        int exsit = range.location;
        if (0 == exsit) {
            residualtextfieldLength = 30 ;
            location = 0;
        }
        else{
        residualtextfieldLength = 30 - exsit;
            location = exsit;
        }
        
        tailLable.text = [NSString stringWithFormat:@"剩余%d个字",residualtextfieldLength];
        return YES;
    }
    


}


//键盘收回
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    residualtextfieldLength = 30 - location;
    [textField resignFirstResponder];
    return YES;
}
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [mTextField resignFirstResponder];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
