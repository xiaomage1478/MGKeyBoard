//
//  MGKeyBoardNumView.h
//  MGKeyBoard
//
//  Created by 马祥忠 on 2018/1/25.
//  Copyright © 2018年 小马哥. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MGKeyboardHeader.h"

typedef void(^NumViewClickBlock)(int key,NSString *title);

@interface MGKeyBoardNumView : UIView

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, copy) NumViewClickBlock numViewClickBlock;

//初始化键盘数字
- (void)initNum;

@end
