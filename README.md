# MGKeyBoard
这是一款自定义键盘，高度封装，使用简单，只需一行代码即可集成。

### 集成

* 使用CocoaPods导入
    > pod 'MGKeyBoard'

* 导入头文件
   > #import <MGPassWordKeyBoard.h>
   
* 调用方法
``` - (void)viewDidLoad {
    [super viewDidLoad];

    UITextField *textField  = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height/2.0f);
    textField.placeholder = @"点击弹出自定义键盘";
    [self.view addSubview:textField];


    MGPassWordKeyBoard *customKeyboard = [[MGPassWordKeyBoard alloc]initKeyboardView];
    customKeyboard.keyBoardLayoutStyle = KeyBoardLayoutStyleDefault;
    [customKeyboard setRelationShipTextFiled:textField];
  }
  ```
   只需要关联到对应的TextField 即可。
   
   ## <a id="期待"></a>期待
   
   - 如果您在使用过程中有任何问题，欢迎issue me! 很乐意为您解答任何相关问题!
   - 如果您想要更多的功能或者什么意见建议，欢迎issue me！我会根据大家的需求来改进！
   
   ## Licenses
   All source code is licensed under the MIT License.
   
  
  
