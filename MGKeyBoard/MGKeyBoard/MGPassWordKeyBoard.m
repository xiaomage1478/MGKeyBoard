//
//  MGPassWordKeyBoard.m
//  MGKeyBoard
//
//  Created by 马祥忠 on 2018/1/25.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "MGPassWordKeyBoard.h"

//屏幕判断
#define plusInch ([UIScreen mainScreen].bounds.size.height > 700)
//密码键盘的宽度
#define kKeyboardPadding 43
#define kKeyboardHeight 253  //整体高度
#define kKeyboardHeightOfKeys kKeyboardHeight - kKeyboardPadding  //按钮布局高度
#define kKeyboardHeightPlus 270 //设置plus尺寸的高度
#define kKeyboardHeightOfKeyPlus kKeyboardHeightPlus - kKeyboardPadding
#define Screen_Width [UIScreen mainScreen].bounds.size.width

@interface MGPassWordKeyBoard ()<MGKeyBoardCharViewDelegate>

@property (nonatomic, strong) UIView *keyBoardLayoutView;
@property (nonatomic, strong) UITextField *relationShipTextFiled;
@property (nonatomic, strong) UIButton *finishedButton;

@property (nonatomic, strong) MGKeyBoardNumView *numView;
@property (nonatomic, strong) MGKeyBoardCharView *charView;

@property (nonatomic, strong) MGKeyBoardSymbolView *symbolView; //符号键盘

// 数字数据源
@property (nonatomic,copy) NSArray *numbersDataSource;
// 字母数据源
@property (nonatomic,copy) NSArray *lettersDataSource;
// 符号数据源
@property (nonatomic,copy) NSArray *symbolsDataSource;
@property (nonatomic,assign) CGRect screenFrame;

@end

@implementation MGPassWordKeyBoard
{
    float keyboardHeight;
    float keyboardHeightOfKeys;
}

#pragma mark - lazy load
- (NSArray *)numbersDataSource
{
    if (!_numbersDataSource) {
        _numbersDataSource = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    }
    return _numbersDataSource;
}

- (NSArray *)lettersDataSource
{
    if (!_lettersDataSource) {
        _lettersDataSource = @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m"];
    }
    return _lettersDataSource;
}

- (NSArray *)symbolsDataSource
{
    if (!_symbolsDataSource) {
        _symbolsDataSource = @[@"!",@"@",@"#",@"$",@"%",@"^",@"&",@"*",@"(",@")",@"'",@"\"",@"=",@"_",@":",@";",@"?",@"~",@"|",@"·",@"+",@"-",@"\\",@"/",@"[",@"]",@"{",@"}",@"，",@".",@"<",@">",@"€",@"£",@"￥"];
    }
    return _symbolsDataSource;
}

#pragma mark - 初始化键盘
- (instancetype)initKeyboardView
{
    [self checkKeyboardHeight];
    
    self = [super initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, keyboardHeight)];
    if (self)
    {
        self.screenFrame = [[UIScreen mainScreen] bounds];
        
        [self setupKeyboardBackgroudView];
        
    }
    return self;
}

// 设置两种键盘高度
- (void)checkKeyboardHeight
{
    if (plusInch){
        keyboardHeight = kKeyboardHeightPlus;
        keyboardHeightOfKeys = kKeyboardHeightOfKeyPlus;
    }else{
        keyboardHeight = kKeyboardHeight;
        keyboardHeightOfKeys = kKeyboardHeightOfKeys;
    }
}

