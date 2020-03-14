#进阶4：常见函数
/*
功能：
分类：
	1.单行函数： concat, length, ifnull
    2.分组函数: 
		功能：做统计使用，又称为统计函数，聚合函数，组函数

常见函数：
字符函数：
length, concat, substr, instr, trim, upper, lower,lpad. rpad. replace        
数学函数：
round,ceil,floor,truncate, mod,
日期函数：
now, curdate, curtime, year, month,monthname, day, hour, minute, second, str_to_date, date_format
其他函数:
version, database, user
流程函数：
if, case
*/

#1.字符函数

#length 获取参数值的字节个数
SELECT LENGTH('alex');
SELECT LENGTH('吴康俊');

SHOW VARIABLES LIKE '%char%';

#concat 拼接字符串
SELECT CONCAT(last_name, '_', first_name) FROM employees;

#upper, lower
SELECT UPPER('alex');
SELECT LOWER('ALEX');
#案例：将姓变大写，名变小写，然后拼接
SELECT CONCAT(UPPER(last_name), LOWER(first_name)) FROM employees;

#substr/substring 截取字符
SELECT SUBSTR('alex is cool', 3);
SELECT SUBSTR('alex is cool', 1, 4); #截取从指定索引处的字符长度
#案例：姓名中首字符大写，其他字符小写，然后用_拼接，显示出来
SELECT CONCAT(UPPER(SUBSTR(last_name, 1, 1)), '_', LOWER(SUBSTR(last_name, 2))) FROM employees;

#instr 返回字串的起始索引
SELECT INSTR('alex', 'al');
SELECT INSTR('alex', 'ax');

#trim 掐头去尾 默认是空格
SELECT LENGTH('  bb         abcdefg       aaa  ');
SELECT LENGTH(TRIM('  bb         abcdefg       aaa  '));
SELECT TRIM('a'FROM'aaaaaaaaaabbbbaaabbbbbbbbbaaaaaaaaaaa');

#lpad
SELECT LPAD('ABCDEFG', 10, '*'); #总的字符长度是10个，不够在左边填充*

#rpad
SELECT RPAD('aaakbkaj', 20, '#');

#replace
SELECT REPLACE('ABCDEFG', 'EFG', 'FFFF');


#2.数学函数

#round 四舍五入
SELECT ROUND(1.65);
SELECT ROUND(1.25);
SELECT ROUND(1.567, 2);

#ceil向上取整，返回>=该参数的最小整数
SELECT CEIL(1.2);

#floor 向下取整
SELECT FLOOR(-9.5);

#truncate 截断 小数点后保留几位
SELECT TRUNCATE(1.22222, 2);
SELECT TRUNCATE(1.2, 2);

#mod取余
SELECT MOD(-10, -3);
SELECT 10%3;

#3 日期函数

#now 返回当前系统日期和时间
SELECT NOW();

#curdate 返回当前系统日期，不包含时间
SELECT CURDATE();

#curtime返回当前时间，不包含日期
SELECT CURTIME();

#可以获取指定的部分，年，月，日，小时，分钟，秒
SELECT YEAR(NOW());
SELECT YEAR('1991-5-13');

SELECT YEAR(hiredate) FROM employees;

SELECT MONTH(NOW());
SELECT MONTHNAME(NOW());

#str_to_date将日期格式的字符转换成指定格式的日期
SELECT STR_TO_DATE('5-13-1991', '%c-%d-%Y');
#date_format将日期转换成字符
SELECT DATE_FORMAT(CURDATE(), '%m-%d-%y');

#4 其他函数
SELECT VERSION();
SELECT DATABASE();
SELECT USER();

#5 流程控制函数
#1 if函数： if else的效果
SELECT IF(1>2, 1, 2);

SELECT last_name, commission_pct, IF(commission_pct IS NULL, '没奖金 呵呵','有奖金 嘻嘻') FROM employees;

#2 case函数的使用1：swict case效果
/*
case 要判断的字段和表达式 
when 常量1 then 要显示的值1或语句1;
when 常量2 then 要显示的值2或语句2;
...
else 要显示的值n或语句n;
end
*/
#案例：查询员工的工资，要求
/*
部门号=30 显示的工资为1.1倍
部门号=40 显示的工资为1.2倍
部门号=50 显示的工资为1.3倍
其他部门 显示的原工资
*/
SELECT salary AS 老工资, department_id,
CASE department_id
WHEN 30 THEN salary*1.1
WHEN 40 THEN salary*1.2
WHEN 50 THEN salary*1.3
ELSE salary
END AS 新工资
FROM employees;

#3 case函数的使用2： 多重if
/*
case
when 条件1 then 要显示的值1或语句1
when 条件2 then 要显示的值2或语句2
。。。。
else 要显示的值n或语句n
end
*/
#查询员工的工资情况
/*
如果工资>20000, 显示A级别
如果工资>15000, 显示B级别
其他 显示C级别
*/
SELECT salary AS 工资,
CASE
WHEN salary>20000 THEN 'A'
WHEN salary>15000 THEN 'B'
ELSE 'C'
END AS '工资级别'
FROM employees;




