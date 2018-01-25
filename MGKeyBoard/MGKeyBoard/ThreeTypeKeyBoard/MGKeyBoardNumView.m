//
//  MGKeyBoardNumView.m
//  MGKeyBoard
//
//  Created by 马祥忠 on 2018/1/25.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "MGKeyBoardNumView.h"


@interface MGKeyBoardNumView ()

@property (strong, nonatomic) NSArray *numCollections;
@property (strong, nonatomic) UIButton *okButton;
@property (strong, nonatomic) UIButton *switchButtonABC;
@property (strong, nonatomic) UIButton *delButton;
@property (strong, nonatomic) UIImageView *imageViewButton;

//初始化键盘数字
- (void)initNum;
@end

@implementation MGKeyBoardNumView
{
    float space_y;//按钮行间距 和 竖间距
    float numKeyWidth;
    float numKeyHeight;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        self.backgroundColor = RGB(217, 220, 226);

        // 布局
        [self setupLayoutButton];
    }
    return self;
}

#pragma mark - 布局
- (void)setupLayoutButton
{
    //布局按钮
    [self setupNumCollections];
    //切换按钮
    [self setupSwitchABCButton];
    //删除按钮
    [self setupDeleteButton];
}

#pragma mark - 数字按钮布局
- (void)setupNumCollections
{
    int row = 4;
    int column = 3;
    space_y = 7.0;
    numKeyWidth = (self.frame.size.width-(column+1)*space_y)/column;
    numKeyHeight = (self.frame.size.height-(row+1)*space_y)/row;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //布局前面两行
    for (NSInteger i=0; i<2; i++)
    {
        for (NSInteger j=0; j<3; j++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(space_y+ (numKeyWidth+space_y)*j, space_y+( numKeyHeight+space_y)*i, numKeyWidth, numKeyHeight);
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
            [self addSubview:btn];
            [array addObject:btn];
        }
    }
    //布局第三行
    for (NSInteger j=0; j<3; j++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(space_y+ (numKeyWidth+space_y)*j, 2*(numKeyHeight+space_y)+space_y, numKeyWidth, numKeyHeight);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:btn];
        [array addObject:btn];
    }
    
    //最后一行按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(numKeyWidth+2*space_y, 3*(numKeyHeight+space_y)+space_y, numKeyWidth, numKeyHeight);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:btn];
    [array addObject:btn];
    
    //numCollecions保存数字按钮
    self.numCollections = [[NSArray alloc] initWithArray:array];
    
    //给数字按钮设置背景图片
//    UIImage *img = [UIImage imageNamed:@"key_num_column_1"];
//    UIImage *selImg = [UIImage imageNamed:@"key_num_column_1_pressed"];
    for (int i = 0; i < self.numCollections.count; i++)
    {
        UIButton *button = [self.numCollections objectAtIndex:i];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = kCornerRadius;
//        [button setBackgroundImage:img forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:kHightLightColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(onNumbersClick:) forControlEvents:UIControlEventTouchUpInside];
    }

}

- (void)setupSwitchABCButton
{
    self.switchButtonABC = [UIButton buttonWithType:UIButtonTypeCustom];
    self.switchButtonABC.frame = CGRectMake(space_y, 3*(numKeyHeight+space_y)+space_y, numKeyWidth, numKeyHeight);
//    [self.switchButtonABC setBackgroundImage:[UIImage imageNamed:@"key_num_column_1_last_row"] forState:UIControlStateNormal];
    [self.switchButtonABC setBackgroundImage:[UIImage imageWithColor:kHightLightColor] forState:UIControlStateHighlighted];
    self.switchButtonABC.backgroundColor = kBackColor;
    self.switchButtonABC.layer.masksToBounds = YES;
    self.switchButtonABC.layer.cornerRadius = kCornerRadius;
    [self.switchButtonABC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.switchButtonABC setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    self.switchButtonABC.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.switchButtonABC setTitle:@"ABC" forState:UIControlStateNormal];
    [self.switchButtonABC setTitle:@"ABC" forState:UIControlStateHighlighted];
    [self addSubview:self.switchButtonABC];
    [self.switchButtonABC addTarget:self action:@selector(onSwitchABCClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupDeleteButton
{
    self.delButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.delButton.frame = CGRectMake(2*(numKeyWidth+space_y)+space_y, 3*(numKeyHeight+space_y)+space_y, numKeyWidth, numKeyHeight);
    self.delButton.layer.masksToBounds = YES;
    self.delButton.layer.cornerRadius = kCornerRadius;
    [self.delButton setImage:[UIImage imageNamed:@"deleteKeyboard"] forState:UIControlStateNormal];
    [self.delButton setImage:[UIImage imageNamed:@"deleteKeyboard"] forState:UIControlStateHighlighted];
    [self.delButton setBackgroundImage:[UIImage imageWithColor:kBackColor] forState:UIControlStateNormal];
    [self.delButton setBackgroundImage:[UIImage imageWithColor:kHightLightColor] forState:UIControlStateHighlighted];
    [self addSubview:self.delButton];
    [self.delButton addTarget:self action:@selector(onDeleteNumbersClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 初始化数字数据
- (void)initNum
{
    for (int i = 0; i < self.numCollections.count; i++)
    {
        UIButton *button = [self.numCollections objectAtIndex:i];
        [button setTitle:[self.dataSource objectAtIndex:i] forState:UIControlStateNormal];
    }
}

#pragma mark - 键盘点击事件
- (void)onNumbersClick:(id)sender
{
    [self onNumbersAllClick:sender clickKeyboardTag:1000];
}

- (void)onSwitchABCClick:(id)sender
{
    [self onNumbersAllClick:sender clickKeyboardTag:PWD_CLICK_ENG_BTN];
}

- (void)onDeleteNumbersClick:(id)sender
{
    [self onNumbersAllClick:sender clickKeyboardTag:PWD_CLICK_BACK_BTN];
}

- (void)onNumbersAllClick:(id)sender clickKeyboardTag:(int)clickKeyboardTag
{
    UIButton *button = (UIButton *)sender;
    NSString *titleStr = button.currentTitle;
    self.numViewClickBlock(clickKeyboardTag,titleStr);
}



@end
