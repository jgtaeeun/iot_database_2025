-- 예제 5-4 Orders 테이블의 판매도서에 대한 이익금을 계산하는 프로시저

delimiter //
CREATE PROCEDURE GetInterest(
)
BEGIN
	-- 변수선언
    DECLARE myInterest INTEGER DEFAULT 0.0;
    DECLARE price INTEGER;
    DECLARE endOfRow BOOLEAN DEFAULT FALSE;
    DECLARE InterestCursor CURSOR FOR
			SELECT saleprice FROM Orders;
	DECLARE CONTINUE handler
			for NOT FOUND SET endOfRow = TRUE;
	-- 커서 오픈
    OPEN InterestCursor;
    cursor_loop : LOOP 
		FETCH InterestCursor INTO price;   -- select saleprice from Orders의 테이블 한 행씩 읽어서 price에 집어 넣는다.
		IF endOfRow THEN LEAVE cursor_loop;		-- python break
    END IF;
        -- 30000D원이상이면 이익이 10%이고, 그 미만이면 5%이다.
    IF price >= 30000 THEN 
			SET myInterest = myInterest + price *0.1 ;
    ELSE 
			SET myInterest = myInterest + price *0.05 ;
		END IF;
        
    END LOOP cursor_loop;
    -- 커서 종료
    CLOSE  InterestCursor;
    
    -- 결과출력
    SELECT CONCAT('전체 이익 금액=' , myInterest  ) AS 'Interset';
END; 

-- 저장 프로시저 실행
CALL GetInterest();