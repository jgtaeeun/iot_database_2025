-- 트랜잭션
-- 테이블 복사
-- CREATE TABLE Orders AS SELECT * FROM madang. Orders;


START TRANSACTION;
INSERT INTO Book  Values(99, '데이터베이스', '한빛', 25000);

SELECT bookname AS 'bookname1' FROM Book WHERE bookid=99;

-- 저장포인트
SAVEPOINT a;

SET SQL_SAFE_UPDATES=0;
UPDATE Book SET bookname = '데이터베이스 개론' WHERE bookid=99;

SELECT bookname AS 'bookname2' FROM Book WHERE bookid=99;
SAVEPOINT b;

UPDATE Book SET bookname = '데이터베이스 개론 및 실습' WHERE bookid=99;

SELECT bookname AS 'bookname3' FROM Book WHERE bookid=99;
ROLLBACK TO b;

SELECT bookname AS 'bookname4' FROM Book WHERE bookid=99;
ROLLBACK TO a;

SELECT bookname AS 'bookname5' FROM Book WHERE bookid=99;
COMMIT;
SET SQL_SAFE_UPDATES=1;

-- START TRANSACTION에서 COMMIT 까지는 트랜잭션이 살아있음
-- SAVEPOINT는 트랜잭션 상에서  ROLLBACK TO로 이동 가능
--  ROLLBACK 전부 취소

START TRANSACTION;

SET SQL_SAFE_UPDATES=0;
UPDATE Book SET bookname = '데이터베이스 개론 및 실습2' WHERE bookid=99;

SELECT bookname AS 'bookname6' FROM Book WHERE bookid=99;
ROLLBACK;

SELECT bookname AS 'bookname7' FROM Book WHERE bookid=99;

DELETE FROM Book WHERE bookid=99;
COMMIT;
