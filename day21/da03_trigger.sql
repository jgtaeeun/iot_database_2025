-- 5-5 신규도서 삽입 후 자동으로 Book_log

-- 시작 전 설정 변경 . 트리거 사용설정
-- 다음버전 MySQL에서는 사라질 예정(Deprecated)

SET GLOBAL log_bin_trust_function_creators = ON;

-- Book_log 테이블을 생성 
-- Book_log테이블은 트리거 작동을 보기 위한 임시테이블

CREATE TABLE Book_log(
	bookid_l INTEGER,
    bookname_l VARCHAR(40),
	publisher_l VARCHAR(40),
    price_l INTEGER
);

-- 트리거 생성 (Book테이블 - Triggers - 생성됨)
-- UPDATE, DELETE 할 때는 old.라고 사용 
-- INSERT일 경우, new.라고 사용

delimiter //
CREATE TRIGGER AfterInsertBook
	AFTER INSERT ON Book For EACH ROW		-- 트리거가 Book테이블에 데이터가 새로 추가되면 바로 발동!
BEGIN
	DECLARE average INTEGER;
    INSERT INTO Book_log
    VALUES (new.bookid, new.bookname, new.publisher, new.price);
END;

-- book테이블에 insert실행
-- 트리거가 실행되어 BOOK_LOG에 자동으로 저장됨
INSERT INTO Book VALUES (40, '말 잘하는 사람은 말투부터 다르다.' , '지니의서재', 18000);
