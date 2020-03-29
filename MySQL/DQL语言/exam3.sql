#1、查询编号>3的女神的男朋友信息，如果有则列出详细，如果没有，用null填充
SELECT b.id, b.name, b.boyfriend_id, bo.*
FROM beauty b
LEFT OUTER JOIN boys bo
ON b.boyfriend_id = bo.id
WHERE b.id > 3;

# 查询哪个城市没有部门
SELECT city
FROM locations l
LEFT OUTER JOIN departments d
ON l.location_id = d.location_id
AND d.department_name IS NULL;

# 查询部门名为SAL或IT的员工信息
SELECT e.*
FROM employees e
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_name = 'SAL' OR d.department_name = 'IT';