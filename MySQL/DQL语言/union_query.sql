#进阶９　联合查询
/*
union 联合　合并：将多条查询语句的结果合并成一个结果

应用场景：
要查询的结果来自多个表，且多个表没有直接的关系，但查询的信息一致

特点：　＊
１．要求多条查询语句的查询列数是一致的
２．要求多条查询语句查询的每一列的类型和顺序最好一致
３．UNION关键字默认去重，　如果使用UNION ALL可以包含重复项
*/
#引入案例：查询部门编号＞９０或者邮箱中包含a的员工信息
SELECT * FROM employees WHERE email LIKE '%a%' OR department_id >90;

SELECT * FROM employees WHERE email LIKE '%a%'
UNION
SELECT * FROM employees WHERE department_id > 90;

#案例：查询中国用户男性的的用户信息以及外国用户中男性的信息


