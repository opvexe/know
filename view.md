
###     View
```
bringSubviewToFront         将指定的视图推送到前面 
sendSubviewToBack           将指定的视图推送到背面
```

###     layoutSubviews
```
被调用的情况:
1,init初始化不会触发layoutSubviews,但是是用initWithFrame 进行初始化时，当rect的值不为CGRectZero时,也会触发

2,addSubview会触发layoutSubviews

3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化

4、滚动一个UIScrollView会触发layoutSubviews

5、旋转Screen会触发父UIView上的layoutSubviews事件

6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
```

###     setNeedsLayout 
```
标记为需要重新布局，异步调用layoutIfNeeded刷新布局，不立即刷新，但layoutSubviews一定会被调用
```

###     layoutIfNeeded
```
有需要刷新的标记，立即调用layoutSubviews进行布局（如果没有标记，不会调用layoutSubviews）
```

###     setNeedDisplay
```
标上一个需要被重新绘图的标记，在下一个draw周期自动重绘，iphone device的刷新频率是60hz，也就是1/60秒后重绘 
```
