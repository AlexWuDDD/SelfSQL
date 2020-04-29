# 单表分析
CREATE TABLE IF NOT EXISTS article(
	id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    author_id INT(10) UNSIGNED NOT NULL,
    category_id INT(10) UNSIGNED NOT NULL,
    views INT(10) UNSIGNED NOT NULL,
    comments INT(10) UNSIGNED NOT NULL,
    title VARBINARY(255) NOT NULL,
    content TEXT NOT NULL
);

DESC article;
INSERT INTO article(author_id, category_id, views, comments, title, content)VALUES
(1,1,1,1,'1','1'),
(2,2,2,2,'2','2'),
(1,1,3,3,'3','3');

SELECT * FROM article;

#查询category_id为1且comments大于1的情况下，views最多的article_id。
EXPLAIN
SELECT id
FROM article
WHERE category_id = 1 AND comments >1
ORDER BY views DESC
LIMIT 0, 1;

# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# '1', 'SIMPLE', 'article', NULL, 'ALL', NULL, NULL, NULL, NULL, '3', '33.33', 'Using where; Using filesort'

#很显现type是ALL，即最坏的情况。Extra里还出现了using filesort，也是最坏的情况。优化是必须的。

SHOW index FROM article;

# Table, Non_unique, Key_name, Seq_in_index, Column_name, Collation, Cardinality, Sub_part, Packed, Null, Index_type, Comment, Index_comment
# article, 0, PRIMARY, 1, id, A, 3, , , , BTREE, , 

# 开始优化：

#1.1 新建索引 +  删除索引
#ALTER TABLE article ADD INDEX idx_article_ccv(category_id, comments, views);
CREATE INDEX idx_article_ccv ON article(category_id, comments, views);

SHOW INDEX from article;

EXPLAIN
SELECT id
FROM article
WHERE category_id = 1 AND comments >1
ORDER BY views DESC
LIMIT 0, 1;

# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, article, , range, idx_article_ccv, idx_article_ccv, 8, , 1, 100.00, Using where; Using index; Using filesort

# 还是有Using filesort,因此此路不通

DROP INDEX idx_article_ccv ON article;

#1.2 
CREATE INDEX idx_article_cv ON article(category_id, views);
SHOW INDEX from article;

EXPLAIN
SELECT id
FROM article
WHERE category_id = 1 AND comments >1
ORDER BY views DESC
LIMIT 0, 1;

# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, article, , ref, idx_article_cv, idx_article_cv, 4, const, 2, 33.33, Using where



