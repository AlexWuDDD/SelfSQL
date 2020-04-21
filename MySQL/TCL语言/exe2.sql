#一、创建存储过程实现传入用户名和密码，插入到admin表中
DESC admin;

DELIMITER $

CREATE PROCEDURE test_pro1(IN userName VARCHAR(10) CHARSET utf8mb4, 
	IN passWord VARCHAR(10) CHARSET utf8mb4)
BEGIN
	INSERT admin(username, password) VALUES(userName, passWord);
END$

CALL test_pro1('alex', '0513') $

SELECT * FROM admin $

#二、创建存储过程或函数实现传入女神编号， 返回女神名和女神电话

DESC beauty $
DROP PROCEDURE IF EXISTS test_pro2 $
CREATE PROCEDURE test_pro2(IN beautyID INT, 
	OUT beautyName VARCHAR(50) CHARSET utf8mb4,
    OUT beautyPhone VARCHAR(11) CHARSET utf8mb4)
BEGIN
	SELECT name, phone INTO beautyName, beautyPhone
    FROM beauty
    WHERE id = beautyID;
END$    

CALL test_pro2(1, @bn, @bp) $

SELECT @bn, @bp $

#三、创建存储过程或函数实现传入两个女神生日，返回大小
CREATE PROCEDURE test_pro3(IN birthday1 DATETIME, IN birthday2 DATETIME, OUT result INT)
BEGIN

	SELECT DATEDIFF(birthday1, birthday2) INTO result;
END $

CALL test_pro3('1991-5-13','1991-6-7', @ret) $
SELECT @ret $

#四、创建存储过程或函数实现传入一个日期，格式化成xx年xx月xx日并返回
DROP PROCEDURE IF EXISTS test_por4 $
CREATE PROCEDURE test_por4(IN somedate DATETIME, 
	OUT someFormat VARCHAR(20) CHARSET utf8mb4)
BEGIN
	SELECT DATE_FORMAT(somedate, '%y年%m月%d日') INTO someFormat;
END $

CALL test_por4(NOW(), @md) $
    
SELECT @md $    

#五、创建存储过程或函数实现传入女神名称，返回 女神 and 男神

CREATE PROCEDURE test_pro5(IN beautyName VARCHAR(20) CHARSET utf8mb4,
	OUT str VARCHAR(50) CHARSET utf8mb4)
BEGIN
	SELECT CONCAT(beautyName, ' and ', IFNULL(boyName, '')) INTO str
    FROM boys bo
    RIGHT JOIN beauty b ON b.boyfriend_id = bo.id
    WHERE b.name =  beautyName;

END $    

#六、创建查询过程或函数，根据传入的条目数和起始索引，查询beauty表记录
CREATE PROCEDURE test_pro6(IN size INT, IN startIndex INT)
BEGIN
	SELECT * FROM beauty LIMIT startIndex, size;
END $








