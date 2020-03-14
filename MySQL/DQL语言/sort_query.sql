#进阶3： 排序查询
/*
语法：
SELECT 查询列表
FROM 表
[WHERE 筛选条件]
ORDER BY 排序列表 []ASC/DECS]

特点：
1. ASC 升序 DESC 将序
2. 如果不写，默认升序
3. ORDER BY 支持单子/多个字段、表达式、函数、别名
4. ORDER BY 语句一般放在查询语句的最后面， limit除外
*/
#案例1： 查询员工信息，要求工资从高到底排序
SELECT *
FROM employees
ORDER BY salary DESC;

SELECT *
FROM employees
ORDER BY salary ASC;

#案例2：查询部门编号>=90的员工信息，按入职时间的先后进行排序
SELECT 
    *
FROM
    employees
WHERE
    department_id >= 90
ORDER BY hiredate ASC;    

#案例3 [按表达式排序]按年薪的高低显示员工的信息和年薪
SELECT 
    *, salary * 12 * (1 + IFNULL(commission_pct, 0)) AS 年薪
FROM
    employees
ORDER BY salary * 12 * (1 + IFNULL(commission_pct, 0)) DESC;	

#案例4： ORDER BY 支持别名
SELECT 
    *, salary * 12 * (1 + IFNULL(commission_pct, 0)) AS 年薪
FROM
    employees
ORDER BY 年薪 DESC;

#案例5： 按姓名的长度显示员工的姓名和工资[按函数排序]
SELECT 
    last_name, salary
FROM
    employees
ORDER BY LENGTH(last_name) DESC; 

#案例6：查询员工信息，要求先按工资排序，再按员工编号排序
SELECT
	*
FROM
	employees
ORDER BY
	salary, employee_id DESC;



