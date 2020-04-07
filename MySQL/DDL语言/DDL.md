# DDL

## 库的管理

### 创建库

```sql
create datebase if not exists 库名 [character set 字符集名];
```

### 修改库

```sql
alter database 库名 character set 字符集名;
```

### 删除库

```sql
drop database if exists 库名;
```

## 表的管理

### 创建表

```sql
create table if not exists 表名(
    字段名 字段类型 [约束]，
    字段名 字段类型 [约束]，
    ...
    字段名 字段类型 [约束]
);
```

### 修改表

#### 添加列

```sql
alter table 表名 add column 列名 类型;[first|after 字段名];
```

#### 修改列的类型和约束

```sql
alter table 表名 modify column 列名 新类型 [新约束];
```

#### 修改列民

```sql
alter table change column 旧列名 新列名 类型;
```

#### 删除列

```sql
alter table 表名 drop column 列民;
```

#### 修改表名

```sql
alter table 表名 rename [to] 新表名
```

### 删除表

```sql
drop table if exists 表名;
```

### 复制表

#### 复制表的结构

```sql
create table 表名 like 旧表;
```

#### 复制表的结构+数据

```sql
create table 表名
select 查询列表 from 旧表 [where 筛选条件];
```

## 数据类型

### 数值型

1. 整型
    - tinyint     1
    - smallint    2
    - mediumint   3
    - int/integer 4
    - bigint      8

    - 特点：
        1. 都可以设置无符号和有符号，默认是有符号，通过unsigned设置无符号
        2. 如果超出了范围会报out of range，插入临界值
        3. 长度可以不指定，默认会有一个长度，长度代表显示的最大长度，如果不够则左边用0填充，但需要搭配zerofill，并且默认变为无符号整型

2. 浮点型
    - 定点数 decimal(M,D)
    - 浮点数 float(M,D), double(M,D)
    - 特点：
        1. M代表整数部位+小数部位的个数，D代表小数部位
        2. 如果超出范围，则报out of range, 并且插入临界值
        3. M和D都可以省略，但对于定点数，M默认是10,D默认是0
        4. 如果精度要求较高，则优先考虑定点数

### 字符型

char, varchar, binary, varbinary, enum, set, text, blob

- char 固定长度的字符，写法为char(M),最大长度不能超过M，其中M可以省略，默认为1
- varchar 可变长度的字符，写法为varchar(M),最大长度不能超过M，其中M不可以省略

### 日期型

- year 年
- date 日期
- time 时间
- datetime 日期+时间
- timestamp 日期+时间
