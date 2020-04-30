#索引失效
CREATE TABLE staffs(
	id INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(24) NOT NULL DEFAULT '' COMMENT '姓名',
    age INT NOT NULL DEFAULT 0 COMMENT '年龄',
    pos VARCHAR(20) NOT NULL DEFAULT '' COMMENT '职位',
    add_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入职时间'
)CHARSET utf8mb4 COMMENT '员工记录表';

DESC staffs;

INSERT INTO staffs(NAME, age, pos, add_time) VALUES('z3', 22, 'manager', NOW());
INSERT INTO staffs(NAME, age, pos, add_time) VALUES('July', 23, 'dev', NOW());
INSERT INTO staffs(NAME, age, pos, add_time) VALUES('2000', 23, 'dev', NOW());

SELECT * FROM staffs;

ALTER TABLE staffs ADD INDEX idx_staffs_nameAgePos(NAME, age, pos);


#1.全职匹配我最爱
SHOW INDEX FROM staffs;
EXPLAIN SELECT * FROM staffs WHERE NAME='July';
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, staffs, , ref, idx_staffs_nameAgePos, idx_staffs_nameAgePos, 98, const, 1, 100.00, 
EXPLAIN SELECT * FROM staffs WHERE NAME='July' AND age=23;
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, staffs, , ref, idx_staffs_nameAgePos, idx_staffs_nameAgePos, 102, const,const, 1, 100.00, 
EXPLAIN SELECT * FROM staffs WHERE NAME='July' AND age=23 AND pos='dev';
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, staffs, , ref, idx_staffs_nameAgePos, idx_staffs_nameAgePos, 184, const,const,const, 1, 100.00, 

EXPLAIN SELECT * FROM staffs WHERE age=23 AND pos='dev';
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
#1, SIMPLE, staffs, , ALL, , , , , 3, 33.33, Using where
EXPLAIN SELECT * FROM staffs WHERE pos='dev';
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, staffs, , ALL, , , , , 3, 33.33, Using where

EXPLAIN SELECT * FROM staffs WHERE NAME='July' AND pos='dev';
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, staffs, , ref, idx_staffs_nameAgePos, idx_staffs_nameAgePos, 98, const, 1, 33.33, Using index condition

#2.最佳左前法则
# 如果索引了多列，要遵守最左前缀法则。指的是查询从索引的最左前列开始并且不跳过索引中的列
# 带头大哥不能死

#3.不在索引列上做任何操作（计算、函数、（自动或手动）类型转换），会导致索引失效而转向全表扫描
EXPLAIN SELECT * FROM staffs WHERE LEFT(name, 4) = 'July';
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, staffs, , ALL, , , , , 3, 100.00, Using where

#4.存储引擎不能使用索引中范围条件右边的列
EXPLAIN SELECT * FROM staffs WHERE NAME='July' AND age>25 AND pos='dev';
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, staffs, , range, idx_staffs_nameAgePos, idx_staffs_nameAgePos, 102, , 1, 33.33, Using index condition

#5.尽量使用覆盖索引（只访问索引的查询（索引列和查询列一致）），减少select*
EXPLAIN SELECT * FROM staffs WHERE NAME='July' AND age=23 AND pos='dev';
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, staffs, , ref, idx_staffs_nameAgePos, idx_staffs_nameAgePos, 184, const,const,const, 1, 100.00, 
EXPLAIN SELECT NAME, age, pos FROM staffs WHERE NAME='July' AND age=23 AND pos='dev';
# id, select_type, table, partitions, type, possible_keys, key, key_len, ref, rows, filtered, Extra
# 1, SIMPLE, staffs, , ref, idx_staffs_nameAgePos, idx_staffs_nameAgePos, 184, const,const,const, 1, 100.00, Using index

#6.mysql在使用不等于（！= 或者<>）的时候无法使用索引会导致全表扫描
#7.is null, is not null 也无法使用索引
#8.like以通配符开头（'%abc....'）mysql索引会失效变成全表扫描的操作
#9. 字符串不加单引号索引失效
#10. 少用OR，用它来连接时会索引失效

