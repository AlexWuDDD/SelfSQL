#分组函数
/*
功能：用作统计使用，又称为聚合函数或统计函数或组函数
分类：
sum, avg, max, min, count计算个数
*/

#1 简单的使用
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT COUNT(salary) FROM employees;

#2 参数类型支持哪些类型
/*
1. sum avg 一般处理数值型
2. max min count 可以处理任何类型
3. 是否忽略null值: 是

*/
SELECT MAX(last_name), MIN(last_name) FROM employees;
SELECT COUNT(commission_pct) FROM employees;
SELECT COUNT(*) FROM employees WHERE commission_pct IS NOT NULL;
SELECT COUNT(*) FROM employees WHERE commission_pct IS NULL;

SELECT SUM(ISNULL(commission_pct) = 0), SUM(ISNULL(commission_pct) != 0) FROM employees;

#3 可以和distince搭配
SELECT SUM(DISTINCT(salary)), SUM(salary) FROM employees;

#4 count函数的详细介绍

SELECT COUNT(salary) FROM employees;

SELECT COUNT(*) FROM employees; #统计行数
SELECT COUNT(1) FROM employees;
SELECT COUNT('常量值') FROM employees;

#效率
#COUNT(*)效率最高

#5 和分组函数一同查询的字段有限制
/*
一般要求是group by 后的字段
*/
