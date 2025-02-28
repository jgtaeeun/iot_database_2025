-- 제어
-- 동일한 도서가 있는지 점검한 후 삽입하는 프로시저(290쪽)
delimiter //
CREATE PROCEDURE BookInsertOrUpdate(
		mybookid INTEGER,
        mybookname VARCHAR(40),
        mypublisher VARCHAR(40),
        myprice INTEGER
)
BEGIN
	/*변수선언*/
    DECLARE mycount INTEGER ;
    
    -- 1. 데이터가 존재하는지 파악
    SELECT COUNT(*) INTO mycount
      FROM Book
	 WHERE bookname LIKE CONCAT('%', mybookname , '%');
     
	-- 2. mycount 0보다 크면 동일 도서 존재
    IF mycount >0 THEN
		SET SQL_SAFE_UPDATES = 0 ; /*DELETE나 UPDATE 시, 필요한 설정문*/
		UPDATE Book SET price = myprice 
			WHERE bookname LIKE CONCAT('%', mybookname , '%');
    ELSE
		INSERT INTO Book VALUES (mybookid, mybookname, mypublisher, myprice);
    END IF;

    -- 안전한 업데이트 모드로 복원
    SET SQL_SAFE_UPDATES = 1;
END;

SELECT * FROM Book;
-- 1번째 실행( 존재하는 경우)
CALL  BookInsertOrUpdate(31, 'BTS PhotoAlbum', '하이브' , 400000) 
--2번째 실행( 존재하지 않는 경우)
CALL  BookInsertOrUpdate(35, 'ONOFF PhotoAlbum', 'WM' , 400000) 
