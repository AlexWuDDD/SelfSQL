# 索引两表优化
CREATE TABLE IF NOT EXISTS class(
	id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    card INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY(id)
);

DESC class;

CREATE TABLE IF NOT EXISTS book(
	bookid INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    card INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (bookid)
); 

DESC book;

INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO class(card)VALUES(FLOOR(1+(RAND()*20)));

INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));
INSERT INTO book(card)VALUES(FLOOR(1+(RAND()*20)));


SELECT * FROM class;
SELECT * FROM book;

SELECT * FROM book INNER JOIN class ON book.card = class.card;

EXPLAIN
SELECT * FROM class LEFT JOIN book ON class.card = book.card;

# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, class, , ALL, , , , , 20, 100.00, 
# 1, SIMPLE, book, , ALL, , , , , 20, 100.00, Using where; Using join buffer (Block Nested Loop)
#结论：type有ALL

# 添加索引优化
ALTER TABLE book ADD INDEX Y(card);

EXPLAIN
SELECT * FROM class LEFT JOIN book ON class.card = book.card;

# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, class, , ALL, , , , , 20, 100.00, 
# 1, SIMPLE, book, , ref, Y, Y, 4, test.class.card, 1, 100.00, Using index

DROP INDEX Y ON book;

ALTER TABLE class ADD INDEX Y(card);
EXPLAIN
SELECT * FROM class LEFT JOIN book ON class.card = book.card;

# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, class, , index, , Y, 4, , 20, 100.00, Using index
# 1, SIMPLE, book, , ALL, , , , , 20, 100.00, Using where; Using join buffer (Block Nested Loop)

DROP INDEX Y ON class;
/*
可以看到第二行的type变为了ref,rows也变成了优化比较明显。
这是由左连特性决定的。LEFT JOIN条件用于确定如何从右表搜索行，左边一定都有，
所以右边是我们的关键点，一定需要建立索引
*/
SHOW INDEX FROM book;
SHOW INDEX FROM class;

#右连接的的就把index建在左边















