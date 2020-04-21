#流程控制经典案例

/*
一、已知表stringcontent
其中字段：
id 自增长
content varchar(20)

向该表插入指定个数的，随机字符串
*/
DROP TABLE IF EXISTS stringcontent;
CREATE TABLE stringcontent(

	id INT PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(20)
);

DESC stringcontent;

DELIMITER $
DROP PROCEDURE IF EXISTS test_randstr_insert $
CREATE PROCEDURE test_randstr_insert(IN nums INT)
BEGIN
	DECLARE i INT DEFAULT 0;
    DECLARE str VARCHAR(26) DEFAULT 'abcdefghijklmnopqrstuvwxyz';
    DECLARE startIndex INT DEFAULT 1;
    DECLARE len INT DEFAULT 1;
    WHILE i < nums DO
		SET startIndex = FLOOR(rand()*26+1);
        SET len = FLOOR(rand()*20+1);
		INSERT INTO stringcontent(content) VALUES(substr(str, startIndex, len));
        SET i = i + 1;
    END WHILE;
END $

CALL test_randstr_insert(5) $


SELECT * FROM stringcontent;