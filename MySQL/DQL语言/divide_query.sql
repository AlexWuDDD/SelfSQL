#分组查询
/*
select 分组函数， 列（要求出现在group by的后面）
from 表
[where 筛选条件]
group by 分组的列表
[order by]
*/
# group by
#引入： 查询每个部门的平均工资

#案例1：查询每个工种的最高工资
SELECT MAX(salary), job_id 
FROM employees
GROUP BY job_id;

#案例2： 查询每个位置上的部门个数
SELECT COUNT(*), location_id
FROM departments
GROUP BY location_id;

#案例3：查询邮箱中包含a字符的，每个部门的平均工资
SELECT AVG(salary), department_id
FROM employees
WHERE email LIKE '%a%'
GROUP BY department_id;

#案例4：查询有奖金的每个领导手下员工的最高工资
SELECT MAX(salary), manager_id
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY manager_id;

/**********************************/
#案例5：查询哪个部门的员工个数大于2
#1 查询每个部门的员工个数
SELECT COUNT(*), department_id
FROM employees
GROUP BY department_id;
#2 根据1的结果进行筛选，
SELECT COUNT(*), department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*)>2;

#案例6：查询每个工种有奖金的员工的最高工资>12000
SELECT MAX(salary), job_id
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY job_id
HAVING MAX(salary)>12000;

#案例7: 查询领导编号>102的每个领导手下的最低工资>5000的领导编号,以及其最低工资
SELECT MIN(salary), manager_id
FROM employees
WHERE manager_id > 102
GROUP BY manager_id
HAVING MIN(salary)>5000;

#案例8：按员工姓名的长度分组，查询每一组的员工个数,筛选员工个数>5的有
SELECT COUNT(*), LENGTH(last_name)
FROM employees
GROUP BY LENGTH(last_name)
HAVING COUNT(*)>5;

#案例9：查询每个部门每个工种的员工的平均工资
SELECT AVG(salary), job_id, department_id
FROM employees
GROUP BY job_id, department_id;

#案例10： 查询每个部门每个工种的员工的平均工资，并且按平均工资的高低排序
SELECT AVG(salary), job_id, department_id
FROM employees
WHERE department_id IS NOT NULL
GROUP BY job_id, department_id
HAVING AVG(salary)>10000
ORDER BY AVG(salary) DESC;




