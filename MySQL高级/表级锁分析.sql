#表级锁分析

CREATE table mylock(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20)
) ENGINE MyISAM;

INSERT INTO mylock(name) VALUES('a');
INSERT INTO mylock(name) VALUES('b');
INSERT INTO mylock(name) VALUES('c');
INSERT INTO mylock(name) VALUES('d');
INSERT INTO mylock(name) VALUES('e');

SELECT * FROM mylock;

# 手动增加表锁
# LOCK TABLES 表名字 read/write, 表名字2 read/write, 其它
# 查看表上加过的锁
SHOW OPEN TABLES;

LOCK TABLE mylock READ;

SHOW OPEN TABLES;

SELECT * FROM mylock;

UPDATE mylock SET name='a2' WHERE id = 1;

SELECT * FROM book;

UNLOCK TABLES;

LOCK TABLE mylock WRITE;
SELECT * FROM mylock;
UPDATE mylock SET name='a4' WHERE id = 1;
SELECT * FROM book;
UNLOCK TABLES;

#如何分析表锁定
/*可以通过检查table_locks_waited和table_locks_immediate状态变量来分析系统上的表锁定*/
SHOW STATUS LIKE 'table%';

/*
Table_locks_immediate: 产生表级锁定的次数，表示可以立即获取锁的查询次数，每立即获取锁值加1;
Table_locks_waited: 出现表级锁定争用而发生等待的次数（不能呢个立即获取锁的次数，每等待一次锁值加1）。此值高则说明存在着较严重的表级锁争用情况。

*/



