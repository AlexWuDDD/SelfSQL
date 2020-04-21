#流程控制结构
/*
顺序结构
分支结构
循环结构
*/

#一、分支结构
#1.if 函数
/*
功能：实现简单的双分支
语法：
SELECT IF(表达式1,表达式2,表达式3)
执行顺序：
如果表达式1成立，则IF函数返回表达式2的值，否则返回表达式3的值
*/

#2.case机构
/*
情况1:类似java的switch语句，一般用于实现的等值判断
语法：
	CASE 变量|表达式|字段
    WHEN 要判断的值 THEN 返回的值1或语句
    WHEN 要判断的值 THEN 返回的值2或语句
    WHEN 要判断的值 THEN 返回的值3或语句
    ...
    ELSE 要返回的值n或语句
    END CASE;
情况2:类似于java的多重if语句，一般用于实现区间判断
语法：
	CASE 
    WHEN 要判断的区间 THEN 返回的值1或语句
    WHEN 要判断的区间 THEN 返回的值2或语句
    WHEN 要判断的区间 THEN 返回的值3或语句
    ...
    ELSE 要返回的值n或语句
    END CASE;
    
特点：
可以作为表达式，嵌套在其他语句中使用，可以放在任何地方，BEGIN END中或BEGIN END的外面
可以作为独立的语句去使用，只能放在BEGIN END 中

如果WHEN中的值满足或条件成立，则执行对应的THEN后面的语句，并且结束CASE
如果都不满足，则执行ELSE中的语句或值

ELSE可以省略，如果ELSE省略了，并且所有WHEN条件都不满足，则返回NULL
    
*/

#案例

#创建存储过程，根据传入传入的成绩，来显示等级，比如传入的成绩：90-100显示A，80-90显示B， 60-80显示C，否则显示D

DELIMITER $
DROP PROCEDURE IF EXISTS test_case $
CREATE PROCEDURE test_case(IN score INT)
BEGIN
	CASE
    WHEN score >= 90 THEN SELECT 'A';
    WHEN socre >= 80 THEN SELECT 'B';
    WHEN score >= 60 THEN SELECT 'C';
    ELSE SELECT 'D';
    END CASE;
END $

CALL test_case(95) $


#3.if结构
/*
功能：实现多重分支
语法：
if 条件1 then 语句1;
elseif 条件2 then 语句2;
...
else 语句n;
end if;

只能应用在BEGIN END 中
*/

#案例

#创建存储过程，根据传入传入的成绩，来显示等级，比如传入的成绩：90-100返回A，80-90返回B， 60-80返回C，否则返回D
DROP FUNCTION IF EXISTS test_if $
CREATE FUNCTION test_if(score INT) returns CHAR
BEGIN
	IF score >= 90 THEN RETURN 'A';
    ELSEIF score >= 80 THEN RETURN 'B';
    ELSEIF score >= 60 THEN RETURN 'C';
    ELSE RETURN 'D';
    END IF;
END $

SELECT test_if(87) $

#二、循环结构
/*
分类：
while、loop、repeat

循环控制：
iterate类似于continue
leave 类似与break
*/

#1. while
/*
语法：
[标签:] while 循环条件 do
	循环体;
end while [标签];
*/

#2. loop
/*
语法：
[标签:] loop
	循环体;
end loop [标签];

可以用来模拟简单的死循环
*/

#3. repeat
/*
语法：
[标签:] repeat
	循环体;
until 结束循环的条件
end repeat [标签];
*/

#案例： 批量插入，根据次数插入到admin表中多条记录
DROP PROCEDURE IF EXISTS test_while1 $
CREATE PROCEDURE test_while1(IN insertTimes INT)
BEGIN
	DECLARE cnt INT DEFAULT 0;
    WHILE cnt < insertTimes DO
		INSERT INTO admin(username, password) VALUES(concat('ALEX WU', cnt),'666');
        SET cnt = cnt + 1;
    END WHILE;    
END $

CALL test_while1(5) $

SELECT * FROM admin;


