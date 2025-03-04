--  Book테이블에 저장된 도서의 평균 가격을 반환하는 프로시저

delimiter //

-- 파라미터 IN  -값을 프로시저로 전달
-- 파라미터 OUT - 프로시저에서 리턴값을 보내는 매개변수

CREATE PROCEDURE Averageprice(
    OUT Val INTEGER 
)
BEGIN
	SELECT AVG(price) INTO Val 
	  FROM Book WHERE price IS NOT NULL;
END;


-- 프로시저 호출
CALL Averageprice(@myValue);
SELECT @myValue;

SELECT AVG(price)
  FROM Book;
