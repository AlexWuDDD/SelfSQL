#变量
/*
分类：
系统变量：
	全局变量
    会话变量

自定义变量：
	用户变量
    局部变量

*/

#一、系统变量
/*
说明： 变量由系统提供，不是用户定义，属于服务器层面
使用语法:
1、查看所有的系统变量
SHOW GLOBAL VARIABLES;
SHOW [SESSION] VARIABLES;

2、查看满足条件的部分系统变量
SHOW GLOBAL|[SESSION] VARIABLES LIKE '%char%';

3、查看指定的某个系统变量的值
SELECT @@global.|[session.]系统变量名;

4、为某个系统变量赋值
set global|[session] 系统变量名 = 值;
set @@global.|[session.]系统变量名 = 值;

注意：
如果是全局变量，则需要加global,如果是会话级别，则需要加session,如果不写，则默认session
*/

#1、全局变量
#查看所有的全局变量
SHOW GLOBAL VARIABLES;

#查看部分的全局变量
SHOW GLOBAL VARIABLES LIKE '%char%';

#查看指定的全局变量的值
SELECT @@global.autocommit;
SELECT @@tx_isolation;

#为某个指定的全局变量赋值
SET @@GLOBAL.AUTOCOMMIT=0;

#2、会话变量
/*
作用域：仅仅针对于当前会话(连接)有效
*/

#二、自定义变量
/*
说明：变量是用户自定义的，不是由系统的
使用步骤：
声明
赋值
使用（查看、比较、运算等）
*/
#1、用户变量
/*
作用域：当前会话
*/

#声明并初始化
#SET @用户变量名=值
#SET @用户变量名:=值;
#SELECT @用户变量名:=值;

#赋值（更新用户变量的值）
#方式一： 通过SET或SELECT
#SET @用户变量名=值
#SET @用户变量名:=值;
#SELECT @用户变量名:=值;

#方式二： 通过SELECT INTO
#SELECT 字段 INTO 变量名 FROM 表;


#使用（查看用户变量的值）
#SELECT @变量名;


#2、局部变量
/*
作用域：仅仅在定义它的begin end中有效

*/

#声明
#DECLARE 变量名 变量类型 ;
#DECLARE 变量名 变量类型 DEFAULT 值;
 
#赋值
#方式一： 通过SET或SELECT
#SET 局部变量名=值
#SET 局部变量名:=值;
#SELECT @局部变量名:=值;

#方式二： 通过SELECT INTO
#SELECT 字段 INTO 变量名 FROM 表;

#使用
#SELECT 局部变量名;

#案例：声明两个变量并赋初始值，求和，并打印

#1.用户变量
SET @m=1;
SET @n=2;
SET @sum = @m + @n;
SELECT @sum;

#2.局部变量

BEGIN
	DECLARE m INT DEFAULT 1;
	DECLARE n INT DEFAULT 2;
	DECLARE sum INT;
	SET sum = m+n;
	SELECT sum;
END














