DROP TABLE IF EXISTS bookType;
CREATE TABLE bookType(
	id INT PRIMARY KEY,
    name VARCHAR(20)
);

INSERT INTO bookType 
VALUES(9, "Commic");

DESC bookType;

DROP TABLE IF EXISTS Book;
CREATE TABLE Book(
	bid INT PRIMARY KEY,
    bname VARCHAR(20) UNIQUE NOT NULL,
    price FLOAT DEFAULT 10,
    btypeid INT,
    CONSTRAINT fk_bt_id FOREIGN KEY(btypeid) REFERENCES bookType(id)
);
#外键必须是primary key 或 unique
DESC Book;

SET AUTOCOMMIT=0;
INSERT INTO Book(bid, bname, price, btypeid) 
VALUES(1, "One Piece", 33.33, 9); 
COMMIT;

SELECT * FROM Book;



