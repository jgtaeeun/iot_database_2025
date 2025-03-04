-- 사용자 정의 함수 , 내장함수의 반대 개념. 개발자가 직접만드는 함수

-- 5-6. 판매된 도서에 대한 이익을 계산하는 함수
DELIMITER //
CREATE FUNCTION fnc_Interest(
	price INTEGER
)	RETURNS INTEGER
	
BEGIN
	DECLARE myInterest INTEGER;
    IF price >= 30000 THEN
		 SET myInterest = price *0.1;
	ELSE SET myInterest =  price *0.05;
    END IF;
    RETURN myInterest;
END;


-- 실행
SELECT custid, orderid, saleprice, fnc_Interest(saleprice) as '이익금'
FROM Orders;