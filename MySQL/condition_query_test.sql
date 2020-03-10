#2. 查询员工号为176的员工的姓名和部门号和年薪
SELECT
	last_name, department_id, salary*12*(1+ IFNULL(commission_pct, 0)) AS 年薪
FROM
	employees
WHERE
	employee_id = 176;