#查看隔离级别
SELECT @@tx_isolation;

SET session transaction isolation level read uncommitted;

SELECT @@tx_isolation;

USE test;

SELECT * FROM account;

SET autocommit = 0;

UPDATE account set username='john' where id=1;

ROLLBACK;

SET session transaction isolation level read committed;

SET autocommit = 0;
UPDATE account set username='john' where id=1;
COMMIT;
SELECT * FROM account;

SELECT @@tx_isolation;
SET autocommit = 0;
UPDATE account set username='张飞' where id=1;
COMMIT;


SET session transaction isolation level REPEATABLE READ;
SELECT @@tx_isolation;

/*
事务的隔离级别
					脏读		不可重复读	幻读
read uncommitted:	是		是			是
read committed:		否		是			是
repeatable read:	否		否			是
serializable：		否		否			否	
mysql 默认是 repeatable read
oracle 默认是 read committed

查看隔离级别
select @@tx_isolation
设置隔离级别
set session|global transaction isolation level 隔离级别;
	
*/

