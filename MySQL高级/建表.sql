CREATE TABLE tbl_dept(
	id INT(11) NOT NULL AUTO_INCREMENT,
    deptName VARCHAR(30) DEFAULT NULL,
    locAdd VARCHAR(40) DEFAULT NULL,
    PRIMARY KEY(id)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DESC tbl_dept;

DROP TABLE IF EXISTS tbl_emp;
CREATE TABLE tbl_emp(
	id INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(20) DEFAULT NULL,
    deptId INT(11) DEFAULT NULL,
    PRIMARY KEY(id),
	KEY fk_dept_id(deptid)
    #CONSTRAINT fk_dept_id FOREIGN KEY(deptId) REFERENCES tbl_dept(id)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DESC tbl_emp;

INSERT INTO tbl_dept(deptName, locAdd) VALUES('RD', 11);
INSERT INTO tbl_dept(deptName, locAdd) VALUES('HR', 12);
INSERT INTO tbl_dept(deptName, locAdd) VALUES('MK', 13);
INSERT INTO tbl_dept(deptName, locAdd) VALUES('MIS', 14);
INSERT INTO tbl_dept(deptName, locAdd) VALUES('FD', 15);

SELECT * FROM tbl_dept;

INSERT INTO tbl_emp(name, deptId) VALUES('z3', 1);
INSERT INTO tbl_emp(name, deptId) VALUES('z4', 1);
INSERT INTO tbl_emp(name, deptId) VALUES('z5', 1);
INSERT INTO tbl_emp(name, deptId) VALUES('w5', 2);
INSERT INTO tbl_emp(name, deptId) VALUES('w7', 2);
INSERT INTO tbl_emp(name, deptId) VALUES('s7', 3);
INSERT INTO tbl_emp(name, deptId) VALUES('s8', 4);
INSERT INTO tbl_emp(name, deptId) VALUES('s9', 51);

SELECT * FROM tbl_emp;

SELECT * FROM tbl_dept, tbl_emp;







