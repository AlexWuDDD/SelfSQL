#1.查询工资最低的员工信息：last_name, salary
SELECT last_name, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

#2.查询平均工资最低的部门信息
SELECT * FROM departments
WHERE department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary) ASC
	LIMIT 0, 1
);
#3.查询平均工资最低的部门信息和该部门的平均工资
SELECT d.* , ag_d.ag
FROM departments d
INNER JOIN (
	SELECT AVG(salary) ag, department_id id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary) ASC
	LIMIT 0, 1
)ag_d
ON d.department_id = ag_d.id;
#4.查询平均工资最高的job信息
SELECT * FROM jobs
WHERE job_id = (
SELECT job_id
FROM employees
GROUP BY job_id
ORDER BY AVG(salary) DESC
LIMIT 0,1);
#5.查询平均工资高于公司平均工资的部门有哪些
/*公司的平均工资*/
SELECT AVG(salary) 
FROM employees;

/*各部门的平均工资*/
SELECT AVG(salary), department_id 
FROM employees 
GROUP BY department_id
HAVING AVG(salary) > (
	SELECT AVG(salary) 
	FROM employees
);
#6.查询出公司中所有manger的详细信息
SELECT * FROM employees
WHERE employee_id IN (SELECT manager_id FROM employees);

#7.各个部门中　最高工资中最低的那个部门的最低工资是多少
SELECT MIN(salary)
FROM employees
WHERE department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY MAX(salary) ASC
	LIMIT 0, 1
);

#8.查询平均工资最高的部门的manger的详细信息：last_name, department_id, email, salary

SELECT last_name, department_id, email, salary
FROM employees
WHERE employee_id = (
	SELECT manager_id
	FROM departments
	WHERE department_id = (
		SELECT department_id
		FROM employees
		GROUP BY department_id
		ORDER BY AVG(salary) DESC
		LIMIT 0, 1
	)
);







