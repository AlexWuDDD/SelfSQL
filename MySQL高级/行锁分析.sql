#建表
CREATE TABLE test_innodb_lock(
	a INT(11), 
    b VARCHAR(16)
)ENGINE=InnoDB;

TRUNCATE TABLE test_innodb_lock;

INSERT INTO test_innodb_lock VALUES(1, 'b2');
INSERT INTO test_innodb_lock VALUES(3, '3');
INSERT INTO test_innodb_lock VALUES(4, '4000');
INSERT INTO test_innodb_lock VALUES(5, '5000');
INSERT INTO test_innodb_lock VALUES(6, '6000');
INSERT INTO test_innodb_lock VALUES(7, '7000');
INSERT INTO test_innodb_lock VALUES(8, '8000');
INSERT INTO test_innodb_lock VALUES(9, '9000');
INSERT INTO test_innodb_lock VALUES(1, 'b1');

SELECT * FROM test_innodb_lock;

CREATE INDEX test_innodb_a_idx ON test_innodb_lock(a);
CREATE INDEX test_innodb_b_idx ON test_innodb_lock(b); 

SHOW INDEX IN test_innodb_lock;

SET AUTOCOMMIT = 0;

UPDATE test_innodb_lock SET b='4001' WHERE a=4;

SELECT * FROM test_innodb_lock;

COMMIT;

UPDATE test_innodb_lock SET b='4002' WHERE a=4;
