#1 下面语句是否可以执行成功
SELECT 
	last_name, job_id, salary AS sal
FROM
	employees;
    
#2 下面语句是否可以执行成功
SELECT * FROM employees;

#3 找出下面语句中的错误
SELECT 
	employee_id, last_name, salary*12 "ANNUAL SALARY"
FROM
	employees;

#4 显示表departments的结构，并查询其中的全部数据
DESC departments;
SELECT * FROM departments;
#5 显示出表employees中的全部job_id（不能重复）
SELECT DISTINCT job_id FROM employees;
#6 显示出表employees中全部列，各个列之间用逗号连接，列头显示成OUT_PUT
# ifnull(arg1, result) 如果 arg1为NULL， 则返回result
SELECT 
	ifnull(commission_pct, 0) AS 奖金率,
    commission_pct
FROM
	employees;
#---------------------------------------------
SELECT
	concat(first_name, ",", last_name, "," ,job_id, "," , ifnull(commission_pct, 0)) as OUT_PUT
FROM
	employees;
   