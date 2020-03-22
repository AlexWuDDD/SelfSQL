#进阶6 连接查询
/*
含义: 又称为多表查询，当查询的字段来自多个表时，就会用到连接查询

分类：
1. 按年代分类
sql92标准(仅支持内联)
sql99标准(推荐)

2. 按功能分类
内连接：
	等值连接
    非等值连接
    自连接
外连接：
	左外连接
    右外连接
    全外连接
交叉连接：
*/
SELECT * FROM beauty;
SELECT * FROM boys;

#一 sql92标准
#1. 等值连接
/*
1.多表等值连接的结果为多表的交集部分
2.n表连接，至少需要n-1个连接条件
3.多表的顺序没有要求
4.一般需要为表起别名
5.可以搭配前面介绍的所有字句使用
*/
#案例1,查询女神名和对应的男神民
SELECT name, boyname FROM beauty, boys
WHERE beauty.boyfriend_id = boys.id;

#案例2, 查询员工名和对应的部门名
SELECT last_name, department_name 
FROM employees, departments
WHERE employees.department_id = departments.department_id;

#2. 为表起别名
/*
提高语句的简洁度
区分多个重名的字段
一旦为表起别名，原表名不再可用
*/
#查询员工号，工种号，工种名
SELECT last_name, e.job_id, j.job_title
FROM employees AS e, jobs AS j
WHERE e.job_id = j.job_id;

#3.两个表的顺序是否可以调换
#查询员工号，工种号，工种名
SELECT e.last_name, e.job_id, job_title
FROM jobs, employees AS e
WHERE e.job_id = jobs.job_id;

#4. 可以加筛选
# 案例1：查询有奖金的员工名，部门名
SELECT last_name, department_name, commission_pct
FROM employees AS e, departments AS d
WHERE e.department_id = d.department_id AND e.commission_pct IS NOT NULL;

# 案例2：查询城市名中第二个字符为o的对应的部门名和城市名
SELECT department_name, city
FROM departments AS d, locations AS l
WHERE d.location_id = l.location_id AND l.city LIKE '_o%';

#5 可以加分组
#案例1 查询每个城市的部门个数
SELECT COUNT(*), city
FROM departments d, locations l
WHERE d.location_id = l.location_id
GROUP BY city;

#案例2 查询有奖金的每个部门的部门名和部门的领导编号和该部门的最低工资
SELECT department_name, d.manager_id, MIN(salary)
FROM departments d, employees e
WHERE d.department_id = e.department_id AND commission_pct IS NOT NULL
GROUP BY department_name, d.manager_id;

#6. 可以加排序
#案例：查询每个工种的工种名和员工的个数，并且按员工个数降序
SELECT job_title, COUNT(*) 个数, e.job_id
FROM jobs j, employees e
WHERE j.job_id = e.job_id
GROUP BY e.job_id
ORDER BY 个数 DESC;

#7. 可以实现三表连接
#案例：查询员工名，部门名和所在的城市
SELECT last_name, department_name, city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id AND d.location_id = l.location_id;

#2、非等值连接
-- CREATE TABLE job_grades
-- (grade_level VARCHAR(3),
-- lowest_sal INT,
-- highest_sal INT);
-- 
-- INSERT INTO job_grades
-- VALUES('A', 1000, 2999);
-- 
-- INSERT INTO job_grades
-- VALUES('B', 3000, 5999);
-- 
-- INSERT INTO job_grades
-- VALUES('C', 6000, 9999);
-- 
-- INSERT INTO job_grades
-- VALUES('D', 10000, 14999);
-- 
-- INSERT INTO job_grades
-- VALUES('E', 15000, 24999);
-- 
-- INSERT INTO job_grades
-- VALUES('E', 25000, 40000);

#案例1： 查询出员工的工资和工资级别
SELECT * FROM job_grades;

SELECT salary, grade_level
FROM employees, job_grades
WHERE salary >= lowest_sal AND salary <= highest_sal;


#3、自连接

#案例：查询员工名以及上级的名字
SELECT e.employee_id, e.last_name, m.employee_id, m.last_name
FROM employees e, employees m
WHERE e.manager_id = m.employee_id;








