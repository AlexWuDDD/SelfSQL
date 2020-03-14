#测试
#1. 显示系统时间（注：日期+时间)
SELECT NOW();

#2 查询员工号，姓名， 工资以及工资提高百分之20%后的结果
SELECT
	employee_id,
    last_name,
    salary,
    salary*1.2 AS 'new salary'
FROM
	employees;
    
#3.将员工的姓名按首字母排序，并写出姓名的长度
SELECT
	last_name AS '姓名',
    LENGTH(last_name) AS '长度'
FROM
	employees
ORDER BY
	SUBSTR(last_name, 1, 1) ASC;
    
#4 做一个查询 产生下面的结果
#<last_name>earns<salary>monthly but wants<salary*3>
SELECT
	CONCAT(last_name, ' earns ', salary , ' monthly but wants ', salary*3)
FROM
	employees;

#5 使用case when 按照下面的条件
/*
job		grade
AD_PERS A
ST_MAM	B
IT_PROG C
*/
SELECT
	job_id AS 'job',
    CASE job_id
    WHEN 'AD_PRES' THEN 'A'
    WHEN 'ST_MAN' THEN 'B'
    WHEN 'IT_PROG' THEN 'C'
    ELSE 'D'
    END AS 'grade'
FROM
	employees;
    





   