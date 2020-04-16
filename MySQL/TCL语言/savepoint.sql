/*

*/
#3.演示savepoint 的使用
SELECT * FROM account;
SET autocommit=0;
START TRANSACTION;
DELETE FROM account WHERE id=1;
SAVEPOINT a; #设置保存点
DELETE FROM account WHERE id=4;
ROLLBACK TO a; #回滚到保存点