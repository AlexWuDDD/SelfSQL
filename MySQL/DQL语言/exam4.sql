#1、查询和Zlotkey相同部门的员工姓名和工资
SELECT last_name, salary
FROM employees
WHERE department_id = (SELECT department_id FROM employees WHERE last_name = 'Zlotkey');

#2、查询工资比公司平均工资高的员工号，姓名和工资
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

#3、查询各部门中工资比本部门平均工资高的员工的员工号，姓名和工资
SELECT employee_id, last_name, salary, ag_d.平均工资
FROM employees
INNER JOIN (
		SELECT AVG(salary) 平均工资, department_id 部门 
        FROM employees 
        GROUP BY department_id
        ) ag_d
ON department_id = ag_d.部门 AND salary > ag_d.平均工资;

#4、查询和姓名中包含字母u的员工在相同部门的员工号的姓名
SELECT employee_id, last_name
FROM employees
WHERE department_id IN (SELECT department_id FROM employees WHERE last_name LIKE '%u%');

#5、查询在部门的location_id为1700的部门工作的员工的员工号
SELECT employee_id
FROM employees
WHERE department_id IN(SELECT department_id FROM departments WHERE location_id = 1700);
#6、查询管理者是King的员工姓名和工资
SELECT last_name, salary
FROM employees
WHERE manager_id IN (SELECT employee_id FROM employees WHERE last_name = 'K_ing');
#7、查询工资最高的员工的姓名、要求first_name和last_name显示为一列，列名为姓.名
SELECT CONCAT(first_name,'.',last_name) AS '姓.名'
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);