// 设置键盘背景
- (void)setupKeyboardBackgroudView
{
    //设置密码键盘的背景和frame
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, keyboardHeight)];
    backImageView.userInteractionEnabled = YES;
    backImageView.image = [UIImage imageNamed:@"kb_bg1"];
    [self addSubview:backImageView];
    
    float padding = keyboardHeight - keyboardHeightOfKeys;
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, kKeyboardPadding)];
    titleLabel.text=@"MG自定义键盘";
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font=[UIFont systemFontOfSize:16];
    titleLabel.textColor=RGB(0, 123, 237);
    [backImageView addSubview: titleLabel];
    
    UIButton *emptyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    emptyButton.frame = CGRectMake(20,(padding-25)/2.0, 25, 25);
    [emptyButton setBackgroundImage:[UIImage imageNamed:@"deleteCancle"] forState:UIControlStateNormal];
    emptyButton.tag=10004;
    [emptyButton addTarget:self action:@selector(charbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:emptyButton];
    
    //完成按钮
    self.finishedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    float finishedButtonWidth = self.frame.size.width/5;
    self.finishedButton.frame = CGRectMake(self.frame.size.width-finishedButtonWidth, 0, self.frame.size.width/5, kKeyboardPadding-2);
    [self.finishedButton setTitle:@"完 成" forState:UIControlStateNormal];
    self.finishedButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.finishedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.finishedButton.backgroundColor = [UIColor whiteColor];
//    [self.finishedButton setBackgroundImage:[UIImage imageNamed:@"key_num_column_1_pressed"] forState:UIControlStateHighlighted];
    [self.finishedButton addTarget:self action:@selector(onClickOkButton) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:self.finishedButton];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.finishedButton.frame)-1, 0, 0.5, kKeyboardPadding)];
    lineView.backgroundColor=RGB(217, 220, 226);
    [backImageView addSubview:lineView];
    //分隔线
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kb_bg_line"]];
    lineImageView.frame = CGRectMake(0, kKeyboardPadding, self.frame.size.width, 1);
    [backImageView addSubview:lineImageView];
    
    //按钮键盘区域的frame
    self.keyBoardLayoutView = [[UIView alloc] initWithFrame:CGRectMake(0, kKeyboardPadding, self.frame.size.width, keyboardHeightOfKeys)];
    self.keyBoardLayoutView.backgroundColor = [UIColor clearColor];
    [backImageView addSubview:self.keyBoardLayoutView];
}

#pragma mark - 设置键盘 创建字母、数字、符号
- (void)setKeyBoardLayoutStyle:(KeyBoardLayoutStyle)keyBoardLayoutStyle
{
    _keyBoardLayoutStyle = keyBoardLayoutStyle;
    
    CGRect childenFrame = CGRectMake(0, 0, CGRectGetWidth(self.screenFrame), CGRectGetHeight(self.keyBoardLayoutView.frame));
    
    // 创建视图
    [self initNumkeyBoard];
    [self initCharkeyBoard];
    [self initSymbolkeyBoard];
    
    self.numView.frame = childenFrame;
    self.charView.frame = childenFrame;
    self.symbolView.frame = childenFrame;
    
    [self.keyBoardLayoutView addSubview: self.numView];
    [self.keyBoardLayoutView addSubview: self.charView];
    [self.keyBoardLayoutView addSubview: self.symbolView];
    
    switch (keyBoardLayoutStyle)
    {
        case KeyBoardLayoutStyleNumbers:
        {
            self.numView.hidden = YES;
            self.charView.hidden = YES;
            self.symbolView.hidden = YES;
        }
            break;
        case KeyBoardLayoutStyleLetters:
        {
            self.numView.hidden = YES;
            self.charView.hidden = NO;
            self.symbolView.hidden = YES;
            [self.charView initLowerKeyBoard];
        }
            break;
        case KeyBoardLayoutStyleUperLetters:
        {
            self.numView.hidden = YES;
            self.charView.hidden = NO;
            self.symbolView.hidden = YES;
            [self.charView initUpperKeyBoard];
        }
            break;
        default:
            _keyBoardLayoutStyle = KeyBoardLayoutStyleDefault;
            self.numView.hidden = YES;
            self.charView.hidden = NO;
            self.symbolView.hidden = YES;
            [self.charView initLowerKeyBoard];
            break;
    }
}

#pragma mark - 实例化数字键盘（实例化一次）
- (void)initNumkeyBoard
{
    self.numView = [[MGKeyBoardNumView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, keyboardHeightOfKeys)];
    self.numView.dataSource = self.numbersDataSource;
    [self.numView initNum];
    __block MGPassWordKeyBoard *blockSelf = self;
    self.numView.numViewClickBlock = ^(int key,NSString *inputTex){
        NSLog(@"key = %d",key);
        switch (key)
        {
            case PWD_CLICK_ENG_BTN:
                [blockSelf onClickSwitchABCButton];
                break;
            case PWD_CLICK_BACK_BTN:
                [blockSelf onClickDelButton];
                break;
            case PWD_CLICK_OK_BTN:
                [blockSelf onClickOkButton];
                break;
            default:
                [blockSelf onClickChar:inputTex];
                break;
        }
    };
}

