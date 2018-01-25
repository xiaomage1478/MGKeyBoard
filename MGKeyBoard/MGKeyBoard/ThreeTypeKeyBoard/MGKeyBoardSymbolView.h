//
//  BMGKeyBoardSymbolView.h
//  MGKeyBoard
//
//  Created by 马祥忠 on 2018/1/25.
//  Copyright © 2018年 小马哥. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MGKeyboardHeader.h"

typedef void(^SymbolViewClickBlock)(int state,int key,NSString *inputText);

@interface MGKeyBoardSymbolView : UIView

/** 符号 */
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, copy) SymbolViewClickBlock symbolViewClickBlock;

- (id)initWithFrame:(CGRect)frame;
- (void)initKeyBoard;

@end
