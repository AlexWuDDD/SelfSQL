#DML语言
/*
数据操作语言:
插入：insert
修改：update
删除：delete
*/

#插入语句：方式１：
/*
语法：
insert into 表名(列名,...) values(值１, ...);

*/
#插入的值的类型要与需要的列的类型一只或兼容
INSERT INTO beauty(id, name, sex, borndate, phone, photo, boyfriend_id)
VALUES(13, '唐艺昕', '女', '1990-4-23', '18988888888', NULL, 2);
SELECT * FROM beauty;

#不可以为NULL的列必须插入值，可以为NULL的列如何插入值？
#方式１：
INSERT INTO beauty(id, name, sex, borndate, phone, photo, boyfriend_id)
VALUES(13, '唐艺昕', '女', '1990-4-23', '18988888888', NULL, 2);
#方式２：
INSERT INTO beauty(id, name, sex, borndate, phone, boyfriend_id)
VALUES(14, '金星', '女', '1980-4-23', '13888888888',9);
SELECT * FROM beauty;

#.列的顺序是否可以调换，可以，但要一一对应
#.列数和值的个数必须一致
#.可以省略列民，默认是所有列，而且列的顺序和表中的列的顺序是一致的
INSERT INTO beauty(id, name, sex, borndate, phone, photo, boyfriend_id)
VALUES(15, '张飞', '男', NULL, '19988888888', NULL, NULL);

#插入语句：方式２：
/*
语法：
insert into 表名
set 列民＝值，列民＝值，．．．
*/
INSERT INTO beauty
SET id=19, name='刘涛', phone=9999;

#两种方式大ＰＫ
#1.方式一可以插入多行,但是方式二不支持
/*
INSERT INTO beauty(id, name, sex, borndate, phone, photo, boyfriend_id)
VALUES(23, '唐艺昕', '女', '1990-4-23', '18988888888', NULL, 2),
(33, '唐艺昕', '女', '1990-4-23', '18988888888', NULL, 2),
(43, '唐艺昕', '女', '1990-4-23', '18988888888', NULL, 2),
(53, '唐艺昕', '女', '1990-4-23', '18988888888', NULL, 2);
*/
#2.方式一支持子查询，方式二不支持
INSERT INTO beauty(id, name, phone)
SELECT 90, '宋茜', '9090';

#修改语句：
/*
1.修改单表的记录(＊)
语法:
update 表民
set 列=新值,列=新值,列=新值,....
where 筛选条件;
　
2.修改多表的记录
语法:
SQL92:
update 表１ 别名，表2 别名
set 列=值，....
where 连接条件
and 筛选条件;

SQL99:
update 表1 别名
inner|left|right join 表2 别名
on 连接条件
set 列=值, 列=值,....
where 筛选条件

*/

#1.修改单表的记录
#修改beaｕty表中姓唐的女神的电话为13899888899
UPDATE beauty SET phone='13899888899' WHERE name LIKE '唐%';

#修改boy表中的id号为２的名称为张飞，魅力值为10
UPDATE boys SET boyName='张飞', userCP=10 WHERE id=2;

#2.修改多表的记录
#案例1：修改张无忌的女朋友的手机号码为114
UPDATE beauty b
INNER JOIN boys bo
ON b.boyfriend_id = bo.id
SET b.phone = '114'
WHERE bo.boyName = '张无忌';

#案例2: 修改没有男朋友的女神的男朋友的编号都为2号
UPDATE beauty b
LEFT JOIN boys bo
ON b.boyfriend_id = bo.id
SET b.boyfriend_id = 2
WHERE bo.id IS NULL;

#删除语句
/*
方式一： delete 整行 没有where就整表
语法：
1.单表的删除
delete from 表名 where 筛选条件
2.多表的删除[补充]

sql92语法：
delete 表1的别名，表2的别名
from 表1 别名，表2 别名
where 连接条件
and 筛选条件

sql99语法：
delete 表1的别名，表2的别名
from 表1 别名
inner|left|right join 表2 别名 on 连接条件
where 筛选条件;

方式二：truncate
语法：truncate table 表民;
*/

#方式一：delete 
#1.单表的删除
#案例1：删除手机号以9结尾的女神信息
DELETE FROM beauty WHERE phone LIKE '%9';

#2.多表的删除
#案例1：删除张无忌的女朋友的信息
DELETE b
FROM beauty b
INNER JOIN boys bo ON b.boyfriend_id = bo.id
WHERE bo.boyName = '张无忌';

#案例2: 删除黄晓的信息以及他女朋友的信息
DELETE b, bo
FROM beauty b
INNER JOIN boys bo ON b.boyfriend_id = bo.id
WHERE bo.boyName = '黄晓';

#方式2： truncate语句

#案例：将魅力值大于100的男神信息删除
TRUNCATE TABLE boys; #只能全删

/*
1.delete可以加where条件，truncate不能加
2.truncate删除，效率高一丢丢
3. 假如要删除的表中有自增列，
如果用delete删除后，再插入数据，
自增长列的值从断点开始，而truncate删除后，再插入数据，自增长列的值从1开始。
4. truncate 删除没有返回值，delete删除后返回值
5. truncate 删除不能回滚，delete删除可以回滚
*/
INSERT INTO boys (boyname, userCP)
VALUES('张飞', 100),('刘备', 100),('关云长', 100);
SELECT * FROM boys;
DELETE FROM boys;
INSERT INTO boys (boyname, userCP)
VALUES('张飞', 100),('刘备', 100),('关云长', 100);
SELECT * FROM boys;





