### 约束Masonry
```
// 告诉self.view约束需要更新
[self.view setNeedsUpdateConstraints];
// 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
[self.view updateConstraintsIfNeeded];
[UIView animateWithDuration:0.3 animations:^{
[self.view layoutIfNeeded];
}];
```
###  Masonry 文本多行显示
```
label.preferredMaxLayoutWidth = (ScreenWidth - 20.0f);
[label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
[label4 mas_makeConstraints:^(MASConstraintMaker *make) {
make.left.mas_equalTo(10.0);
make.right.mas_equalTo(-10.0);
make.top.mas_equalTo(10.0);
// 自适应label多行显示时，无需设置label高度
}];
```

###   抗被拉伸   -- >  setContentHuggingPriority (值越高，越不容易拉伸，抗拉伸)  UILayoutConstraintAxisVertical（垂直方向） ，UILayoutConstraintAxisHorizontal（水平方向）
```
[label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];

# 优先级 UILayoutPriorityRequired > UILayoutPriorityDefaultHigh > MASLayoutPriorityDefaultMedium > UILayoutPriorityDefaultLow >MASLayoutPriorityFittingSizeLevel 

```
### 抗压缩   -->  setContentCompressionResistancePriority  (值越高，越不容易压缩，抗拉伸)
```
  [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
```

###   布局随着高度变化而变化 
```
///MARK: TOOD 获取所有约束
NSArray *constraints = [textview mas_makeConstraints:^(MASConstraintMaker *make) {
make.top.mas_equalTo(10);
make.left.equalTo(10);
make.right.mas_equalTo(-10);
make.height.mas_equalTo(40);
}];

///MARK: TOOD 获取某个约束
MASConstraint *contraint = constraints.lastObject;
NSLayoutConstraint *layoutConstraint = [contraint valueForKey:@"layoutConstraint"];
CGFloat height = layoutConstraint.constant;
NSLog(@"height = %f", height);

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
if ([text isEqualToString:@"\n"]){
[textView resignFirstResponder];
NSString *string = [textView.text stringByReplacingCharactersInRange:range withString:text];
NSLog(@"string = %@", string);

CGSize size = [string boundingRectWithSize:CGSizeMake((self.view.frame.size.width - 10.0 * 2), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil].size;
CGFloat height = size.height;
NSLog(@"height = %@", @(height));

// 根据实际高度，更新约束
if (height > textView.frame.size.height){
[textView mas_updateConstraints:^(MASConstraintMaker *make) {
make.height.mas_equalTo(height);
}];
}
}

return YES;
}
```
###  Masonry动画
```
[view mas_updateConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(250);
}];
[UIView animateWithDuration:0.3 animations:^{
[self.view layoutIfNeeded];
}];
```

### ipad 包
```
本机是 7.0的系统， xocde支持最低版本需7.0
否则 7.0包安装不上 xcode生成的ipad 包
```
### iOS 状态栏
```
App启动页如果不需要显示状态栏信息，可以设置隐藏。
设置方法依然是修改info.plist，只需要设置Status bar is initially hidden即可 
将其设置为YES之后，启动页将暂时不显示状态栏
```
