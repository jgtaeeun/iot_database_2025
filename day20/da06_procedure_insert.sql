-- 저장프로시저
-- Book 테이블에 한개의 투플을 삽입하는 프로시저 (288쪽)
delimiter //
CREATE PROCEDURE InsertBook(
	IN mybookid INTEGER,
    IN mybookname VARCHAR(40),
    IN mypublisher VARCHAR(40),
    IN myprice INTEGER)
BEGIN
	INSERT INTO Book VALUES ( mybookid,mybookname,  mypublisher , myprice);
    
END;

-- 프로시저 호출
CALL InsertBook(32, 'BTS PhotoAlbum', '하이브', 300000);
SELECT * FROM Book;

-- 프로시저 삭제
DROP PROCEDURE InsertBook;
SELECT * FROM Book;

