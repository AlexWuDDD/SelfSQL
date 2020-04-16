#TCL
/*
Transcation COntrol Language 事务控制语言
事务：
一个或一组sql语言组成一个执行单元，这个执行单元要么全部执行，要么全部不执行。
案例： 转账
张三丰	1000
郭襄		1000

update 表 set 张三丰的余额=500 where name='张三丰'
意外
update 表 set 郭襄的余额=1500 where name='郭襄'
*/

SHOW ENGINES;

/*
事物的ACID属性
1.原子性(Atomicity):		一个事务不可再分割，要么都执行，要么都不执行
2.一致性(Consistency)：	一个事务执行会使数据从一个一致状态切换到另外一个一致状态
3.隔离性(Isolation)：		一个事务的执行不受其他事务的干扰
4.持久性(Durability)：	一个事务一旦提交，则会永久改变数据库的数据

事物的创建
隐式事务：	事务没有明显的开启和结束的标记
比如insert、update、delete语句

delete from 表 where id = 1;

显式事务：	事务具有明显的开启和结束的标记
前提：必须先设置自动提交动能为禁用

set autocommit = 0;

步骤1：开启事务
set autocommit=0;
start transcation; 可选
步骤2：编写事务中的sql语句(select insert update delete)
语句1;
语句2;
...
步骤3：结束事务
commit;提交事务
rollback;回滚事务


*/

SHOW VARIABLES LIKE 'autocommit';

#演示事务的使用步骤
DROP TABLE IF EXISTS account;
CREATE TABLE account(
	id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(20),
    balance DOUBLE
);

DESC account;
ALTER TABLE account CONVERT TO CHAR SET utf8mb4;
INSERT INTO account(username, balance)
VALUES('张无忌', 1000),('赵敏', 1000);

SELECT * FROM account;

#开启事务
SET AUTOCOMMIT=0;
START TRANSACTION;
#编写一组事务的语句
UPDATE account SET balance=1000 WHERE username='张无忌';
UPDATE account SET balance=1000 WHERE username='赵敏';
#结束事务
#COMMIT;
ROLLBACK;
SELECT * FROM account;

/*
脏读：对于两个事务T1、T2, T1读取了已经被T2更新但还没有被提交的字段之后，若T2回滚，T1读取的内容就是临时且无效的
不可重复读：对于两个事务T1、T2,T1读取了一个字段，然后T2更新了该字段之后，T1再次读取同一字段，值就不同了。
幻读：对于两个事务，T1从一个表中读取了一个字段，然后T2在该表中插入了一些新的字段之后，如果T1再次读取同一个表，就会多出几行。
*/

#delete和truncate在事务使用时的区别
/*
DELETE 支持回滚
TRUNCATE 不支持回滚
*/









