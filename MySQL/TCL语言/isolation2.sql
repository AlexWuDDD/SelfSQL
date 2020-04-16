#isolation2
SELECT @@tx_isolation;

SET session transaction isolation level read uncommitted;

SELECT @@tx_isolation;

USE test;

SELECT * FROM account;

SET autocommit=0;
COMMIT;

SET session transaction isolation level read committed;
SELECT @@tx_isolation;
SELECT * FROM account;

SELECT @@tx_isolation;
SET autocommit=0;
SELECT * FROM account;

