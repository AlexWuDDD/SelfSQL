#索引三表优化

CREATE TABLE IF NOT EXISTS phone(
	phoneid INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    card INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY(phoneid)
);

INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO phone(card) VALUES(FLOOR(1+(RAND()*20)));

SELECT * FROM phone;

EXPLAIN
SELECT *
FROM class
LEFT JOIN book ON class.card = book.card
LEFT JOIN phone ON book.card = phone.card;

# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, class, , ALL, , , , , 20, 100.00, 
# 1, SIMPLE, book, , ALL, , , , , 20, 100.00, Using where; Using join buffer (Block Nested Loop)
# 1, SIMPLE, phone, , ALL, , , , , 20, 100.00, Using where; Using join buffer (Block Nested Loop)

ALTER TABLE phone ADD INDEX Z(card);
ALTER TABLE book ADD INDEX Y(card);

EXPLAIN
SELECT *
FROM class
LEFT JOIN book ON class.card = book.card
LEFT JOIN phone ON book.card = phone.card;

# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, class, , ALL, , , , , 20, 100.00, 
# 1, SIMPLE, book, , ref, Y, Y, 4, test.class.card, 1, 100.00, Using index
# 1, SIMPLE, phone, , ref, Z, Z, 4, test.book.card, 1, 100.00, Using index


DROP INDEX Y ON book;
DROP INDEX Z ON phone;

#Join语句的优化
/*
尽可能减少Join语句中的NestedLoop的循环总次数：“永远用小结果急驱动大的结果集”。
优先优化NestedLoop的内层循环
保证Join语句中被驱动表上Join条件字段已经被索引
当无法保证被驱动表的Join条件字段被索引且内存资源充足的条件下，不要吝惜JoinBUffer的设置。
*/

















