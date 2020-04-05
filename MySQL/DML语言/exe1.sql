#exe1
#1 运行一下脚本创建表my_employees
CREATE TABLE my_employees(
	Id INT(10),
    First_name VARCHAR(10),
    Last_name VARCHAR(10),
    Userid VARCHAR(10),
    Salary DOUBLE(10, 2)
);

CREATE TABLE users(
	id INT,
    userid VARCHAR(10),
    department_id INT
);

#2 显示表my_employees的结构
SELECT * FROM my_employees;
DESC my_employees;

#3.向my_employees表中插入下列结构
INSERT INTO my_employees(ID, FIRST_NAME, LAST_NAME, USERID, SALARY)
VALUES
(1, 'patel', 'Ralph', 'Rpatel', 895),
(2, 'Dances', 'Betty', 'Bdancs', 860),
(3, 'Biri', 'Ben', 'Bbiri', 1100),
(4, 'Newman', 'Chad', 'CHewman', 750),
(5, 'Ropeburn', 'Audrey', 'Aropebur', 1550);


#4. 向users表中插入数据
INSERT INTO users(id, userID, department_id)
VALUES
(1, 'Rpatel', 10),
(2, 'Bdancs', 10),
(3, 'Bbiri', 20),
(4, 'Cnewman', 30),
(5, 'Aropebur', 40);

#5. 将3号员工的last_name修改为'drelxer'
UPDATE my_employees
SET Last_name = 'drelxer'
WHERE id = 3;

#6. 将所有工资少于900的员工的工资修改为1000
SELECT * FROM my_employees;
UPDATE my_employees
SET Salary = 1000
WHERE Salary < 1000;
SELECT * FROM my_employees;

#7. 将userid为Bbiri的USER表和my_employees表的记录全部删除
DELETE e, u 
FROM my_employees e
INNER JOIN users u
ON e.Userid = u.userid
WHERE e.Userid = 'Bbiri';

#8. 删除所有的数据
DELETE FROM my_employees;
DELETE FROM users;
#9. 检查所有的修正
SELECT * FROM my_employees;
SELECT * FROM users;
#10.清空表my_employees
TRUNCATE TABLE my_employees;










