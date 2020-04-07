#常见的数据类型
/*
数值型:
	整型
    小数:	定点数
			浮点数
字符型:
	较短的文本: char, varchar
    较长的文本: text, blob(较长的二进制数据)
日期型:
	
*/
#一、整型
/*
分类：
Tinyint			1 byte
Smallint		2 bytes
Mediumint		3 bytes
Int, integer	4 bytes
Bigint			8 bytes

特点：
1.如果不设置有符号无符号，默认是有符号，如果想设置无符号，需要添加unsigned
2.如果插入的数据超出范围，会报out of range异常，并且插入的是临界值
3.如果不设置长度，会有默认的长度
4.长度代表了显示的最大宽度，如果不够会用0在左边填充，但必须搭配ZEROFILL 默认变成无符号
*/

#1. 如何设置无符号和有符号
CREATE TABLE tbale_int(
	t1 INT
);
ALTER TABLE tbale_int RENAME TO table_int;
DESC table_int;

INSERT INTO table_int VALUES(-123456);
ALTER TABLE table_int ADD COLUMN t2 INT UNSIGNED;
DESC table_int;
SELECT * FROM table_int;
INSERT INTO table_int VALUES(-2121,-2121);
INSERT INTO table_int VALUES(-2121,12121);
SELECT * FROM table_int;

#二、小数
/*
分类：
1. 浮点数
float(M, D)
double(M, D）

2. 定点数
dec(M,D)
decimal(M,D)

特点：
1.M和D
M:整数部位+小数部位
D：小数部位
2. M和D都可以省略
如果是decimal，则M默认是10, D默认是0
如果是float和double,则会根据插入数值的精度来决定精度
3.定点型的精确度较高，如果要求插入数值的精度较高如货币运算等则考虑使用
*/
#测试M，D
CREATE TABLE tab_float(
	f1 FLOAT(5, 2),
    f2 DOUBLE(5, 2),
    f3 DECIMAL(5,2)
);
DESC tab_float;
INSERT INTO tab_float VALUES(123.45, 123.45, 123.45);
SELECT * FROM tab_float;
INSERT INTO tab_float VALUES(123.456, 123.456, 123.456);
SELECT * FROM tab_float;
INSERT INTO tab_float VALUES(123.4, 123.4, 123.4);
SELECT * FROM tab_float;
INSERT INTO tab_float VALUES(1523.4, 1523.4, 1523.4);
SELECT * FROM tab_float;
DROP TABLE tab_float;

CREATE TABLE tab_float(
	f1 FLOAT,
    f2 DOUBLE,
    f3 DECIMAL
);
DESC tab_float;
INSERT INTO tab_float VALUES(123.4523, 123.4523, 123.4523);
SELECT * FROM tab_float;
INSERT INTO tab_float VALUES(123.456, 123.456, 123.456);


#原则
/*
所选择的类型越简单越好，能保存数值的类型越小越好
*/

#三、字符型
/*
较短的文本：
char
varchar

其他：
binary和varbinary用于保存较短的二进制
enum用于保存枚举
set用于保存集合

较长的文本：
text
blob(较大的二进制)

特点：

		写法			M的意思								特点				空间			效率
char	char(M)		最大的字符数，可以省略，默认是1			固定长度的字符		比较耗费		高
varchar	varchar(M)	最大的字符数，不可以省略				可变长度的字符		比较节省		低
*/
CREATE TABLE tab_char(
	c1 ENUM('a', 'b', 'c')
);
DESC tab_char;
INSERT INTO tab_char VALUES('a');
INSERT INTO tab_char VALUES('b');
INSERT INTO tab_char VALUES('c');
INSERT INTO tab_char VALUES('m');
INSERT INTO tab_char VALUES('A');
SELECT * FROM tab_char;

CREATE TABLE tab_set(
	s1 SET('a','b', 'c', 'd')
);
INSERT INTO tab_set VALUES('a');
INSERT INTO tab_set VALUES('a,b');
INSERT INTO tab_set VALUES('a,c,d');
SELECT * FROM tab_set;
INSERT INTO tab_set VALUES('A');
SELECT * FROM tab_set;

#四、日期型
/*
分类：
date 只保存日期
time 只保存时间
year 只保存年

datetime 保存日期+时间
timestamp 保存日期+时间

特点：
			字节		范围				时区影响
datetime	8		1000-9999		不受
timestamp	4		1970-2038		受
*/
CREATE TABLE tab_date(
	t1 DATETIME,
    t2 TIMESTAMP
);
DESC tab_date;
INSERT INTO tab_date VALUES(NOW(), NOW());
SELECT * FROM tab_date;
SHOW VARIABLES LIKE 'time_zone';
SET time_zone ='+9:00';
SHOW VARIABLES LIKE 'time_zone';
SELECT * FROM tab_date;




