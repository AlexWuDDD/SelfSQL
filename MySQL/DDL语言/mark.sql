#标识列
/*
又称自增长列
含义：可以不用手动的插入值，系统提供默认的序列值

特点：
1、标识列必须和主键搭配吗？		不一定，但要求是一个key
2、一个表中可以有几个标识列？	至多1个
3、标识列的类型只能是数值型
4、标识列可以通过SET auto_increment_increment=3;设置步长
5. 标识列可以通过手动插入值来设置起始值
*/
#一、创建表时设置标识列
DROP TABLE IF EXISTS tab_identity;
CREATE TABLE tab_identity(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20)
);
TRUNCATE TABLE tab_identity;

INSERT INTO tab_identity(id, name) VALUES(NULL,'john');
INSERT INTO tab_identity(name) VALUES('lucy');
SELECT * FROM tab_identity;

SHOW VARIABLES LIKE '%auto_increment%';

SET auto_increment_increment=3;


#二、修改表时设置标识列
DROP TABLE IF EXISTS tab_identity;
CREATE TABLE tab_identity(
	id INT,
    name VARCHAR(20),
    seat INT
);
TRUNCATE TABLE tab_identity;
ALTER TABLE tab_identity MODIFY COLUMN id INT PRIMARY KEY AUTO_INCREMENT;

#三、修改表时删除标识列
ALTER TABLE tab_identity MODIFY COLUMN id INT;
DESC tab_identity;



