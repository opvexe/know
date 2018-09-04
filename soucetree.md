它是用Xcode生成的工程，默认是用git管理的，所以SourceTree认为那个文件夹是被别的git管理，所以加不进去。
解决办法就是把要添加的文件夹里的隐藏文件夹 .git 删除掉


cd到该文件夹

//删除文件夹下的所有 .svn 文件

find . -name ".svn" | xargs rm -Rf

//删除文件夹下的所有 .git 文件

find . -name ".git" | xargs rm -Rf

### __block修饰   __block Bool  IsTrue = Yes;  Static Bool  IsTrue = Yes; 
```
当在block内部使用block外部定义的局部变量时,如果变量没有被__block修饰,则在block内部是readonly(只读的),

不能对他修改,如果想修改,变量前必须要有__block修饰

__block的作用告诉编译器,编译时在block内部不要把外部变量当做常量使用,还是要当做变量使用.

如果再block中访问全局变量,就不需要__block修饰.
```
