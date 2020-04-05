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




