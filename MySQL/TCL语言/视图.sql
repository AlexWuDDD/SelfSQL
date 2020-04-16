#视图
/*
含义：虚拟表，和普通表一样使用，通过表动态生成的数据
只保存sql逻辑
*/
#一、创建视图
/*
语法：
create view 视图名
as
查询语句
*/
USE myemployees;
#1、查询邮箱中包含a字符的员工名、部门名和工种信息
#创建
DROP VIEW IF EXISTS myv1;
CREATE VIEW myv1
AS
SELECT e.last_name, d.department_name, j.job_title
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN jobs j ON e.job_id = j.job_id
WHERE email LIKE '%a%';
#使用
SELECT * FROM myv1;

#2、查询各部门的平均工资级别
DROP VIEW IF EXISTS myv2;
#创建视图查看各部门的平均工资
CREATE VIEW myv2
AS
SELECT AVG(salary) ag, department_id
FROM employees
GROUP BY department_id;

SELECT myv2.ag, job_grades.grade_level 
FROM myv2
INNER JOIN job_grades ON myv2.ag BETWEEN job_grades.lowest_sal AND job_grades.highest_sal;


#3、查询平均工资最低的部门信息
DROP VIEW IF EXISTS myv3;
CREATE VIEW myv3
AS
SELECT AVG(salary) ag, department_id d_id
FROM employees
GROUP BY department_id
ORDER BY AVG(salary) ASC
LIMIT 0,1;

SELECT d.* 
FROM departments d
INNER JOIN myv3 ON d.department_id = myv3.d_id;

/*
重用sql语句
简化复杂的sql操作，不必知道它的查询细节
保护数据、提高安全性
*/

#二、视图的修改
#方式一：
/*
create or replace view 视图名
as
查询语句
*/
#方式二
/*
alter view 视图名
as
查询语句
*/

#三、删除视图
/*
语法：drop view 视图名,视图名, ......
*/

#四、查看视图
DESC myv3;
SHOW CREATE VIEW myv3;

#五、视图的更新
CREATE OR REPLACE VIEW myv1
AS
SELECT last_name, email, salary*12*(1+IFNULL(commission_pct, 0)) annual
FROM employees;

CREATE OR REPLACE VIEW myv1
AS
SELECT last_name, email
FROM employees;

SELECT * FROM myv1;
#1.插入
INSERT INTO myv1 VALUES('张飞', 'zf@qq.com');
SELECT * FROM employees;

#2.修改
UPDATE myv1 SET last_name='张无忌' WHERE last_name='张飞';
SELECT * FROM employees;

#3.删除
DELETE FROM myv1 WHERE last_name='张无忌';
SELECT * FROM employees;

#具备一下特点的试图不允许更新
#分组函数 max min avg
#常量视图
#select包含子查询
#join
#from一个不能更新的视图
#where字句的子查询引用了from子句中的表

/*
视图	CREATE VIEW		不占用物理空间只保存SQL逻辑	增删改差，一般不能			
表	CREATE TABLE	占用物理空间				增删改差				
*/





