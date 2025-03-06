-- 기존 테이블 삭제
DROP TABLE IF EXISTS NewBook;

-- 테이블 생성
 CREATE TABLE NewBook(
	bookid INTEGER AUTO_INCREMENT PRIMARY KEY ,
    bookname VARCHAR(100) ,
    publisher VARCHAR(100) ,
    price INTEGER
 );
 
 -- 500만 건 더미데이터 생성 위한 설정
 SET SESSION CTE_MAX_RECURSION_DEPTH = 5000000;
 
 -- 더미데이터 생성
 INSERT INTO NewBook(bookname, publisher, price) 
 WITH RECURSIVE CTE(n) AS
 (
	SELECT 1
    UNION ALL
    SELECT n+1 from CTE WHERE n <5000000
 )
 SELECT CONCAT('Book', lpad(n,7,'0'))   -- Book0002024
		, CONCAT('Company', lpad(n, 7, '0'))
        , FLOOR( 3000 + RAND() * 30000 ) AS price   -- 책가격을 3000원부터 33000원까지
FROM CTE;

-- 데이터 확인
SELECT * FROM NewBook
WHERE price IN (8377,14555,32000,15666,5000,3600,10101);

-- 인덱스 생성
CREATE INDEX idx_book ON NewBook(price);
