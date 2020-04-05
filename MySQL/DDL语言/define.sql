#DDL
/*
数据定义语言
Data Define Language

库和表的管理

一、库的管理
创建、修改、删除
二、表的管理
创建、修改、删除

创建： create
修改： alter
删除： drop
*/

#一、库的管理
#1、库的创建
/*
语法：
create database 库名
*/

#案例： 创建库books
CREATE DATABASE IF NOT EXISTS books;

#2、库的修改
#更改库的字符集
ALTER DATABASE books CHARACTER SET utf8;

#3、库的删除
DROP DATABASE IF EXISTS books;


#二、表的管理
#1.表的创建*
/*
create table 表民（
	列名 列的类型[（长度）约束]，
    列名 列的类型[（长度）约束]，
    列名 列的类型[（长度）约束]，
    ...
    列名 列的类型[（长度）约束]
）
*/
#案例：创建book表
CREATE TABLE book(
	id INT, #书的编号
    bookName VARCHAR(20), #图书名
    price DOUBLE, #价格
    authorID INT, #作者编号
    publishDate DATETIME #出版日期
);

DESC book;

CREATE TABLE IF NOT EXISTS author(
	id INT,
    authorName VARCHAR(20),
    nation VARCHAR(10)
);

DESC author;

#2.表的修改
/*
alter table 表名 add|modify|drop|change column 列民 [列的类型 约束]
*/
#修改列民
ALTER TABLE book CHANGE COLUMN publishDate pubDate DATETIME;
DESC book;

#修改列的类型或约束
ALTER TABLE book MODIFY COLUMN pubDate TIMESTAMP;
DESC book;

#添加新列
ALTER TABLE author ADD COLUMN annual DOUBLE;
DESC author;
#删除列
ALTER TABLE author DROP COLUMN annual;
DESC author;
#修改表名
ALTER TABLE author RENAME TO  book_author;
SHOW TABLES;

#3.表的删除
DROP TABLE IF EXISTS book_author;
SHOW TABLES;

#通用的写法：
DROP DATABASE IF EXISTS 旧库名;
CREATE DATABASE 新库名;

DROP TABLE IF EXISTS 旧表名;
CREATE TABLE 表民();

#4.表的复制
DESC author;
ALTER TABLE author CONVERT TO CHAR SET utf8mb4;
INSERT INTO author VALUES
(1,'村上春数','日本'),
(2,'莫言','中国'),
(3,'冯唐','中国'),
(4,'金庸','中国');
SELECT * FROM author;

#仅复制表的结构
CREATE TABLE copy LIKE author;
DESC copy;
SELECT * FROM copy;

#复制表的结构+数据
CREATE TABLE copy2
SELECT * FROM author;
DESC copy2;
SELECT * FROM copy2;

#只复制部分数据
CREATE TABLE copy3
SELECT id, authorName
FROM author
WHERE nation='中国';
DESC copy3;
SELECT * FROM copy3;

#仅仅复制某些字段, 不要数据
CREATE TABLE copy4
SELECT id, authorName
FROM author
WHERE false;
DESC copy4;
SELECT * FROM copy4;








