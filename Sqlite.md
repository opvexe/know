###     创建表名
```
#define     Table_Name     @"Users"
```
###      创建表
```
#define     SQL_CREAT_USER_TABLE   @"CREATE TABLE IF NOT EXISTS %@(\
uid TEXT,\
username TEXT,\
nikename TEXT, \
avatar TEXT,\
remark TEXT,\
ext1 TEXT,\
ext2 TEXT,\
ext3 TEXT,\
ext4 TEXT,\
ext5 TEXT,\
PRIMARY KEY(uid))"
```
###     更新表
```
#define     SQL_UPDATE_USER   @"REPLACE INTO %@ ( uid, username, nikename, avatar, remark, ext1, ext2, ext3, ext4, ext5) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
```
###     查询表（By uid）
```
#define     SQL_SELECT_USER_BY_ID           @"SELECT * FROM %@ WHERE uid = %@"
```
###     查询表
```
#define     SQL_SELECT_USERS                @"SELECT * FROM %@"
```
###     删除表
```
#define     SQL_DELETE_USER                 @"DELETE FROM %@ WHERE uid = %@"
```

