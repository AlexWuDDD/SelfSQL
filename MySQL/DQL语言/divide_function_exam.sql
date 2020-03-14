#1 查询公司员工的工资的最大值。最小值，平均值，总和
SELECT MAX(salary), MIN(salary), AVG(salary), SUM(salary) FROM employees;

#2 查询员工表中的最大入职时间和最小入职时间的相差天数(DIFFERENCE)
SELECT DATEDIFF(MAX(hiredate), MIN(hiredate)) AS 'DIFFERENCE' FROM employees;
SELECT DATEDIFF('2020-3-5','2020-3-4');
#3 查询部门编号为90的员工个数
SELECT COUNT(*) FROM employees WHERE department_id=90;