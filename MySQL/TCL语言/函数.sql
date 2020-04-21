#函数
#存储过程：可以有0个返回， 也可以有多个返回， 适合批量插入，批量更新
#函数有且仅有一个返回，适合做处理数据后返回一个结果


#一、创建语法
CREATE FUNCTION 函数名(参数列表) RETURNS 返回类型
BEGIN
	函数体
END
/*
注意：
参数列表 包含两部分
参数名 参数类型

函数体：肯定会有return语句，如果没有会报错
如果return语句没有放在函数体的最后也不保存，但不建议

函数体仅有一句话，则可以省略begin end

使用 delimiter语句设置结束标记
*/

#二、调用语法
SELECT 函数名(参数列表)


#---------------------------案例演示--------------------------------
#1.无参有返回
#案例： 返回公司的员工个数
DELIMITER $
DROP FUNCTION IF EXISTS fun1 $
CREATE FUNCTION fun1() RETURNS INT
BEGIN
	DECLARE ret INT DEFAULT 0;
	SELECT COUNT(*) INTO ret FROM employees;
    RETURN ret;
END $

SELECT fun1() INTO @employeeNum $

SELECT @employeeNum $

#2.有参有返回
#案例1：根据员工名，返回它的工资
DESC employees $
DROP FUNCTION IF EXISTS fun2 $
CREATE FUNCTION fun2(employeeName VARCHAR(20) CHARSET utf8mb4) RETURNS DOUBLE(10,2)
BEGIN
	DECLARE ret DOUBLE(10,2) DEFAULT 0;
    SELECT salary INTO ret
    FROM employees
    WHERE last_name = employeeName;
    RETURN ret;
END $

SELECT fun2('Kochhar') $

#三、查看函数
SHOW CREATE FUNCTION fun2;

#四、删除函数
DROP FUNCTION 函数名;

#案例
#一、创建函数，实现传入两个float，返回二者之和
DROP FUNCTION IF EXISTS testFunc $
CREATE FUNCTION testFunc(f1 FLOAT, f2 FLOAT) RETURNS FLOAT
BEGIN
	RETURN f1 + f2;
END $

SELECT testFunc(1.5, 2.6) $





















