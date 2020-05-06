SHOW OPEN TABLES;
SELECT * FROM mylock;
UPDATE mylock SET name='a3' WHERE id = 1;

SHOW OPEN TABLES;

UPDATE mylock SET name='a5' WHERE id = 1;