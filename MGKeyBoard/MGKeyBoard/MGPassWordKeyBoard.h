//
//  MGPassWordKeyBoard.h
//  MGKeyBoard
//
//  Created by 马祥忠 on 2018/1/25.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGKeyboardHeader.h"

typedef NS_ENUM(NSInteger, KeyBoardLayoutStyle)
{
    KeyBoardLayoutStyleDefault=-1,   //默认字母
    KeyBoardLayoutStyleNumbers=0,   //数字
    KeyBoardLayoutStyleLetters=1,    //小写字母
    KeyBoardLayoutStyleUperLetters=2,    //大些字母
    KeyBoardLayoutStyleSymbol    //符号
};

@interface MGPassWordKeyBoard : UIView

/**
 *  键盘属性
 */
@property (nonatomic, assign) KeyBoardLayoutStyle keyBoardLayoutStyle;

/**
 初始化键盘
 */
- (instancetype)initKeyboardView;

/**
 *	@brief	键盘输入框和界面输入框关联
 *
 *	@param 	relationShipTextFiled 	界面输入框
 */
- (void)setRelationShipTextFiled:(UITextField *)relationShipTextFiled;

@end


