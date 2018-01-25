//
//  ViewController.m
//  MGKeyBoard
//
//  Created by 马祥忠 on 2018/1/25.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "ViewController.h"
#import "MGPassWordKeyBoard.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *textField  = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height/2.0f);
    textField.placeholder = @"点击弹出自定义键盘";
    [self.view addSubview:textField];
    
    
    MGPassWordKeyBoard *customKeyboard = [[MGPassWordKeyBoard alloc]initKeyboardView];
    customKeyboard.keyBoardLayoutStyle = KeyBoardLayoutStyleDefault;
    [customKeyboard setRelationShipTextFiled:textField];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
