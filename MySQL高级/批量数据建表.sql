CREATE DATABASE bigData;
USE bigData;

CREATE TABLE dept(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    deptno MEDIUMINT UNSIGNED NOT NULL DEFAULT 0,
    dname VARCHAR(20) NOT NULL DEFAULT "",
    loc VARCHAR(20) NOT NULL DEFAULT ""
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE emp(
	empno INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    ename VARCHAR(20) NOT NULL DEFAULT "",/*名字*/
    job VARCHAR(9) NOT NULL DEFAULT "", /*工作*/
    mgr MEDIUMINT UNSIGNED NOT NULL DEFAULT 0, /*上级编号*/
    hiredata DATE NOT NULL, /*入职时间*/
    sal DECIMAL(7,2) NOT NULL, /*薪水*/
    comm DECIMAL(7,2) NOT NULL, /*红利*/
    deptno MEDIUMINT UNSIGNED NOT NULL DEFAULT 0 /*部门编号*/
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SHOW TABLES;

SHOW VARIABLES LIKE '%log_bin_trust_function_creators%';

### 随机产生字符串
DELIMITER $$
CREATE FUNCTION rand_string(n INT) RETURNS VARCHAR(255)
BEGIN
	DECLARE chars_str VARCHAR(100) DEFAULT 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    DECLARE return_str VARCHAR(255) DEFAULT '';
    DECLARE i INT DEFAULT 0;
    WHILE i < n DO
    SET return_str = CONCAT(return_str, SUBSTRING(chars_str, FLOOR(1+RAND()*52), 1));
    SET i = i + 1;
    END WHILE;
    RETURN return_str;
END $$
### 随机产生部门编号
DELIMITER $$
CREATE FUNCTION rand_num() RETURNS INT(5)
BEGIN
	DECLARE i INT DEFAULT 0;
    SET i = FLOOR(100 + RAND()*10);
    RETURN i;
END $$

#创建存储过程
/*创建往emp表中插入数据的存储过程*/
DROP PROCEDURE IF EXISTS insert_emp;

DELIMITER $$
CREATE PROCEDURE insert_emp(IN START INT(10), IN max_num INT(10))
BEGIN
	DECLARE i INT DEFAULT 0;
    SET AUTOCOMMIT = 0;
    REPEAT
    SET i = i + 1;
    INSERT INTO emp(empno, ename, job, mgr, hiredata, sal, comm, deptno)
    VALUES(START+i, rand_string(6), 'SALESMAN', 0001, CURDATE(), 2000, 400, rand_num());
    UNTIL i = max_num
    END REPEAT;
    COMMIT;
END $$

/*创建往dept表中插入数据的存储过程*/
DELIMITER $$
CREATE PROCEDURE insert_dept(IN START INT(10), IN max_num INT(10))
BEGIN
	DECLARE i INT DEFAULT 0;
    SET AUTOCOMMIT = 0;
    REPEAT
    SET i = i + 1;
    INSERT INTO dept(deptno, dname, loc) VALUES(START+i, rand_string(10), rand_string(8));
    UNTIL i = max_num
    END REPEAT;
    COMMIT;
END $$

#调用存储过程
DELIMITER ;
/*dept*/
CALL insert_dept(100, 10);
SELECT * FROM dept;

/*emp*/
DELIMITER ;
CALL insert_emp(100001, 500000);
SELECT * FROM emp;







