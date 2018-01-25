//
//  MGKeyBoardChatView.h
//  MGKeyBoard
//
//  Created by 马祥忠 on 2018/1/25.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGKeyboardHeader.h"

typedef void(^CharViewClickBlock)(int state,int key,NSString *inputText);

/*
 * 为了给键盘添加取消处理，增加的代理方法
 */
@protocol MGKeyBoardCharViewDelegate <NSObject>

@optional
- (void)KeyBoardCharViewButtonCancel:(id)sender;

@end

@interface MGKeyBoardCharView : UIView
/** 小写 */
@property (nonatomic, strong) NSArray *lowerDataSource;
/** 大写 */
@property (nonatomic, strong) NSArray *upperDataSource;
@property (nonatomic, copy) CharViewClickBlock charViewClickBlock;
@property (nonatomic, weak)id<MGKeyBoardCharViewDelegate> delegate;

- (void)switchKeyBoard;
- (id)initWithFrame:(CGRect)frame;
- (void)initLowerKeyBoard;
- (void)initUpperKeyBoard;

@end
