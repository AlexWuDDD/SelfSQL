CREATE TABLE tblA(
	age INT,
    birth TIMESTAMP NOT NULL
);

INSERT INTO tblA(age, birth) VALUES(22, NOW());
INSERT INTO tblA(age, birth) VALUES(23, NOW());
INSERT INTO tblA(age, birth) VALUES(24, NOW());

CREATE INDEX idx_A_ageBirth ON tblA(age, birth);

SELECT * FROM tblA;

EXPLAIN SELECT * FROM tblA WHERE age > 20 ORDER BY age;

# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, tblA, , index, idx_A_ageBirth, idx_A_ageBirth, 9, , 3, 100.00, Using where; Using index

EXPLAIN SELECT * FROM tblA WHERE age > 20 ORDER BY age, birth;
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, tblA, , index, idx_A_ageBirth, idx_A_ageBirth, 9, , 3, 100.00, Using where; Using index

EXPLAIN SELECT * FROM tblA WHERE age > 20 ORDER BY birth;

# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, tblA, , index, idx_A_ageBirth, idx_A_ageBirth, 9, , 3, 100.00, Using where; Using index; Using filesort

EXPLAIN SELECT * FROM tblA WHERE age > 20 ORDER BY birth, age;
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, tblA, , index, idx_A_ageBirth, idx_A_ageBirth, 9, , 3, 100.00, Using where; Using index; Using filesort

EXPLAIN SELECT *  FROM tblA ORDER BY birth;
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, tblA, , index, , idx_A_ageBirth, 9, , 3, 100.00, Using index; Using filesort

EXPLAIN SELECT *  FROM tblA ORDER BY age ASC, birth DESC;
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, tblA, , index, , idx_A_ageBirth, 9, , 3, 100.00, Using index; Using filesort

EXPLAIN SELECT * FROM tblA WHERE age = 22 ORDER BY birth;
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, tblA, , ref, idx_A_ageBirth, idx_A_ageBirth, 5, const, 1, 100.00, Using where; Using index