#pragma mark - 实例化字母键盘（实例化一次）
- (void)initCharkeyBoard
{
    self.charView = [[MGKeyBoardCharView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, keyboardHeightOfKeys)];
    self.charView.lowerDataSource = self.lettersDataSource;
    self.charView.delegate = self;
    __block MGPassWordKeyBoard *blockSelf = self;
    self.charView.charViewClickBlock = ^(int state, int key,NSString *inputText)
    {
        switch (key) {
            case PWD_CLICK_NUMBER_BTN:
                [blockSelf onClickSwitch123Button];
                break;
            case PWD_CLICK_BACK_BTN:
                [blockSelf onClickDelButton];
                break;
            case PWD_CLICK_OK_BTN:
                [blockSelf onClickOkButton];
                break;
            case PWD_CLICK_SHIFT_BTN:
                [blockSelf onClickSwitchButton];
                break;
            case PWD_CLICK_SYMBOL_BTN:
                [blockSelf onClickChangeSymbolView];
                break;
            default:
                [blockSelf onClickChar:inputText];
                break;
        }
    };
}

#pragma mark - 实例化符号键盘（实例化一次）
- (void)initSymbolkeyBoard
{
    self.symbolView = [[MGKeyBoardSymbolView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, keyboardHeightOfKeys)];
    self.symbolView.dataSource = self.symbolsDataSource;
    
    [self.symbolView initKeyBoard];
    
    __block MGPassWordKeyBoard *blockSelf = self;
    self.symbolView.symbolViewClickBlock = ^(int state, int key, NSString *inputText)
    {
        switch (key)
        {
            case PWD_CLICK_NUMBER_BTN:
                [blockSelf onClickSwitch123Button];
                break;
            case PWD_CLICK_BACK_BTN:
                [blockSelf onClickDelButton];
                break;
            case PWD_CLICK_OK_BTN:
                [blockSelf onClickOkButton];
                break;
            case PWD_CLICK_ENG_BTN:
                [blockSelf onClickSwitchABCButton];
                break;
            default:
                [blockSelf onClickChar:inputText];
                break;
        }
    };
}

- (void)setRelationShipTextFiled:(UITextField *)relationShipTextFiled
{
    if (_relationShipTextFiled != relationShipTextFiled)
    {
        _relationShipTextFiled = relationShipTextFiled;
        _relationShipTextFiled.inputView = self;
    }
}

#pragma  mark - 点击非功能键
- (void)onClickChar:(NSString *)inputStr
{
    if (self.relationShipTextFiled) {
        NSRange selectionRange = [self.relationShipTextFiled selectedRange];
        self.relationShipTextFiled.text = [self.relationShipTextFiled.text stringByReplacingCharactersInRange:selectionRange withString:inputStr];
        [self.relationShipTextFiled setSelectedRange:NSMakeRange(selectionRange.location+1, 0)];
    }
}
#pragma  mark - 点击清空
- (void)charbuttonClick:(UIButton *)button
{
    self.relationShipTextFiled.text = @"";
}
#pragma  mark - 点击OK
- (void)onClickOkButton
{
    if (self.relationShipTextFiled)
    {
        [self.relationShipTextFiled resignFirstResponder];
    }
}

#pragma  mark - 点击删除
- (void)onClickDelButton
{
    NSUInteger stringLength = self.relationShipTextFiled.text.length;
    NSRange selectionRange = [self.relationShipTextFiled selectedRange];
    if (stringLength > 0) {
        
        if (selectionRange.length>0) {
            self.relationShipTextFiled.text = [self.relationShipTextFiled.text stringByReplacingCharactersInRange:selectionRange withString:@""];
            [self.relationShipTextFiled setSelectedRange:NSMakeRange(selectionRange.location, 0)];
        }else{
            if (selectionRange.location>0) {
                self.relationShipTextFiled.text = [self.relationShipTextFiled.text stringByReplacingCharactersInRange:NSMakeRange(selectionRange.location-1, 1) withString:@""];
                [self.relationShipTextFiled setSelectedRange: NSMakeRange(selectionRange.location-1, 0)];
            }
        }
    }
}

#pragma  mark - 数字键盘点击切换字母键盘
- (void)onClickSwitchABCButton
{
    self.numView.hidden = YES;
    self.symbolView.hidden = YES;
    self.charView.hidden = NO;
}

#pragma  mark - 切换数字键盘
- (void)onClickSwitch123Button
{
    
    self.charView.hidden = YES;
    self.symbolView.hidden = YES;
    self.numView.hidden = NO;
    
}

#pragma  mark - 切换到符号键盘
- (void)onClickChangeSymbolView
{
    self.numView.hidden = YES;
    self.charView.hidden = YES;
    self.symbolView.hidden = NO;
}

#pragma  mark - 字母大小写切换
- (void)onClickSwitchButton
{
    [self.charView switchKeyBoard];
}

@end
