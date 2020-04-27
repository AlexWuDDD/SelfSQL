SELECT * FROM tbl_dept;
SELECT * FROM tbl_emp;

SELECT * 
FROM tbl_emp a
INNER JOIN tbl_dept b
ON a.deptId = b.id;

SELECT * 
FROM tbl_emp a
LEFT JOIN tbl_dept b
ON a.deptId = b.id;

SELECT * 
FROM tbl_emp a
RIGHT JOIN tbl_dept b
ON a.deptId = b.id;

SELECT * 
FROM tbl_emp a
LEFT JOIN tbl_dept b
ON a.deptId = b.id
WHERE b.id IS NULL;

SELECT * 
FROM tbl_emp a
RIGHT JOIN tbl_dept b
ON a.deptId = b.id
WHERE a.deptId IS NULL;

-- SELECT * 
-- FROM tbl_emp a
-- FULL OUTER JOIN tbl_dept b
-- ON a.deptId = b.id;

SELECT *
FROM tbl_emp a
LEFT JOIN tbl_dept b 
ON a.deptId = b.id
UNION
SELECT *
FROM tbl_emp a
RIGHT JOIN tbl_dept b 
ON a.deptId = b.id;

-- SELECT * 
-- FROM tbl_emp a
-- FULL OUTER JOIN tbl_dept b
-- ON a.deptId = b.id
-- WHERE a.deptId IS NULL OR b.id IS NULL;

SELECT *
FROM tbl_emp a
LEFT JOIN tbl_dept b 
ON a.deptId = b.id
WHERE b.id IS NULL
UNION
SELECT *
FROM tbl_emp a
RIGHT JOIN tbl_dept b 
ON a.deptId = b.id
WHERE a.deptId IS NULL;
