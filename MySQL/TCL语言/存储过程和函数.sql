# 存储过程和函数
/*
类似方法或函数
*/

#存储过程
/*
含义：一组预先编译好的SQL语句的集合，理解成批处理语句
1.提高代码的重用性
2.简化操作
3.减少了编译次数并且减少了和数据库服务器的连接次数，提高了效率
*/

#一、创建语法
/*
CREATE PROCEDURE 存储过程名(参数列表)
BEGIN
	存储过程体(一组合法的SQL语句)
END

注意：
1、参数列表包含三部分
参数模式 参数名 参数类型
举例：
IN stuname VARCHAR(20)

参数模式：
IN		：该参数可以作为输入，也就是该参数需要调用发传入值
OUT		：该参数可以作为输出，也就是该参数可以作为返回值
INOUT	：通吃，

2、如果存储过程仅仅只有一句话，BEGIN END 可以省略
存储过程体中的每条SQL语句的结尾要求必须加分号。
存储过程的结尾可以使用DELIMITER重新设置
语法：
DELIMITER 结束标记
*/
#二、调用语法
/*
CALL 存储过程名(实参列表)
*/

#1.空参列表
#案例： 插入到admin表中五条记录
SELECT * FROM admin;
DESC admin;
DELIMITER $
CREATE PROCEDURE myp1()
BEGIN
	INSERT INTO admin(username, password) 
    VALUES('john1','1111'),('john2','2222'),('john3','3333'),('john4','4444'),('john5','5555');
END $

CALL myp1() $

SELECT * FROM admin;

#2.创建带in模式参数的存储过程

#案例1： 创建存储过程实现 根据女神名，查询对应的男神信息

DELIMITER $
DROP PROCEDURE IF EXISTS myp2 $

CREATE PROCEDURE myp2(IN beautyName VARCHAR(20) CHARSET utf8mb4)
BEGIN
	SELECT bo.* 
    FROM boys bo
    RIGHT JOIN beauty b on bo.id = b.boyfriend_id
    WHERE b.name = beautyName;
END $

CALL myp2('赵敏') $

#案例2： 创建存储过程实现，用户是否登录成功

DROP PROCEDURE IF EXISTS Myp3 $
CREATE PROCEDURE Myp3(IN username VARCHAR(20) CHARSET utf8mb4, IN password VARCHAR(20) CHARSET utf8mb4)
BEGIN
	DECLARE result INT DEFAULT 0; #声明并初始化
	SELECT COUNT(*) INTO result #赋值
	FROM admin
	WHERE admin.username = username 
    AND admin.password = password;
	SELECT IF(result>0, '成功','失败'); #使用
END $

DESC admin $

CALL Myp3('john', '888888') $

#3、创建带out模式的存储过程

#案例： 根据女神名，返回对应的男神名

DROP PROCEDURE IF EXISTS myp4 $

CREATE PROCEDURE myp4(IN beautyName VARCHAR(20) CHARSET utf8mb4, OUT boyName VARCHAR(20) CHARSET utf8mb4)
BEGIN
	SELECT bo.boyName INTO boyName
    FROM boys bo
    RIGHT JOIN beauty b ON b.boyfriend_id = bo.id
    WHERE b.name = beautyName;
END$

SET @boyName = ''$
CALL myp4('赵敏', @boyName) $

SELECT @boyName $

#案例2：根据女神名，返回对应的男神名和男神魅力值
CREATE PROCEDURE myp5(IN beautyName VARCHAR(20) CHARSET utf8mb4, 
	OUT boyName VARCHAR(20) CHARSET utf8mb4,
    OUT userCP INT)
BEGIN

	SELECT bo.boyName, bo.userCP INTO boyName, userCP 
    FROM boys bo
    RIGHT JOIN beauty b ON b.boyfriend_id = bo.id
    WHERE b.name = beautyName;

END $

CALL myp5('小昭', @bn, @cp) $

SELECT @bn, @cp $

#4. 创建带inout模式参数的存储过程
#案例1： 传入a和b两个值， 最终a和b都翻倍并返回
CREATE PROCEDURE myp6(INOUT a INT, INOUT b INT)
BEGIN
	SET a=a*2;
    SET b=b*2;
END $

SET @m=2 $
SET @n=3 $

CALL myp6(@m,@n) $

SELECT @m, @n $


#二、删除存储过程
# 语法： DROP PROCEDURE 存储过程名

#三、查看存储过程的信息
SHOW CREATE PROCEDURE myp2;









