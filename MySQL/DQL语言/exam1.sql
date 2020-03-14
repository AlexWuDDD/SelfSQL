#测试题
#1.查询没有奖金，且工资小于18000的salary, last_name
SELECT
	salary, last_name
FROM
	employees
WHERE
	commission_pct IS NULL AND salary < 18000;
    
#2. 查询employees中，job_id不为’IT'或这工资为12000的员工信息
SELECT
	*
FROM
	employees
WHERE
	job_id <> 'IT' OR salary = 12000;
    

DESC departments;
SHOW TABLES;

SELECT
	DISTINCT location_id
FROM
	departments;
    
/*
经典面试题：
试问：
SELECT * FROM employees;
和
SELECT * FROM employees commission_pct like '%%' AND last_name LIKE '%%';

不一样
如果判断的字段有NULL值就不一样了
如果是OR就一样了，因为总归有一个字段不是NULL

*/

    
    
    