# SQL99语法
/*
语法：
	select 查询列表
    from 表1 别名 [连接类型]
    join 表2 别名 
    on 连接条件
    [where 筛选条件]
    [group by]
    [having]
    [order by]

分类（连接类型）：
内连接(*)： inner
外连接
	左外（*): left[outer]
    右外（*): right[outer]
    全外: full[outer]
交叉连接: cross
*/


#一、内连接
/*
语法：
select 查询列表
from 表1 别名
inner join 表2 别名
on 连接条件;

分类：
等值
非等值
自连接
*/

#1、等值连接
#案例1、查询员工名、部门名
SELECT e.last_name, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

#案例2、查询名字中包含e的员工名和工种名
SELECT e.last_name, j.job_title
FROM employees e
INNER JOIN jobs j
ON e.job_id = j.job_id
WHERE e.last_name LIKE "%e%";

#案例3、查询部门个数>3的城市名和部门个数
SELECT l.city, COUNT(*)
FROM locations l
INNER JOIN departments d
ON l.location_id = d.location_id
GROUP BY l.city
HAVING COUNT(*)>3;

#案例4、查询哪个部门的部门员工个数>3的部门名和员工个数，并按个数降序
SELECT d.department_name, COUNT(*)
FROM departments d
INNER JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_id
HAVING COUNT(*)>3
ORDER BY COUNT(*) DESC;

#案例5、查询员工名、部门名、工种名、并按部门名降序
SELECT e.last_name, d.department_name, j.job_title
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN jobs j ON e.job_id = j.job_id
ORDER BY d.department_name DESC;

#2、非等值连接
#案例1、查询工资级别
SELECT last_name, grade_level
FROM employees e
INNER JOIN job_grades j ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;

#案例2.查询每个工资级别的员工个数
SELECT COUNT(*), grade_level
FROM employees e
INNER JOIN job_grades g on e.salary BETWEEN g.lowest_sal AND g.highest_sal
GROUP BY grade_level
HAVING COUNT(*)>2
ORDER BY grade_level DESC;

#3、自连接
#案例、查询员工的名字和上级的名字
SELECT e.last_name, m.last_name
FROM employees e
INNER JOIN employees m on e.manager_id = m.employee_id
WHERE e.last_name LIKE "%k%";


#二、外连接
/*
应用场景：用于查询一个表中有，另一个表没有的记录
特点：
1.外连接的查询结果为主表中的所有记录
	如果从表中有和它匹配，则显示匹配的值
	如果从表中没有和它匹配的，则显示null
    外连接查询结果=内连接结果+主表中有而从表中没有的记录
2. 左外连接， left join左边的是主表
   右外连接， right join右边的是主表
3. 左外和右外交换两个表的顺序，可以实现同样的效果
*/
#引入、查询男朋友不在男神表的女神名
SELECT b.name
FROM beauty b
LEFT OUTER JOIN boys bo ON b.boyfriend_id = bo.id
WHERE bo.id IS NULL;





















