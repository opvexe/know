它是用Xcode生成的工程，默认是用git管理的，所以SourceTree认为那个文件夹是被别的git管理，所以加不进去。
解决办法就是把要添加的文件夹里的隐藏文件夹 .git 删除掉


cd到该文件夹

//删除文件夹下的所有 .svn 文件

find . -name ".svn" | xargs rm -Rf

//删除文件夹下的所有 .git 文件

find . -name ".git" | xargs rm -Rf