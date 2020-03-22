#显示所有员工的姓名、部门号和部门名称
SELECT e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

#查询90号部门员工的job_id和90号部门的location_id
SELECT job_id, location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.department_id = 90;

#选择所有有奖金员工的last_name, department_name, location_id, city
SELECT e.last_name, d.department_name, l.location_id, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id AND d.location_id = l.location_id
AND e.commission_pct IS NOT NULL;

#选择city在Toronto工作的员工的 last_name, job_id, department_id, department_name
SELECT e.last_name, e.job_id, d.department_id, d.department_name
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND l.city = 'Toronto';

#查询每个工种、每个部门的部门名、工种名和最低工资
SELECT d.department_name, j.job_title, MIN(salary)
FROM departments d, jobs j, employees e
WHERE e.job_id = j.job_id
GROUP BY d.department_name, j.job_title;

#查询每个国家下的部门个数数大于2的国家编号
SELECT country_id, COUNT(*)
FROM locations l, departments d
WHERE l.location_id = d.location_id
GROUP BY country_id
HAVING COUNT(*) > 2;

#选择指定员工的姓名，员工号，以及他的管理者的姓名和员工号，结果类似于下面的格式
#employees Emp manager
#kochhar 101 king 100
SELECT e.last_name, e.employee_id, m.last_name, m.employee_id
FROM employees e, employees m
WHERE e.manager_id = m.employee_id
AND e.last_name = 'kochhar';







