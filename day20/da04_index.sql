-- 인덱스
-- DDL로 생성
-- 4-24  Book 테이블의 bookname열을 대상으로 인덱스( ix_Book )을 생성하시오
CREATE INDEX ix_Book 
	ON Book (bookname);
    
-- 4-25  Book 테이블의 publisher, price열을 대상으로 인덱스( ix_Book2 )을 생성하시오
CREATE INDEX ix_Book2
	ON Book (publisher, price);
    
SHOW INDEX FROM Book;

-- 인덱스가 제대로 동작하는지 확인
-- 실행계획(Explain Current Statement) - 인덱스나 조인 등에서 쿼리 중 어디에서 가장 처리비용이 많이 발생하는지

SELECT *
  FROM Book
 WHERE publisher = '대한미디어' 
   AND  price >= 30000;
   
   -- 4.26 Book 테이블의 인덱스를 최적화 하시오
   ANALYZE TABLE Book;