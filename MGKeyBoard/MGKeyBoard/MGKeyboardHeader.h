//
//  MGKeyboardHeader.h
//  MGKeyBoard
//
//  Created by 马祥忠 on 2018/1/25.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#ifndef MGKeyboardHeader_h
#define MGKeyboardHeader_h

#import <AudioToolbox/AudioToolbox.h>

#import "UIImage+Color.h"
#import "UITextField+Selection.h"

#import "MGKeyBoardCharView.h"
#import "MGKeyBoardSymbolView.h"
#import "MGKeyBoardNumView.h"

//
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

//
//按钮圆角
#define kCornerRadius 5.0
//输出型按钮常规颜色
#define kNormalColor [UIColor whiteColor]
//高亮颜色
#define kHightLightColor RGB(240, 244, 250)
//功能性按钮背景颜色 eg. ABC, #-+, 123, delete ,shift
#define kBackColor RGB(187, 190, 196)


/**
 * return value define <begin>
 */
#define PWD_RESULT_OK 1
#define PWD_RESULT_FAILED -1
#define PWD_RESULT_FAILED_LENTH_ERROR -2
#define PWD_CLICK_SYMBOL_BTN -4
#define PWD_CLICK_SHIFT_BTN -5
#define PWD_CLICK_NUMBER_BTN -6
#define PWD_CLICK_ENG_BTN -7
#define PWD_CLICK_BACK_BTN -8
#define PWD_CLICK_OK_BTN -9
/**
 * keyboard return value define <end>
 */

/**
 * keyboard constant value define <begin>
 */
#define PWD_NUMBER_COUNT 10
#define PWD_EVERY_ENCRYPT_LENTH 8
#define PWD_PASSKEY_LENTH 8
#define PWD_ENG_COUNT 26

#define KEYBOARD_TYPE_NUMBER 0
#define KEYBOARD_TYPE_SMALL_ENGLISH 1
#define KEYBOARD_TYPE_BIG_ENGLISH 2
#define KEYBOARD_TYPE_SYMBOLS 3


#endif /* MGKeyboardHeader_h */
