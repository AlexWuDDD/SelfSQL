#exe1
CREATE DATABASE test;
#创建表dept1
CREATE TABLE dept1(
	id INT(7),
    name VARCHAR(25)
);
DESC dept1;

#将表departments中的数据插入新表dept2
CREATE TABLE dept2
SELECT * FROM myemployees.departments;
SELECT * FROM dept2;

#创建表emp5
CREATE TABLE emp5(
	id INT(7),
    First_name VARCHAR(25),
    Last_name VARCHAR(25),
    Dept_id INT(7)
);
DESC emp5;

#将lastname的长度增加到50
ALTER TABLE emp5 MODIFY COLUMN Last_name VARCHAR(50);
DESC emp5;

#根据表myemployees创建表employees2
CREATE TABLE employees2 LIKE myemployees.employees;
DESC employees2;

# 删除表emp5
DROP TABLE IF EXISTS emp5;

#将表employees2重命名为emp5;
ALTER TABLE employees2 RENAME TO emp5;
DESC emp5;

#在表dept和emp5 添加新列test_column,并检查所有操作
ALTER TABLE emp5 ADD COLUMN test_column INT;
DESC emp5;

#直接删除表emp5中的列dept_id
ALTER TABLE emp5 DROP COLUMN department_id;
DESC emp5;




