#进阶7：子查询
/*
含义：
出现在其他语句中的select语句，称为子查询或内查询
外部的查询语句，称为主查询或外查询

分类：
按子查询出现的位置：
	select 后面：
		仅仅支持标量子查询
    from 后面
		表子查询
    where或having后面 （*)
		标量子查询（单行*）或列子查询(多行*)或行子查询
    exists 后面（相关子查询）
		表子查询
按结果集的行列数不同：
	标量子查询（结果集只有一列一行）
    列子查询（结果集只有一列多行）
    行子查询（结果集有多行多列）
    表子查询（结果集一般为多行多列）
*/

#一、where或having后面
#1.标量子查询（单行子查询）
#2.列子查询（多行子查询）
#3.行子查询（多列多行）

#特点：
#子查询放在小括号内
#子查询一般放在条件的右侧
#标量子查询，一般搭配着单行操作符使用（> < >= <= = <>)
#列子查询，一般搭配多行操作符使用 IN ANY/SOME ALL
#子查询的执行优于主查询

#1. 标量子查询
#案例1,谁的工资比Abel高？
#查询Abel的工资
SELECT salary
FROM employees
WHERE last_name = 'Abel';
#查询员工的信息
SELECT *
FROM employees
WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Abel');

#案例2：返回job_id与141好员工相同，salary比143号员工多的员工姓名, job_id和工资
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (SELECT job_id FROM employees WHERE employee_id = 141)
AND salary > (SELECT salary FROM employees WHERE employee_id = 143); 

#案例3：返回工资最少的员工的last_name, job_id和salary
SELECT last_name, job_id , salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

#案例4：查询最低工资大于50号部门的最低工资的部门id和其最低工资
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (SELECT MIN(salary) FROM employees WHERE department_id = 50);


#非法使用标量子查询

#2.多行子查询
# IN/NOT INT 等于列表中的任意一个
# ANY/SOME 和子查询返回的某一个值比较（MAX）
# ALL 和子查询返回的所有值比较（MIN）

#案例1 返回location_id是1400或1700的部门中的所有员工信息
SELECT e.*
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
WHERE d.location_id IN(1400, 1700);

SELECT *
FROM employees
WHERE department_id IN (SELECT department_id FROM departments WHERE location_id IN (1400,1700));

#案例2、返回其他工种中比job_id为IT_PROG工种任意工资低的员工:姓名、job_id、以及salary
SELECT last_name, job_id, salary
FROM employees
WHERE job_id != 'IT_PROG'
AND salary < ANY(SELECT salary FROM employees WHERE job_id = 'IT_PROG');

##案例3、返回其他工种中比job_id为IT_PROG工种所有工资低的员工:姓名、job_id、以及salary
SELECT last_name, job_id, salary
FROM employees
WHERE job_id != 'IT_PROG'
AND salary < ALL(SELECT salary FROM employees WHERE job_id = 'IT_PROG');

#3、行子查询（结果集一行多列或多行多列）
#案例：查询员工编号最小并且工资最高的员工信息

SELECT *
FROM employees
WHERE (employee_id, salary) = (
	SELECT MIN(employee_id), MAX(salary) FROM employees
);


SELECT MIN(employee_id)
FROM employees;

SELECT MAX(salary)
FROM employees;

SELECT *
FROM employees
WHERE employee_id = (
	SELECT MIN(employee_id)
	FROM employees
)
AND salary = (
	SELECT MAX(salary)
	FROM employees
);

#二、select 后面

#案例：查询每个部门的员工个数
SELECT d.*, (SELECT COUNT(*) FROM employees e WHERE e.department_id = d.department_id) 员工人数
FROM departments d;

#案例：查询员工号=102的部门名
SELECT d.department_name 
FROM departments d 
INNER JOIN employees e ON d.department_id = e.department_id
WHERE e.employee_id=102;

#三、 from 后面
/*
子查询结果充当一张表， 必须起别名
*/
#案例： 查询每个部门的平均工资的工资等级
SELECT AVG(salary), department_id
FROM employees
GROUP BY department_id;

SELECT AG_DEP.*, g.grade_level
FROM (
	SELECT AVG(salary) ag, department_id
	FROM employees
	GROUP BY department_id
) AG_DEP
INNER JOIN job_grades g
ON AG_DEP.ag BETWEEN g.lowest_sal AND g.highest_sal;

#四、放在exists后面（相关子查询）
/*
语法：
exists(完整的查询语句)
结果：
1或0

*/
SELECT EXISTS(SELECT employee_id FROM employees WHERE salary = 30000);

#案例 查询有员工的部门名
SELECT department_name
FROM departments d
WHERE EXISTS(SELECT * FROM employees e WHERE e.department_id = d.department_id);

#案例 查询没有女朋友的男神信息

SELECT bo.*
FROM boys bo
WHERE bo.id NOT IN (SELECT boyfriend_id FROM beauty);

SELECT bo.*
FROM boys bo
WHERE NOT EXISTS(SELECT boyfriend_id FROM beauty);



