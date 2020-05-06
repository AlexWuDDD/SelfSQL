CREATE TABLE test03(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    c1 CHAR(10),
    c2 CHAR(10),
    c3 CHAR(10),
    c4 CHAR(10),
    c5 CHAR(10)
);

INSERT INTO test03(c1, c2, c3, c4, c5) VALUES('a1', 'a2', 'a3', 'a4', 'a5');
INSERT INTO test03(c1, c2, c3, c4, c5) VALUES('b1', 'b2', 'b3', 'b4', 'b5');
INSERT INTO test03(c1, c2, c3, c4, c5) VALUES('c1', 'c2', 'c3', 'c4', 'c5');
INSERT INTO test03(c1, c2, c3, c4, c5) VALUES('d1', 'd2', 'd3', 'd4', 'd5');
INSERT INTO test03(c1, c2, c3, c4, c5) VALUES('e1', 'e2', 'e3', 'e4', 'e5');

SELECT * FROM test03;

CREATE INDEX idex_test03_c1234 ON test03(c1, c2, c3, c4);

SHOW INDEX FROM test03;

#问题，我们创建了复合索引idx_test03_c1234,根据一下SQL分析下索引使用情况
EXPLAIN SELECT * FROM test03 WHERE c1='a1';
EXPLAIN SELECT * FROM test03 WHERE c1='a1' and c2='a2';
EXPLAIN SELECT * FROM test03 WHERE c1='a1' and c2='a2' and c3='a3';
EXPLAIN SELECT * FROM test03 WHERE c1='a1' and c2='a2' and c3='a3' and c4='a4';

EXPLAIN SELECT * FROM test03 WHERE c1='a1' and c2='a2' and c4='a4' and c3='a3';

EXPLAIN SELECT * FROM test03 WHERE c1='a4' and c2='a3' and c4='a2' and c3='a1';

EXPLAIN SELECT * FROM test03 WHERE c1='a1' and c2='a2' and c3>'a3' and c4='a4';

EXPLAIN SELECT * FROM test03 WHERE c1='a1' and c2='a2' and c4>'a4' and c3='a3';

/*
一般性建议
对于单键索引，尽量选择当前针对当前query过滤性更好的索引
在选择组合索引的时候，当前QUERY中过滤性最好的字段在索引字段顺序中，位置越靠前却好
在选择组合索引的时候，尽量选择可以能够包含当前Query的where字句中更多字段的索引
尽可能通过分析统计信息和调整query的写法来达到合适索引的目的
*/

/*
优化总结口诀
全职匹配我最爱，最左前缀要遵守;
带头大哥不能死，中间兄弟要遵守;
索引列上少计算，范围之后全失效;
LIKE百分写最右，覆盖索引不写星;
不等空值还有OR，索引失效要少用。




*/

